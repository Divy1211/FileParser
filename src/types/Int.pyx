from typing import Literal

from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class Int(ParserType):
    _byte_len = 4
    _signed = True

    @classmethod
    def from_generator(cls, igen: IncrementalGenerator, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> int:
        return cls.from_bytes(igen.get_bytes(cls._byte_len), byteorder)

    @classmethod
    def from_bytes(cls, bytes_: bytes, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> int:
        return int.from_bytes(bytes_, byteorder, signed = cls._signed)

    @classmethod
    def to_bytes(cls, value: int, byteorder: Literal["big", "little"] = "little") -> bytes:
        return int.to_bytes(value, cls._byte_len, byteorder, signed = cls._signed)


cdef class Int8(Int):
    _byte_len = 1

cdef class Int16(Int):
    _byte_len = 2

cdef class Int32(Int):
    _byte_len = 4

cdef class Int64(Int):
    _byte_len = 8

cdef class UInt8(Int):
    _byte_len = 1
    _signed = False

cdef class UInt16(Int):
    _byte_len = 2
    _signed = False

cdef class UInt32(Int):
    _byte_len = 4
    _signed = False

cdef class UInt64(Int):
    _byte_len = 8
    _signed = False
