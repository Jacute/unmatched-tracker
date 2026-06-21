# Unmatched Tracker

Android app for tracking Unmatched activity

Features:

- Hero & map randomizer
- Statistic tracker

## How to contribute

### Development environment

1. Download Qt sources (minimum version 6.4)
2. Build base Qt
3. Download Android SDK 
4. Configure Qt for your architecture (x86_64/x86/arm64-v8a/armeabi-v7a)
```bash
mkdir -p ~/dev/build-qt-android
cd ~/dev/build-qt-android
<qtbasedir>/configure -prefix <install_qt_dir> -qt-host-path <qthostbuild>/qtbase -android-abis x86_64 -android-sdk <android_sdk_dir> -android-ndk <android_sdk_dir>/ndk/27.2.12479018
```
5. Build and install
```bash
cmake --build . --parallel
cmake --install .
```

### Build project

1. Set variables in ~/.bashrc

QT_HOST_PATH - path to qtbase dir in qt host build 
QT_ANDROID_AMD64_PATH - path to qt android build for architecture amd64 (only for android-amd64 build)
QT_ANDROID_ARM_V8A_PATH - path to qt android build for architecture arm64-v8a (only for android-arm64-v8a build)
ANDROID_SDK - path to android SDK
ANDROID_NDK - path to android NDK

2. Apply .bashrc
```bash
source ~/.bashrc
```

3. Configure project for platform android-33 and arch arm64-v8a

```bash
$QT_CMAKE \
	-DANDROID_SDK_ROOT=$ANDROID_SDK \
	-DANDROID_NDK_ROOT=$ANDROID_NDK \
	-DANDROID_ABI=arm64-v8a \
	-DANDROID_PLATFORM=android-33 \
	-S . -B ./build \
	-GNinja
```

4. Build

```bash
make
```

5. Install via adb

```bash
make install
```

6. Run via adb

```bash
./build/tracker
```
