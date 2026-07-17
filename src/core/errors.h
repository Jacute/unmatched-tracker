// Errors which returns to ui

#pragma once

namespace err_profile {
constexpr const char* EmptyName = "empty_name";
constexpr const char* NameTooLong = "name_too_long";
constexpr const char* DuplicateName = "duplicate_name";
constexpr const char* NotFound = "not_found";
constexpr const char* InvalidId = "invalid_id";
} // namespace err_profile

namespace err_game {
constexpr const char* InvalidData = "Invalid data";
constexpr const char* NotFound = "not_found";
} // namespace err_game

namespace err_randomizer {
constexpr const char* InvalidData = "invalid_data";
constexpr const char* InvalidConfig = "invalid_config";
constexpr const char* StorageError = "storage_error";
constexpr const char* ReadError = "read_error";
constexpr const char* WriteError = "write_error";
} // namespace err_randomizer

namespace err {
constexpr const char* None = "";
constexpr const char* DbError = "db_error";
constexpr const char* SettingsError = "settings_error";
} // namespace err
