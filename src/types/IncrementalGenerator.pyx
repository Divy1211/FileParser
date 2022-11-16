from __future__ import annotations


cdef class IncrementalGenerator:
    def __init__(self, name: str, file_content: bytes, progress: int = 0):
        self.name = name
        self.file_content = file_content
        self.progress = progress

    @classmethod
    def from_file(cls, filepath: str) -> IncrementalGenerator:
        cdef bytes file_content
        with open(filepath, 'rb') as f:
            file_content = f.read()
        return cls(filepath, file_content)

    @classmethod
    def from_bytes(cls, bytes_: bytes) -> IncrementalGenerator:
        return cls("_bytes", bytes_)

    cpdef bytes get_bytes(self, int n):
        if n <= 0:
            return b''

        cdef bytes result = self.file_content[self.progress:self.progress + n], remaining
        if not result:
            remaining = len(self.get_remaining_bytes())
            raise EOFError(f"End of file reached. (Requested: {n} bytes, only {remaining} left.)")

        self.progress += n
        return result

    cpdef bytes peek_bytes(self, int n):
        if n <= 0:
            return b''
        cdef bytes result = self.file_content[self.progress:self.progress + n], remaining
        if not result:
            remaining = len(self.get_remaining_bytes())
            raise EOFError(f"End of file reached. (Requested: {n} bytes, only {remaining} left.)")
        return result

    cpdef bytes get_remaining_bytes(self):
        cdef result = self.file_content[self.progress:]
        self.progress = len(self.file_content) - 1
        return result

    def __repr__(self):
        return f"[IncrementalGenerator] Name: {self.name}\n\tProgress: {self.progress}/{len(self.file_content)}"
