extends MenuButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var popup
# Called when the node enters the scene tree for the first time.
func _ready():
    popup = get_popup()
    popup.connect("id_pressed", self, "options_menu")
    
    pass # Replace with function body.

func options_menu(id):
    get_parent().get_parent().get_parent().load_app(id)
    print(id)
    match id:
        0:
            print("ESTOY EN 1")
            pass
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
