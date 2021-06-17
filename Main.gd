extends Control

var Grades = load("res://Grades.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var child_widget
var new_app
# Called when the node enters the scene tree for the first time.
func _ready():
    load_app(0)

func load_app(id):
    child_widget = get_node("VBoxContainer/ChildWidgetContainer")
    for child in child_widget.get_children():
        remove_child(child)
        child.call_deferred("free")
    match id:
        0:
            new_app = Grades.instance()
    child_widget.add_child(new_app)
