cdef class IncrementalGenerator:
    cdef public:
        str name
        bytes file_content
        int progress

    cpdef bytes peek_bytes(self, int n)
    cpdef bytes get_bytes(self, int n)
    cpdef bytes get_remaining_bytes(self)
