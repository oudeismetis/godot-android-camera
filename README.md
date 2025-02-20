# Notes for project experiment

UPDATE Jan 2025:
Most Passthrough on most devices doesn't give you API access to the camera
Hopefully that will change
But maybe Android mobile VR will? Likely the first?
If nothing else I got still images working
Maybe I can get that working in VR
Start with just manually triggering the camera for every page turn

(old)
https://docs.godotengine.org/en/stable/tutorials/scripting/gdnative/gdnative_cpp_example.html
(new)
https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_cpp_example.html

```
1. brew install pipx
1. pipx install scons
# TODO - this is old. 3.X version only
1. git clone git@github.com:BastiaanOlij/gdnative_cpp_example.git  # For reference
1. git submodule add -b 4.1 https://github.com/godotengine/godot-cpp
1. git submodule update --init --recursive
1. cd godot-cpp && scons platform=android generate_bindings=yes ANDROID_NDK_ROOT="/System/Volumes/Data/Users/edromano/Library/Android/sdk/cmdline-tools/ndk/21.4.7075529" android_arch=arm64v8
1. cd godot-cpp && scons platform=android generate_bindings=yes ANDROID_NDK_ROOT="/System/Volumes/Data/Users/edromano/Library/Android/sdk/cmdline-tools/ndk/21.4.7075529" android_arch=armv7
```

## TODO
1. Test Android phone connection again
1. update godot-cpp submodule 3.X -> 4.1
1. Finishing running the example to get the dancing logo
1. Pick a better node to extend than Sprite2D
1. Call it from live code running on Android and get "Hello World" text
1. Import tesseract C++ code. Confirm it still runs without error.
1. Call OCR with hardcoded image and display text
1. Replace hardcoded image with live image from phone
