cdef class ByteStream:
    cdef:
        str name
        bytes content
        int progress
    cpdef ByteStream from_file(self, str file_path)
    cpdef bytes get(self, int num_bytes)
    cpdef bytes peek(self, int num_bytes)
    cpdef bytes remaining(self)
