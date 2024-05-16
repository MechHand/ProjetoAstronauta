class_name DepositArea extends Node3D

signal planets_inside_changed

@onready var store_area: Area3D = $StoreArea

var planets_inside : int = 0


func _on_store_area_body_entered(body: Node3D) -> void:
	if body is NumberPlanet:
		body.is_stored = true
		print(body.name, " has entered ", self.name)
		_update_planets_inside()


func _on_store_area_body_exited(body: Node3D) -> void:
	
	if body is NumberPlanet:
		body.is_stored = false
		print(body.name, " has exited ", self.name)
		_update_planets_inside()
		


func _update_planets_inside() -> void:
	planets_inside = 0
	
	for bodies in store_area.get_overlapping_bodies():
		if bodies is NumberPlanet:
			planets_inside += 1
	
	print(self,name, " contains ", planets_inside)
	planets_inside_changed.emit()
