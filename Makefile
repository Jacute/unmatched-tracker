BUILD_DIR := build

.PHONY: all build install clean

all: build

build:
	cmake --build $(BUILD_DIR) --target apk

install:
	adb install $(BUILD_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk

clean:
	rm -rf $(BUILD_DIR)