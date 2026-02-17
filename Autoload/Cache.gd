extends Node

const female_model_scene = preload("uid://cxdg0qi1ntw28")
const male_model_scene = preload("uid://bg48rw8mdtw8d")


const npc_dialogue_diana = preload("uid://bko0mq8bpgpjm")
const npc_dialogue_festus = preload("uid://c4qs62uf18ej4")
const npc_dialogue_gideon = preload("uid://nrcr50h8v7xa")
const npc_dialogue_henry = preload("uid://ku2u7bq0k2av")
const npc_dialogue_maidbot = preload("uid://clvsq4mo5clgx")
const npc_dialogue_rachael = preload("uid://ct68lu8cwy7fn")

var npc_dialogues: Dictionary[Enums.NPCS, DialogueResource] = {
	Enums.NPCS.DIANA: npc_dialogue_diana,
	Enums.NPCS.LORD_HENRY: npc_dialogue_henry,
	Enums.NPCS.FESTUS: npc_dialogue_festus,
	Enums.NPCS.GIDEON: npc_dialogue_gideon,
	Enums.NPCS.MAID_BOT: npc_dialogue_maidbot,
	Enums.NPCS.RACHAEL: npc_dialogue_rachael
}

var npc_models: Dictionary[Enums.NPCS, PackedScene] = {
	Enums.NPCS.DIANA: female_model_scene,
	Enums.NPCS.LORD_HENRY: male_model_scene,
	Enums.NPCS.FESTUS: male_model_scene,
	Enums.NPCS.GIDEON: male_model_scene,
	Enums.NPCS.MAID_BOT: female_model_scene,
	Enums.NPCS.RACHAEL: female_model_scene
}
