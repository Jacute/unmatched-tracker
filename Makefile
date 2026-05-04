QT_HOST_PATH ?= $(error QT_HOST_PATH not set in environment)
QT_ANDROID_PATH ?= $(error QT_ANDROID_PATH not set in environment)
QT_CMAKE := $(QT_ANDROID_PATH)/bin/qt-cmake

ANDROID_SDK ?= $(error ANDROID_SDK not set in environment)
ANDROID_NDK := $(ANDROID_SDK)/ndk/27.2.12479018

BUILD_ANDROID_DIR := build-android
CMAKE_INSTALL := $(BUILD_ANDROID_DIR)/cmake_install.cmake

.PHONY: alls build-android install

all: build-android

$(CMAKE_INSTALL):
	$(QT_CMAKE) \
    -DANDROID_SDK_ROOT=$(ANDROID_SDK) \
    -DANDROID_NDK_ROOT=$(ANDROID_NDK) \
    -S . -B $(BUILD_ANDROID_DIR) \
    -GNinja

build-android: $(CMAKE_INSTALL)
	cmake --build $(BUILD_ANDROID_DIR) --target apk

install:
	adb install $(BUILD_ANDROID_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk