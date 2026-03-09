extends Node

var actions_done = 0 ## Sum of all Actions.. Will be used to calculate the day and time of the "moment"
var scene_on_going = false

var chose_to_investigate_scream = false
var has_questioned_festus_before = false

var Checkpoint_One = {
	Enums.CHECKPOINT_ONE.JUST_HEARD_SCREAM: false,
	Enums.CHECKPOINT_ONE.SCREAM_INVESTIGATION_SCENE: false,
	Enums.CHECKPOINT_ONE.INVESTIGATE_DEAD_BODY: false,
	Enums.CHECKPOINT_ONE.MAIDBOT_FINDS_YOU_IN_STORAGE: false
}

var CheckPoints = {
	Enums.CHECKPOINTS.ONE: Checkpoint_One
}
