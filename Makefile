QT_HOST_PATH := /home/jacute/qt6/qt/qthostbuild/qtbase
QT_ANDROID_PATH := /home/jacute/qt/qtandroid/build
QT_CMAKE := $(QT_ANDROID_PATH)/bin/qt-cmake

ANDROID_SDK := /home/jacute/Android/Sdk
ANDROID_NDK := $(ANDROID_SDK)/ndk/27.2.12479018

BUILD_ANDROID_DIR := build-android

.PHONY: build build-android install

all: build-android

build-android:
	$(QT_CMAKE) \
    -DANDROID_SDK_ROOT=$(ANDROID_SDK) \
    -DANDROID_NDK_ROOT=$(ANDROID_NDK) \
    -S . -B $(BUILD_ANDROID_DIR) \
    -GNinja
	cmake --build $(BUILD_ANDROID_DIR) --target apk

install:
	adb install $(BUILD_ANDROID_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk