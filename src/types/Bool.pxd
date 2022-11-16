from src.types.ParserType cimport ParserType

cdef class Bool(ParserType):
    pass

cdef class Bool8(Bool):
    pass

cdef class Bool16(Bool):
    pass

cdef class Bool32(Bool):
    pass

cdef class Bool64(Bool):
    pass
