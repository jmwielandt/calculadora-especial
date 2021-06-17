extends Control

const MIN_GRADE = 1
const APROVE_GRADE = 4
const MAX_GRADE = 7
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Calculate_pressed():
    var scale_percentage_node = $HBoxContainer/VBoxContainer/HBoxContainer/scale_percentage
    var obtained_score_node = $HBoxContainer/VBoxContainer/obtained_score
    var total_score_node = $HBoxContainer/VBoxContainer/total_score
    var scale_percentage = float(scale_percentage_node.text) / 100
    var obtained_score = float(obtained_score_node.text)
    var total_score = float(total_score_node.text)
    var grade = calc_grade(scale_percentage, total_score, obtained_score)
    if grade == null:
        $HBoxContainer/VBoxContainer/Result.text = "¡Parámetros inválidos!"
    else:
        $HBoxContainer/VBoxContainer/Result.text = str(grade)


func calc_grade(scale, total, obtained):
    var inf_cut = scale * total
    var m
    var n
    if total <= 0 or scale <= 0 or scale == 1:
        # avoid errors
        return null
    if obtained <= inf_cut:
        m = (APROVE_GRADE - MIN_GRADE) / (total * scale)
        n = MIN_GRADE
    else:
        m = (MAX_GRADE - APROVE_GRADE) / (total - total * scale)
        n = APROVE_GRADE - scale * total * m
    var grade = obtained * m + n
    return grade

