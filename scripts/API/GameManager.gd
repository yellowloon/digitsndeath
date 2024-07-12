extends Node

@onready var setting = $Settings
@onready var headers = ["Content-type: application/json", "Authorization: Bearer " + setting.api_key]

var messages = []
var request : HTTPRequest
var current_message : String = "Output"

func generate_response(_input):
	request = HTTPRequest.new()
	add_child(request)	
	request.connect("request_completed", _on_request_completed)
	
	dialouge_request(_input)


func dialouge_request(player_dialouge):
	messages.append({
		"role": "user",
		"content": player_dialouge,
		})
	
	var body = JSON.new().stringify({
		"messages": messages,
		"temperature": setting.temperature,
		"max_tokens": setting.max_tokens,
		"model": setting.model
	})
	
	var send_request = request.request(setting.url, headers, HTTPClient.METHOD_POST, body)
	
	if send_request != OK:
		print("There was an error")


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = "empty"
	
	if response.has("choices"):
		message = response["choices"][0]["message"]["content"]
	else:
		message = "NO CONNECTION\n" + str(response)
	
	current_message = message
	print(current_message) # debug log
