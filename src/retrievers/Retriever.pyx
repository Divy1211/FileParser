from __future__ import annotations

from typing import Type, Any, Callable, TypeVar

from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.retrievers.MapValidate cimport MapValidate
from src.errors.VersionError cimport VersionError
from src.types.BaseStruct import BaseStruct


def ver_str(ver: tuple[int]) -> str:
    return ".".join(map(str, ver))


T = TypeVar("T")
RetrieverSub = TypeVar("RetrieverSub", bound = "Retriever")
BaseStructSub = TypeVar("BaseStructSub", bound = "BaseStruct")


class Retriever(MapValidate):
    __slots__ = "cls_or_obj", "min_ver", "max_ver", "default", "_repeat", "remaining_compressed", "on_read", "on_write"

    def __init__(
        self,
        cls_or_obj: ParserTypeObjCls,
        min_ver: tuple[int] = (-1,),
        max_ver: tuple[int] = (1000,),
        *,
        default: Any = None,
        repeat: int = 1,
        remaining_compressed: bool = False,
        on_read: list[Callable[[RetrieverSub, BaseStructSub], None]] | None = None,
        on_write: list[Callable[[RetrieverSub, BaseStructSub], None]] | None = None,
        mappers: list[Callable[[RetrieverSub, BaseStructSub, T], T]] | None = None,
        validators: list[Callable[[RetrieverSub, BaseStructSub, Any], tuple[bool, str]]] | None = None,
        on_get: list[Callable[[RetrieverSub, BaseStructSub], None]] | None = None,
        on_set: list[Callable[[RetrieverSub, BaseStructSub], None]] | None = None,
    ):
        super().__init__(mappers, validators, on_get, on_set)
        self.cls_or_obj = cls_or_obj
        self.min_ver = min_ver
        self.max_ver = max_ver
        self.default = default
        self._repeat = repeat
        self.remaining_compressed = remaining_compressed
        self.on_read = on_read or []
        self.on_write = on_write or []

        # if class/object overrides the is_valid method
        # if 'is_valid' in cls_or_obj.__dict__:
        #     if self._repeat == 1:
        #         self.validators.append(cls_or_obj.is_valid)
        #     else:
        #         self.validators.append(lambda iterable: all(map(cls_or_obj.is_valid, iterable)))

    def supported(self, ver: tuple[int, ...]) -> bool:
        return self.min_ver < ver < self.max_ver

    def __set_name__(self, owner: Type[BaseStruct], name: str) -> None:
        super().__set_name__(owner, name)
        owner.add_retriever(self)

    def __set__(self, instance: BaseStruct, value: Any) -> None:
        if not self.supported(instance.struct_version):
            raise VersionError(
                f"{self.p_name!r} is not supported in your scenario version {ver_str(instance.struct_version)!r}"
            )
        super().__set__(instance, value)

    def __get__(self, instance: BaseStruct, owner: Type[BaseStruct]):
        if instance is None:
            return self

        if not self.supported(instance.struct_version):
            raise VersionError(
                f"{self.p_name!r} is not supported in your scenario version {ver_str(instance.struct_version)!r}"
            )
        try:
            return super().__get__(instance, owner)
        except AttributeError:
            if self.default is None:
                raise ValueError(f"No default value specified for retriever {self.p_name!r}")

            if self.repeat(instance) == 1:
                super().__set__(instance, self.default)
                return self.default

            ls = [self.default]*self.repeat(instance)
            super().__set__(instance, ls)
            return ls

    @property
    def r_name(self) -> str:
        return f"_repeat_{self.p_name}"

    def set_repeat(self, instance: BaseStruct, repeat: int) -> None:
        setattr(instance, self.r_name, repeat)

    def repeat(self, instance: BaseStruct) -> int:
        if (repeat := getattr(instance, self.r_name, None)) is not None:
            return repeat
        return self._repeat

    def from_generator(self, instance: BaseStruct, igen: IncrementalGenerator, byteorder: str = "little"):
        if not self.supported(instance.struct_version):
            return

        repeat = self.repeat(instance)
        if repeat == -1:
            setattr(instance, self.p_name, None)
            return

        is_sub_obj = isinstance(self.cls_or_obj, BaseStruct) or type(self.cls_or_obj) is type and issubclass(self.cls_or_obj, BaseStruct)

        if repeat == 1 and not hasattr(instance, self.r_name):
            obj = self.cls_or_obj.from_generator(igen, struct_version = instance.struct_version, byteorder = byteorder)
            if is_sub_obj:
                obj.parent = instance
            setattr(instance, self.p_name, obj)
            return

        ls: list = [None] * repeat
        for i in range(repeat):
            ls[i] = self.cls_or_obj.from_generator(igen, struct_version = instance.struct_version, byteorder = byteorder)
            if is_sub_obj:
                ls[i].parent = instance
        setattr(instance, self.p_name, ls)

        for func in self.on_read:
            func(self, instance)

    def to_bytes(self, instance: BaseStruct, byteorder: str = "little") -> bytes:
        if not self.supported(instance.struct_version):
            return b""

        repeat = self.repeat(instance)
        if repeat == -1:
            return b""

        for func in self.on_write:
            func(self, instance)

        if repeat == 1 and not hasattr(instance, self.r_name):
            return self.cls_or_obj.to_bytes(getattr(instance, self.p_name), byteorder = byteorder)

        ls: list = getattr(instance, self.p_name)

        if self.p_name == "colours":
            print("at", repeat)

        if not len(ls) == repeat:
            raise ValueError(f"length of {self.p_name!r} is not the same as {repeat = }")

        ls: list[bytes] = [b""] * repeat
        for j, value in enumerate(getattr(instance, self.p_name)):
            ls[j] = self.cls_or_obj.to_bytes(value, byteorder = byteorder)

        return b"".join(ls)