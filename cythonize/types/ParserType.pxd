from ByteStream cimport ByteStream

cdef class ParserType:
    cpdef bool is_fixed_size(self)
    cpdef bool is_valid(self, value: object)
    cpdef object from_stream(self, ByteStream stream, tuple struct_version)
    cpdef object from_bytes(self, bytes bytes_, tuple struct_version)
    cpdef bytes to_bytes(self, object value)
