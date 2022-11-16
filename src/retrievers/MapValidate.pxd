cdef class MapValidate:
    cdef public:
        str p_name
        str s_name
        list mappers
        list validators
        list on_get
        list on_set