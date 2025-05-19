extends Node
class_name State

signal Transitioned(state, new_state_name)

func enter(): pass
func exit(): pass
func Update(_delta): pass
func Physics_Update(_delta): pass
