extends RigidBody

export(String, "Tahta", "Çim", "Metal", "Çakıl") var ses_bicim = "Tahta"
#Tahta = Wood
#Çim = Grass
#Metal = Metal
#Çakıl = Dirt
onready var ses_node = get_node("Sesler")

var ses_sec_yuru # select sound walk | yürüme sesi seç
var ses_sec_kos # select sound run | koşma sesi seç

var X = 0.00
var Y = 0.00

var yurume_hiz = 0.1 #Player walk speed | Oyuncu Yürüme Hızı
var kosma_hiz = 0.2 #Player run speed | Oyuncu Koşma Hızı
var ziplama_gucu = 5 #Player jump speed | Oyuncu Zıplama Hızı

func _ready():
	if ses_bicim == "Tahta":
		ses_sec_yuru = "wood_tahta"
		ses_sec_kos = "run_wood_kos_tahta"
	elif ses_bicim == "Çim":
		ses_sec_yuru = "grass_cim"
		ses_sec_kos = "run_grass_kos_cim"
	elif ses_bicim == "Metal":
		ses_sec_yuru = "metal"
		ses_sec_kos = "run_metal_kos_metal"
	elif ses_bicim == "Çakıl":
		ses_sec_yuru = "dirt_cakil"
		ses_sec_kos = "run_dirt_kos_cakil"
	else:
		ses_sec_yuru = "wood_tahta"
		ses_sec_kos = "run_wood_kos_tahta"
	
	#Hide and capture mouse | Fare simgesini sakla ve izle
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_fixed_process(true)
	set_process_input(true)


func _fixed_process(delta):
	get_node("Camera/silah/imlec").set_translation(Vector3(0,0,-7))
	#Player movement | Oyuncu Hareketleri
	if Input.is_key_pressed(KEY_W):
		if Input.is_key_pressed(KEY_SHIFT):
			translate(Vector3(0, 0, -kosma_hiz))
		translate(Vector3(0, 0, -yurume_hiz))
	if Input.is_key_pressed(KEY_S):
		translate(Vector3(0, 0, yurume_hiz))
	if Input.is_key_pressed(KEY_A):
		translate(Vector3(-yurume_hiz, 0, 0))
	if Input.is_key_pressed(KEY_D):
		translate(Vector3(yurume_hiz, 0, 0))
	
	#Player jump (RigidBdy2D Contact Monitor = Open | Contact Reported = 1)
	#Oyuncu zıplaması (RigidBdy2D Contact Monitor = Açık | Contact Reported = 1)
	if Input.is_key_pressed(KEY_SPACE):
		var dokunanlar = get_colliding_bodies() #get bodies | dokunanları al
		for dokunan in dokunanlar: # get body in bodies | dokunanların herbirini dokunan olarak al
			set_linear_velocity(Vector3(0,ziplama_gucu,0))

func _input(event):
	# Sound Effects Walk, Run | Ses Olayları Yürüme, Koşma
	if event.type == InputEvent.KEY:
		if Input.is_key_pressed(KEY_W) and event.pressed and not event.is_echo():
			ses_node.play(ses_sec_yuru)
			if Input.is_key_pressed(KEY_SHIFT) and event.pressed and not event.is_echo():
				ses_node.stop_all()
				ses_node.play(ses_sec_kos)
		elif event.scancode == KEY_SHIFT and event.pressed == false:
			ses_node.stop_all()
			ses_node.play(ses_sec_yuru)
		elif event.scancode == KEY_W and event.pressed == false:
			ses_node.stop_all()
		if Input.is_key_pressed(KEY_S) and event.pressed and not event.is_echo():
			ses_node.play(ses_sec_yuru)
		elif event.scancode == KEY_S and event.pressed == false:
			ses_node.stop_all()
		if Input.is_key_pressed(KEY_A) and event.pressed and not event.is_echo():
			ses_node.play(ses_sec_yuru)
		elif event.scancode == KEY_A and event.pressed == false:
			ses_node.stop_all()
		if Input.is_key_pressed(KEY_D) and event.pressed and not event.is_echo():
			ses_node.play(ses_sec_yuru)
		elif event.scancode == KEY_D and event.pressed == false:
			ses_node.stop_all()
			
	#Camera motion | Kamera hareketleri
	if event.type == InputEvent.MOUSE_MOTION:
		X += event.relative_x*0.005
		self.set_rotation(Vector3(0, -X, 0))
		
		Y += event.relative_y*0.005
		if(not Y > 1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = 1.5
		if(not Y < -1.5):
			get_node("Camera").set_rotation(Vector3(-Y,0,0))
		else:
			Y = -1.5
		#Show mouse | Fareyi ekranda göster
		if Input.is_key_pressed(KEY_ESCAPE):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
