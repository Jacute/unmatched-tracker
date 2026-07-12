#ifndef ERRORS_H
#define ERRORS_H

namespace err_profile {
constexpr const char* EmptyName = "empty_name";
constexpr const char* NameTooLong = "name_too_long";
constexpr const char* DuplicateName = "duplicate_name";
constexpr const char* NotFound = "not_found";
} // namespace err_profile

namespace err_game {
constexpr const char* InvalidData = "Invalid data";
constexpr const char* NotFound = "not_found";
} // namespace err_game

namespace err {
constexpr const char* None = "";
constexpr const char* DbError = "db_error";
} // namespace err

#endif
