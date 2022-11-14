import zlib

from src.sections.Map import Map
from src.sections.Options import Options
from src.sections.ScenarioSections import ScenarioSections
from src.sections.BackgroundImage import BackgroundImage
from src.sections.Cinematics import Cinematics
from src.sections.DataHeader import DataHeader
from src.sections.Diplomacy import Diplomacy
from src.sections.FileHeader import FileHeader
from src.sections.GlobalVictory import GlobalVictory
from src.sections.Messages import Messages
from src.sections.PlayerData2 import PlayerData2

def main():
    scx = ScenarioSections.from_file("default0.aoe2scenario")

    print("FILE HEADER")

    print(scx.file_header.file_version)
    print(scx.file_header.header_len)
    print(scx.file_header.savable)
    print(scx.file_header.timestamp_of_last_save)
    print(scx.file_header.scenario_instructions)
    print(scx.file_header.num_players)
    print(scx.file_header.unknown1)
    print(scx.file_header.unknown2)
    print(scx.file_header.unknowns)
    print(scx.file_header.creator)
    print(scx.file_header.num_triggers)
    print(scx.file_header.struct_version)

    print("DATA HEADER")

    print(scx.data_header.next_unit_id)
    print(scx.data_header.version)
    print(scx.data_header.tribe_names)
    print(scx.data_header.player_name_str_ids)
    print(scx.data_header.player_data1[0].active)
    print(scx.data_header.player_data1[0].human)
    print(scx.data_header.player_data1[0].civilization)
    print(scx.data_header.player_data1[0].architecture_set)
    print(scx.data_header.player_data1[0].cty_mode)
    print(scx.data_header.player_data1[0].struct_version)
    print(scx.data_header.lock_civilizations)
    print(scx.data_header.unknown)
    print(scx.data_header.filename)
    print(scx.data_header.version)

    print("MESSAGES")

    print(scx.messages.instructions_str_id)
    print(scx.messages.hints_str_id)
    print(scx.messages.victory_str_id)
    print(scx.messages.loss_str_id)
    print(scx.messages.history_str_id)
    print(scx.messages.scouts_str_id)
    print(scx.messages.instructions)
    print(scx.messages.hints)
    print(scx.messages.victory)
    print(scx.messages.loss)
    print(scx.messages.history)
    print(scx.messages.scouts)
    print(scx.messages.struct_version)

    print("CINEMATICS")

    print(scx.cinematics.pregame)
    print(scx.cinematics.victory)
    print(scx.cinematics.loss)
    print(scx.cinematics.struct_version)

    print("BACKGROUND IMG")

    print(scx.background_image.filename)
    print(scx.background_image.version)
    print(scx.background_image.width)
    print(scx.background_image.height)
    print(scx.background_image.orientation)
    print(scx.background_image.info_header)
    print(scx.background_image.data)
    print(scx.background_image.version)

    print("PLAYER DATA 2")

    print(scx.player_data_2.strings)
    print(scx.player_data_2.ai_names)
    print(scx.player_data_2.ai_files[15].unknown)
    print(scx.player_data_2.ai_files[15].per_content)
    print(scx.player_data_2.ai_files[15].struct_version)
    print(scx.player_data_2.ai_types)
    print(scx.player_data_2.separator)
    print('pd2')
    for i in range(16):
        print(scx.player_data_2.resources[i].gold)
        print(scx.player_data_2.resources[i].wood)
        print(scx.player_data_2.resources[i].food)
        print(scx.player_data_2.resources[i].stone)
        print(scx.player_data_2.resources[i].ore_x)
        print(scx.player_data_2.resources[i].trade_goods)
        print(scx.player_data_2.resources[i].player_color)
    print(scx.player_data_2.struct_version)

    print("GLOBAL VICTORY")

    print(scx.global_victory.separator)
    print(scx.global_victory.conquest)
    print(scx.global_victory.capture_num_monuments)
    print(scx.global_victory.collect_num_relics)
    print(scx.global_victory.discovery)
    print(scx.global_victory.explore_map_percent)
    print(scx.global_victory.collect_gold)
    print(scx.global_victory.meet_all_conditions)
    print(scx.global_victory.mode)
    print(scx.global_victory.min_score)
    print(scx.global_victory.time_limit)
    print(scx.global_victory.struct_version)

    print("DIPLOMACY")

    print(scx.diplomacy.player_stances)
    print(scx.diplomacy.individual_victories)
    print(scx.diplomacy.separator)
    print(scx.diplomacy.allied_victories)
    print(scx.diplomacy.lock_teams_in_game)
    print(scx.diplomacy.lock_teams_in_lobby)
    print(scx.diplomacy.random_start_points)
    print(scx.diplomacy.max_num_teams)

    print("OPTIONS")

    print(scx.options.disabled_tech_ids)
    print(scx.options.disabled_unit_ids)
    print(scx.options.disabled_building_ids)
    print(scx.options.combat_mode)
    print(scx.options.naval_mode)
    print(scx.options.all_techs)
    print(scx.options.starting_ages)
    print(scx.options.unknown1)
    print(scx.options.ai_map_type)
    print(scx.options.unknown3)
    print(scx.options.base_priorities)
    print(scx.options.unknown2)
    print(scx.options.num_triggers)

    print(scx.map.string_starter1)
    print(scx.map.water_definition)
    print(scx.map.string_starter2)
    print(scx.map.color_mood)
    print(scx.map.string_starter3)
    print(scx.map.script_name)
    print(scx.map.collide_and_correct)
    print(scx.map.villager_force_drop)
    print(scx.map.unknown)
    print(scx.map.lock_coop_alliances)
    print(scx.map.population_caps)
    print(scx.map.unknown3)
    print(scx.map.unknown5)
    print(scx.map.unknown4)
    print(scx.map.no_waves_on_shore)
    print(scx.map.width)
    print(scx.map.height)
    # print(scx.map.tiles)

    with open("default0.aoe2scenario", "rb") as file:
        bts = iter(file.read())

    print("file header")
    for cbyte, byte in zip(FileHeader.to_bytes(scx.file_header), bts):
        if cbyte != byte:
            print(cbyte, byte)

    bts = iter(zlib.decompress(bytes(bts), -zlib.MAX_WBITS))

    print("data header")
    for cbyte, byte in zip(DataHeader.to_bytes(scx.data_header), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("messages")
    for cbyte, byte in zip(Messages.to_bytes(scx.messages), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("cinematics")
    for cbyte, byte in zip(Cinematics.to_bytes(scx.cinematics), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("bkg img")
    for cbyte, byte in zip(BackgroundImage.to_bytes(scx.background_image), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("player data 2")
    for cbyte, byte in zip(PlayerData2.to_bytes(scx.player_data_2), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("global victory")
    for cbyte, byte in zip(GlobalVictory.to_bytes(scx.global_victory), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("diplo")
    for cbyte, byte in zip(Diplomacy.to_bytes(scx.diplomacy), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("options")
    for cbyte, byte in zip(Options.to_bytes(scx.options), bts):
        if cbyte != byte:
            print(cbyte, byte)

    print("map")
    for cbyte, byte in zip(Map.to_bytes(scx.map), bts):
        if cbyte != byte:
            print(cbyte, byte)

if __name__ == "__main__":
    main()
