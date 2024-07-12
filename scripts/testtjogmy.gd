extends TextEdit

@onready var gm = %GameManager

func _process(delta):
	%Label.text = gm.current_message

func dostuff():
	gm.generate_response(self.text)
	
