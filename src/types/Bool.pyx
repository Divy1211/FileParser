from typing import Literal

from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class Bool(ParserType):
    _byte_len = 1

    @classmethod
    def from_generator(cls, igen: IncrementalGenerator, *, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> bool:
        return cls.from_bytes(igen.get_bytes(cls._byte_len), byteorder = byteorder)

    @classmethod
    def from_bytes(cls, bytes_: bytes, *, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> bool:
        return bool(int.from_bytes(bytes_, byteorder, signed = False))

    @classmethod
    def to_bytes(cls, value: bool, *, byteorder: Literal["big", "little"] = "little") -> bytes:
        return int.to_bytes(int(value), cls._byte_len, byteorder, signed = False)


cdef class Bool8(Bool):
    _byte_len = 1

cdef class Bool16(Bool):
    _byte_len = 2

cdef class Bool32(Bool):
    _byte_len = 4

cdef class Bool64(Bool):
    _byte_len = 8
