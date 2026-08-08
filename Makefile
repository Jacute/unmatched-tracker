BUILD_DIR := build
APK := $(BUILD_DIR)/android-build/build/outputs/apk/debug/android-build-debug.apk
RUNNER := $(BUILD_DIR)/tracker
ADB ?= adb

.PHONY: all build check-signing install run clean

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
		if [ ! -f "$$QT_ANDROID_KEYSTORE_PATH" ]; then \
			printf 'Android keystore does not exist: %s\n' "$$QT_ANDROID_KEYSTORE_PATH"; \
			printf 'Set QT_ANDROID_KEYSTORE_PATH to the real keystore file path.\n'; \
			exit 1; \
		fi; \
		if [ ! -r "$$QT_ANDROID_KEYSTORE_PATH" ]; then \
			printf 'Android keystore is not readable: %s\n' "$$QT_ANDROID_KEYSTORE_PATH"; \
			exit 1; \
		fi; \
	fi

install: build
	@test -f "$(APK)" || { printf 'APK not found: %s\n' "$(APK)"; exit 1; }
	$(ADB) install -r "$(APK)"

run: build
	@test -x "$(RUNNER)" || { printf 'Android runner not found: %s\n' "$(RUNNER)"; exit 1; }
	@test -f "$(APK)" || { printf 'APK not found: %s\n' "$(APK)"; exit 1; }
	"$(RUNNER)" --install --apk "$(abspath $(APK))"

clean:
	rm -rf $(BUILD_DIR)
