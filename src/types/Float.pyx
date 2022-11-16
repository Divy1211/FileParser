import struct
from typing import Literal

from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class Float(ParserType):
    _byte_len = 4
    _struct_symbol = 'f'

    @classmethod
    def from_generator(cls, igen: IncrementalGenerator, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> float:
        return cls.from_bytes(igen.get_bytes(cls._byte_len), byteorder)

    @classmethod
    def from_bytes(cls, bytes_: bytes, byteorder: Literal["big", "little"] = "little", struct_version: tuple[int, ...] = (0,)) -> float:
        return struct.unpack(cls._struct_symbol, bytes_)[0]

    @classmethod
    def to_bytes(cls, value: float, byteorder: Literal["big", "little"] = "little") -> bytes:
        return struct.pack(cls._struct_symbol, value)


cdef class Float16(Float):
    _byte_len = 2
    _struct_symbol = 'e'

cdef class Float32(Float):
    _byte_len = 4
    _struct_symbol = 'f'

cdef class Float64(Float):
    _byte_len = 8
    _struct_symbol = 'd'