extends Node

@export var api_key : String = ""
@export var url : String = "http://127.0.0.1:8444/v1/chat/completions"
@export var model : String = "claude-3-5-sonnet-20240620"

@export var max_tokens : int = 1024 # remove???
@export var temperature : float = 0.1 # Messes with variability
