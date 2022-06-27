extends Node2D

var imagePlugin

func _ready():
	# https://github.com/Lamelynx/GodotGetImagePlugin-Android
	if Engine.has_singleton("GodotGetImage"):
		imagePlugin = Engine.get_singleton("GodotGetImage")
		imagePlugin.connect("image_request_completed", self, "_set_image")
		var options = {
			"image_format": "jpg",
			"image_width": 50,
			"image_height": 50,
			"keep_aspect": true
		}
		imagePlugin.setOptions(options)

func _get_gallery_selection():
	if imagePlugin:
		imagePlugin.getGalleryImage()
	else:
		print("Button Worked. No plugin available")

func _set_image(dict):
	for image in dict.values():
		var currentImage = Image.new()
		currentImage.load_jpg_from_buffer(image)
		print("Loading Image...")
		yield(get_tree(), "idle_frame")
		var texture = ImageTexture.new()
		texture.create_from_image(currentImage, 0)
		$TextureRect.texture = texture

func _get_camera():
	if imagePlugin:
		imagePlugin.getCameraImage()
	else:
		print("Camera image cannot be take")
