BUILD_DIR := build

.PHONY: all build check-signing install clean

all: build

build: check-signing
	cmake --build $(BUILD_DIR) --target apk

check-signing:
	@if [ -f "$(BUILD_DIR)/CMakeCache.txt" ] \
		&& grep -Eq '^QT_ANDROID_SIGN_APK(:[^=]+)?=ON$$' "$(BUILD_DIR)/CMakeCache.txt"; then \
		missing=""; \
		[ -n "$${QT_ANDROID_KEYSTORE_PATH:-}" ] || missing="$$missing QT_ANDROID_KEYSTORE_PATH"; \
		[ -n "$${QT_ANDROID_KEYSTORE_ALIAS:-}" ] || missing="$$missing QT_ANDROID_KEYSTORE_ALIAS"; \
		[ -n "$${QT_ANDROID_KEYSTORE_STORE_PASS:-}" ] || missing="$$missing QT_ANDROID_KEYSTORE_STORE_PASS"; \
		[ -n "$${QT_ANDROID_KEYSTORE_KEY_PASS:-}" ] || missing="$$missing QT_ANDROID_KEYSTORE_KEY_PASS"; \
		if [ -n "$$missing" ]; then \
			printf 'Missing exported Android signing variables:%s\n' "$$missing"; \
			exit 1; \
		fi; \
	fi

install:
	adb install $(BUILD_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk

clean:
	rm -rf $(BUILD_DIR)
