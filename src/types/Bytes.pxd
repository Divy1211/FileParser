from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class Bytes(ParserType):
    cdef int num_bytes

    cpdef tuple is_valid(self, bytes value)
    cpdef bytes from_generator(self, IncrementalGenerator igen, str byteorder, tuple struct_version)
    cpdef bytes from_bytes(self, bytes bytes_, str byteorder, tuple struct_version)
    cpdef bytes to_bytes(self, bytes value, str byteorder)
