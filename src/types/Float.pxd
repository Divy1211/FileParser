from src.types.ParserType cimport ParserType


cdef class Float(ParserType):
    pass

cdef class Float16(Float):
    pass

cdef class Float32(Float):
    pass

cdef class Float64(Float):
    pass
