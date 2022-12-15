from __future__ import annotations

from src import Retriever
from src import Array32
from binary_file_parser.retrievers.BaseStruct import BaseStruct
from binary_file_parser.types.Bool import bool32
from binary_file_parser.types.Bytes import Bytes
from binary_file_parser.types.Str import str32, str16, nt_str32


class AiFile2(BaseStruct):
    file_name: str = Retriever(nt_str32, default = "")
    per_content: str = Retriever(nt_str32, default = "")

    def __init__(self, struct_version: tuple[int, ...] = (1, 47), parent: BaseStruct = None, initialise_defaults = True):
        super().__init__(struct_version, parent, initialise_defaults)

class FileData(BaseStruct):
    @staticmethod
    def set_ai_files_repeat(retriever: Retriever, instance: FileData):
        if not instance.ai_files_present:
            FileData.ai_files.set_repeat(instance, 0)

    @staticmethod
    def update_ai_files_present(retriever: Retriever, instance: FileData):
        instance.ai_files_present = len(instance.ai_files) > 0

    script_file_path: str = Retriever(str16, default = "")
    script_file_content: str = Retriever(str32, default = "")
    ai_files_present: bool = Retriever(bool32, default = False, on_set = [set_ai_files_repeat], on_write = [update_ai_files_present])
    unknown4: bytes = Retriever(Bytes[4], default = b"\x00"*4)
    ai_files: list[AiFile2] = Retriever(Array32[AiFile2], default = [], repeat = 0)

    def __init__(self, struct_version: tuple[int, ...] = (1, 47), parent: BaseStruct = None, initialise_defaults = True):
        super().__init__(struct_version, parent, initialise_defaults)
