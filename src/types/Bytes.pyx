from __future__ import annotations

from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class Bytes(ParserType):
    __slots__ = "num_bytes",

    def __init__(self, num_bytes: int):
        self.num_bytes = num_bytes

    cpdef tuple is_valid(self, bytes value):
        if len(value) == self.num_bytes:
            return True, ""
        return False, f"number of bytes in %s must equal {self.num_bytes}"

    cpdef bytes from_generator(self, IncrementalGenerator igen, str byteorder, tuple struct_version):
        return igen.get_bytes(self.num_bytes)

    cpdef bytes from_bytes(self, bytes bytes_, str byteorder, tuple struct_version):
        return bytes_[:self.num_bytes]

    cpdef bytes to_bytes(self, bytes value, str byteorder):
        return value

    def __class_getitem__(cls, item: int) -> Bytes:
        return cls(item)
