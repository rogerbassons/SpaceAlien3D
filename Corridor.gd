class_name Corridor

enum { FOUREXIT, NORMAL, L, LREV, T, END}
enum { LEFT = 0, UP = 1, RIGHT = 2, DOWN = 3 }

const FOUREXIT_PATH = "res://4exit.res"
const NORMAL_PATH = "res://corridor.res"
const L_PATH = "res://corridorL.res"
const T_PATH = "res://corridorT.res"
const END_PATH = "res://corridorEnd.res"

var _node: Spatial
var _type

func _init(type):
	var path
	match type:
		FOUREXIT:
			path = FOUREXIT_PATH
		NORMAL:
			path = NORMAL_PATH
		L, LREV:
			path = L_PATH
		T:
			path = T_PATH
		END:
			path = END_PATH
			
	_type = type
	_node = load(path).instance()
	
func getNode():
	return _node
	
func getType():
	return _type
	
func getDistance(_orient):
	var dis = 0
	match _type:
		FOUREXIT, L, T, LREV:
			dis = 7
		NORMAL, END:
			dis = 2
	return dis
	
func getPosition():
	return _node.translation

func setPosition(vector: Vector3):
	_node.translate(vector)
	
func rotate(vector: Vector3, deg):
	_node.rotate(vector, deg)
	
func setPositionRel(orient, corridor):
	positionRel(orient, corridor)
	rotateRel(orient)


func positionRel(orient, corridor):
	var dis = self.getDistance(orient)
	var offset = corridor.getDistance(orient)
	
	var origin = corridor.getPosition()
	self._node.translate(origin)
	
	match orient:
		UP:
			self._node.translate(Vector3(0, 0, dis + offset))
		DOWN:
			self._node.translate(Vector3(0, 0,  -dis - offset))
		LEFT:
			self._node.translate(Vector3(dis + offset, 0, 0))
		RIGHT:
			self._node.translate(Vector3(-dis - offset, 0, 0))
func rotateRel(orient):
		match _type:
			NORMAL, END:
				if orient == UP or orient == DOWN:
					_node.rotate(Vector3(0,1,0), PI / 2)
			L, T:
				if orient == UP:
					_node.rotate(Vector3(0,1,0), PI)
				elif orient == RIGHT:
					_node.rotate(Vector3(0,1,0), PI / 2)
				elif orient == LEFT:
					_node.rotate(Vector3(0,1,0), PI * 3 / 2)
			LREV:
				if orient == UP:
					_node.rotate(Vector3(0,1,0), PI * 3 / 2)
				elif orient == RIGHT:
					_node.rotate(Vector3(0,1,0), PI)
				elif orient == DOWN:
					_node.rotate(Vector3(0,1,0), PI / 2)
