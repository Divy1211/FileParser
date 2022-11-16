from src.errors.ParserError cimport ParserError


cdef class VersionError(ParserError):
    pass
