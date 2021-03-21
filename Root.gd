extends Spatial



# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_fullscreen = true
	
	var origin = self.get_node("WorldEnvironment/Player").transform.origin
	origin = origin.move_toward(Vector3(0,-1,0), 1.35)
	
	var start = Corridor.new(Corridor.FOUREXIT)
	
	var startScene = start.getNode()
	
	var direction = Corridor.DOWN


	start.setPosition(origin)
	self.add_child(startScene)
	
	var turn = Corridor.new(Corridor.T)
	var t = turn
	turn.setPositionRel(direction, start)
	self.add_child(turn.getNode())
	
	var last = turn
	direction = Corridor.LEFT
	turn = Corridor.new(Corridor.LREV)
	turn.setPositionRel(direction, last)
	self.add_child(turn.getNode())
	last = turn
	
	direction = Corridor.UP

	turn = Corridor.new(Corridor.LREV)
	turn.setPositionRel(direction, last)
	self.add_child(turn.getNode())
	
	
	last = t
	direction = Corridor.RIGHT
	turn = Corridor.new(Corridor.L)
	turn.setPositionRel(direction, last)
	self.add_child(turn.getNode())
	last = turn
	
	direction = Corridor.UP

	turn = Corridor.new(Corridor.L)
	turn.setPositionRel(direction, last)
	self.add_child(turn.getNode())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(_event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
