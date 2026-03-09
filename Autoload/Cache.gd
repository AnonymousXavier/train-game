extends Node

# UI COMPONENTS
const bark_system_component_scene = preload("uid://chdf34evk1waj")
const you_died_scene = preload("uid://q820n30yh2ln")

# UTITLITIES
const train_window_light_scene = preload("uid://u543te2f35nf")


# NPC MODELS
const dead_npc_model = preload("uid://d36xurfnoormt")
const detective_model = preload("uid://batybj4fh3dx3")
const rachael_model = preload("uid://rnbf54uo8sus")
const festus_model = preload("uid://8p4kjlfnxqfg")
const gideon_model = preload("uid://nejvr5lb58en")
const lord_henry_model = preload("uid://c00ihspn10862")
const mainBot_model = preload("uid://dbcgrlqpfq4b8")
const diana_model = preload("uid://c0rqvp4pcvqae")

# NPC DIALOGUES
const npc_dialogue_diana = preload("uid://bko0mq8bpgpjm")
const npc_dialogue_festus = preload("uid://c4qs62uf18ej4")
const npc_dialogue_gideon = preload("uid://nrcr50h8v7xa")
const npc_dialogue_henry = preload("uid://ku2u7bq0k2av")
const npc_dialogue_maidbot = preload("uid://clvsq4mo5clgx")
const npc_dialogue_rachael = preload("uid://ct68lu8cwy7fn")
const npc_dialogue_dead_npc = preload("uid://cd3eynxykidcl")

# DICT CONTAINERS

var npc_dialogues: Dictionary[Enums.NPCS, DialogueResource] = {
	Enums.NPCS.DIANA: npc_dialogue_diana,
	Enums.NPCS.LORD_HENRY: npc_dialogue_henry,
	Enums.NPCS.FESTUS: npc_dialogue_festus,
	Enums.NPCS.GIDEON: npc_dialogue_gideon,
	Enums.NPCS.MAID_BOT: npc_dialogue_maidbot,
	Enums.NPCS.RACHAEL: npc_dialogue_rachael,
	Enums.NPCS.DEAD_NPC: npc_dialogue_dead_npc
}

var npc_models: Dictionary[Enums.NPCS, PackedScene] = {
	Enums.NPCS.DIANA: diana_model,
	Enums.NPCS.LORD_HENRY: lord_henry_model,
	Enums.NPCS.FESTUS: festus_model,
	Enums.NPCS.GIDEON: gideon_model,
	Enums.NPCS.MAID_BOT: mainBot_model,
	Enums.NPCS.RACHAEL: rachael_model,
	Enums.NPCS.DEAD_NPC: dead_npc_model
}
