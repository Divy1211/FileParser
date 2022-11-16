from ByteStream cimport ByteStream

cdef class ParserType:
    cpdef bool is_fixed_size(self):
        return False

    cpdef bool is_valid(self, value: object):
        return True

    cpdef object from_stream(self, ByteStream stream, tuple struct_version):
        return None

    cpdef object from_bytes(self, bytes bytes_, tuple struct_version):
        return self.from_stream(bytes_)

    cpdef bytes to_bytes(self, object value):
        return b""
