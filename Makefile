QT_HOST_PATH ?= $(error QT_HOST_PATH not set in environment)
QT_ANDROID_AMD64_PATH ?= $(error QT_ANDROID_AMD64_PATH not set in environment)
QT_ANDROID_ARM_V8A_PATH ?= $(error QT_ANDROID_ARM_V8A_PATH not set in env)
QT_CMAKE_ARM_V8A := $(QT_ANDROID_ARM_V8A_PATH)/bin/qt-cmake
QT_CMAKE_AMD64 := $(QT_ANDROID_AMD64_PATH)/bin/qt-cmake

ANDROID_SDK ?= $(error ANDROID_SDK not set in environment)
ANDROID_NDK := $(ANDROID_SDK)/ndk/27.2.12479018
ANDROID_PLATFORM := android-31

BUILD_ANDROID_AMD64_DIR := build-android-amd64
BUILD_ANDROID_ARM_v8A_DIR := build-android-arm64-v8a
CMAKE_INSTALL := $(BUILD_ANDROID_DIR)/cmake_install.cmake

.PHONY: all android-amd64 android-arm64-v8a install clean

all: android-amd64

$(BUILD_ANDROID_AMD64_DIR):
	$(QT_CMAKE_AMD64) \
    -DANDROID_SDK_ROOT=$(ANDROID_SDK) \
    -DANDROID_NDK_ROOT=$(ANDROID_NDK) \
    -DANDROID_ABI=x86_64 \
    -DANDROID_PLATFORM=$(ANDROID_PLATFORM) \
    -S . -B $(BUILD_ANDROID_AMD64_DIR) \
    -GNinja

$(BUILD_ANDROID_ARM_v8A_DIR):
	$(QT_CMAKE_ARM_V8A) \
    -DANDROID_SDK_ROOT=$(ANDROID_SDK) \
    -DANDROID_NDK_ROOT=$(ANDROID_NDK) \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=$(ANDROID_PLATFORM) \
    -S . -B $(BUILD_ANDROID_ARM_v8A_DIR) \
    -GNinja

android-amd64: $(BUILD_ANDROID_AMD64_DIR)
	cmake --build $(BUILD_ANDROID_AMD64_DIR) --target apk

android-arm64-v8a: $(BUILD_ANDROID_ARM_v8A_DIR)
	cmake --build $(BUILD_ANDROID_ARM_v8A_DIR) --target apk

install:
	adb install $(BUILD_ANDROID_AMD64_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk

clean:
	rm -rf $(BUILD_ANDROID_AMD64_DIR)
