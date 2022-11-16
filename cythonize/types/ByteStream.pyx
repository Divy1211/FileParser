cdef class ByteStream:
    def __init__(self, content: bytes, progress: int = 0):
        self.content = content
        self.progress = progress

    cpdef ByteStream from_file(self, str file_path):
        with open(file_path, 'rb') as file:
            return ByteStream(file.read())

    cpdef bytes get(self, int num_bytes):
        if num_bytes <= 0:
            return b""

        cdef bytes result = self.content[self.progress:self.progress+num_bytes]
        if not result:
            raise EOFError(f"End of stream reached")
        self.progress += num_bytes
        return result

    cpdef bytes peek(self, int num_bytes):
        if num_bytes <= 0:
            return b""

        cdef bytes result = self.content[self.progress:self.progress + num_bytes]
        if not result:
            raise EOFError(f"End of stream reached")
        return result

    cpdef bytes remaining(self):
        cdef bytes result = self.content[self.progress:]
        self.progress += len(result)
        return result
