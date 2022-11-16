from src.types.ParserType cimport ParserType


cdef class Int(ParserType):
    pass

cdef class Int8(Int):
    pass

cdef class Int16(Int):
    pass

cdef class Int32(Int):
    pass

cdef class Int64(Int):
    pass

cdef class UInt8(Int):
    pass

cdef class UInt16(Int):
    pass

cdef class UInt32(Int):
    pass

cdef class UInt64(Int):
    pass
