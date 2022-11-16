from src.errors.ParserError cimport ParserError


cdef class CompressionError(ParserError):
    pass
