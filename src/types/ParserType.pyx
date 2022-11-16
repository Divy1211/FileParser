from __future__ import annotations
from typing import Literal, Any, Type

from src.types.IncrementalGenerator cimport IncrementalGenerator


cdef class ParserType:
    fixed_size = False

    @classmethod
    def is_valid(cls, value: Any) -> tuple[bool, str]:
        return True, ""

    @classmethod
    def from_generator(
        cls, igen: IncrementalGenerator, *, byteorder: Literal["big", "little"] = "little",
        struct_version: tuple[int, ...] = (0,)
    ) -> Any:
        ...

    @classmethod
    def from_bytes(
        cls, bytes_: bytes, *, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)
    ) -> Any:
        ...

    @classmethod
    def to_bytes(cls, value: ParserType, *, byteorder: Literal["big", "little"] = "little") -> bytes:
        ...

ParserTypeObjCls = Type[ParserType] | ParserType
