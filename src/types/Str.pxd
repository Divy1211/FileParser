from src.types.IncrementalGenerator cimport IncrementalGenerator
from src.types.ParserType cimport ParserType


cdef class BaseStr(ParserType):
    pass

cdef class CStr(BaseStr):
    pass

cdef class Str(BaseStr):
    pass

cdef class Str8(Str):
    pass

cdef class Str16(Str):
    pass

cdef class Str32(Str):
    pass

cdef class Str64(Str):
    pass

cdef class NullTermStr(BaseStr):
    pass

cdef class NullTermStr8(NullTermStr):
    pass

cdef class NullTermStr16(NullTermStr):
    pass

cdef class NullTermStr32(NullTermStr):
    pass

cdef class NullTermStr64(NullTermStr):
    pass

cdef class NullTermNonEmptyStr(BaseStr):
    pass

cdef class NullTermNonEmptyStr8(NullTermNonEmptyStr):
    pass

cdef class NullTermNonEmptyStr16(NullTermNonEmptyStr):
    pass

cdef class NullTermNonEmptyStr32(NullTermNonEmptyStr):
    pass

cdef class NullTermNonEmptyStr64(NullTermNonEmptyStr):
    pass

cdef class FixedLenStr(BaseStr):
    cdef int length

    cpdef tuple is_valid(self, str value)
    cpdef str from_generator(self, IncrementalGenerator igen, str byteorder, tuple struct_version)
