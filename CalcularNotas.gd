extends MarginContainer

const NOTA_MIN = 1
const NOTA_MAX = 7
const NOTA_APROB = 4

var errors_label
var errors_popup

var escala
var p_total
var p_obtenido

var puntaje_total_edit
var puntaje_total_label
var puntaje_obtenido_edit
var puntaje_obtenido_label

var calcular_button
var label_nota


var vbox_1
var hbox_errors
var hbox_exigencia
var hbox_ptotal
var hbox_pobtenido
var hbox_calcular_nota_button
var hbox_nota_label

func _init():
    init_gui()
    connect_signals()

func init_gui():
    errors_label = Label.new()

    escala = SupremeContainer.new()
    escala.set_text("Escala (% para aprobar)")
    escala.line_edit.text = "60"
    p_total = SupremeContainer.new()
    p_total.set_text("Puntaje total")
    p_obtenido = SupremeContainer.new()
    p_obtenido.set_text("Puntaje obtenido")
    
    calcular_button = Button.new()
    calcular_button.text = "Calcular"
    
    label_nota = Label.new()
    label_nota.text = "-"
    
    anchor_bottom = 1
    anchor_right = 1
    margin_bottom = 10
    margin_left = 10
    margin_right = 10
    margin_top = 10
    
    vbox_1 = VBoxContainer.new()
    hbox_errors = HBoxContainer.new()
    hbox_errors.alignment = BoxContainer.ALIGN_CENTER
    hbox_exigencia = HBoxContainer.new()
    hbox_exigencia.alignment = BoxContainer.ALIGN_CENTER
    hbox_ptotal = HBoxContainer.new()
    hbox_ptotal.alignment = BoxContainer.ALIGN_CENTER
    hbox_pobtenido = HBoxContainer.new()
    hbox_pobtenido.alignment = BoxContainer.ALIGN_CENTER
    hbox_calcular_nota_button = HBoxContainer.new()
    hbox_calcular_nota_button.alignment = BoxContainer.ALIGN_CENTER
    hbox_nota_label = HBoxContainer.new()
    hbox_nota_label.alignment = BoxContainer.ALIGN_CENTER
    
    add_child(vbox_1)
    vbox_1.add_constant_override("separation", 20)
    vbox_1.add_child(hbox_errors)
    vbox_1.add_child(hbox_exigencia)
#    vbox_1.add_child(HSeparator.new())
    vbox_1.add_child(hbox_ptotal)
    vbox_1.add_child(hbox_pobtenido)
    vbox_1.add_child(hbox_calcular_nota_button)
    vbox_1.add_child(hbox_nota_label)
    
    hbox_errors.add_child(errors_label)
    hbox_exigencia.add_child(escala)
    hbox_ptotal.add_child(p_total)
    
    hbox_pobtenido.add_child(p_obtenido)
    
    hbox_calcular_nota_button.add_child(calcular_button)
    
    hbox_nota_label.add_child(label_nota)

func connect_signals():
    calcular_button.connect("pressed", self, "_calcular_nota_pressed")


func _calcular_nota_pressed():
    errors_label.text = ""
    var nota = calc_nota()
    if nota == null:
        errors_label.text = "Parámetros incorrectos!"
        label_nota.text = "-"
    else:
        label_nota.text = str(nota)


func calc_nota():
    var po = float(p_obtenido.line_edit.text)
    var pt = float(p_total.line_edit.text)
    var es = float(escala.line_edit.text) / 100
#    print(po, " ", pt, " ", es)
    var corte_inf = es * pt
    var m
    var n
    if pt <= 0 or es <= 0 or es == 1:
        # evitar errores
        return null
    if po <= corte_inf:
        m = (NOTA_APROB - NOTA_MIN)/(pt * es)
        n = NOTA_MIN - 0 * m
    else:
        m = (NOTA_MAX - NOTA_APROB)/(pt - pt * es)
        n = NOTA_APROB - es * pt * m
#    print("M: ", m)
#    print("N: ", n)
    var nota = po * m + n
    return nota


class SupremeContainer extends VBoxContainer:
    var hbox1
    var hbox2
    var label
    var line_edit
    
    func _init():
        hbox1 = HBoxContainer.new()
        hbox1.alignment = BoxContainer.ALIGN_CENTER
        hbox2 = HBoxContainer.new()
        hbox2.alignment = BoxContainer.ALIGN_CENTER
        label = Label.new()
        line_edit = LineEdit.new()
        add_child(hbox1)
        add_child(hbox2)
        hbox1.add_child(label)
        hbox2.add_child(line_edit)
        add_constant_override("separation", 10)
    
    func set_text(texto):
        label.text = texto
