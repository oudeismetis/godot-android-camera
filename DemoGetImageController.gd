extends Node2D

var imagePlugin
var camera_extension := CameraServerExtension.new()
var cameraPlugin = false
@onready var my_texture: TextureRect = get_node("TextureRect")
@onready var cam_feed: TextureRect = get_node("CamFeed")

func _ready():
	# https://github.com/Lamelynx/GodotGetImagePlugin-Android
	if Engine.has_singleton("GodotGetImage") and false:
		imagePlugin = Engine.get_singleton("GodotGetImage")
		# imagePlugin.connect("image_request_completed", Callable(self, "_set_image"))
		imagePlugin.connect("image_request_completed", _set_image)
		var options = {
			"image_format": "jpg",
			"image_width": 600,
			"image_height": 300,
			"keep_aspect": true
		}
		imagePlugin.setOptions(options)
	else:
		if not camera_extension.permission_granted():
			camera_extension.permission_result.connect(_on_permission_result)
			print("calling for permissions")
			# camera_extension.request_permission()
			OS.request_permissions()
		else:
			print("permissions already granted")
			cameraPlugin = true

func _on_permission_result(granted):
	if not granted:
		print("Camera access permission not granted")
	else:
		print("Permission granted")
		cameraPlugin = true

func _get_gallery_selection():
	if imagePlugin:
		imagePlugin.getGalleryImage()
	elif cameraPlugin:
		_run_camera_logic()
	else:
		print("Button Worked. No plugin available")

func _set_image(dict):
	for image in dict.values():
		var currentImage = Image.new()
		var error = currentImage.load_jpg_from_buffer(image)
		if error != OK:
			print("Failed to load from buffer: ", error)
		print("Loading Image...")
		# await get_tree().process_frame
		# var texture = ImageTexture.new()
		# texture.create_from_image(currentImage) #,0
		# $TextureRect.texture = texture
		# my_texture.texture = texture
		my_texture.texture = ImageTexture.new().create_from_image(currentImage)

func _get_camera():
	if imagePlugin:
		imagePlugin.getCameraImage()
	elif cameraPlugin:
		_run_camera_logic()
	else:
		print("Camera image cannot be taken")

func _run_camera_logic():
	var feed = CameraServer.get_feed(0)
	print("Camera ", feed.get_id(), ": ", feed.get_name(), " (", feed.get_position(), ")")
	feed.set_format(1, {"width": 1024, "height": 768})
	feed.feed_is_active = true
	var camera_texture: CameraTexture = CameraTexture.new()
	camera_texture.camera_feed_id = feed.get_id()
	cam_feed.texture = camera_texture
