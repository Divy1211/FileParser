from __future__ import annotations

from binary_file_parser import Retriever, BaseStruct
from binary_file_parser.types import bool32, Bytes, uint32, FixedLenStr, str16, float32


class PlayerData1(BaseStruct):
    active: bool = Retriever(bool32, default = False)
    human: bool = Retriever(bool32, default = False)
    civilization: int = Retriever(uint32, default = 43)
    architecture_set: int = Retriever(uint32, default = 43)
    cty_mode: int = Retriever(uint32, default = 4)

    def __init__(self, struct_version: tuple[int, ...] = (1, 47), parent: BaseStruct = None, initialise_defaults = True):
        super().__init__(struct_version, parent, initialise_defaults)


class DataHeader(BaseStruct):
    next_unit_id: int = Retriever(uint32, default = 0)
    version: float = Retriever(float32, default = 1.42)
    tribe_names: list[str] = Retriever(FixedLenStr[256], default = "0"*256, repeat = 16)
    player_name_str_ids: list[int] = Retriever(uint32, default = 4294967294, repeat = 16)
    player_data1: list[PlayerData1] = Retriever(PlayerData1, default = PlayerData1(), repeat = 16)
    lock_civilizations: list[bool] = Retriever(bool32, default = False, repeat = 16)
    unknown: bytes = Retriever(Bytes[9], default = b"\x01"+b"\x00"*8)
    file_name: str = Retriever(str16, default = "MadeWithAoE2SP.aoe2scenario")

    def __init__(self, struct_version: tuple[int, ...] = (1, 47), parent: BaseStruct = None, initialise_defaults = True):
        super().__init__(struct_version, parent, initialise_defaults)
