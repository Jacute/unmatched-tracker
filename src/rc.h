#pragma once

#include <cstdint>

enum class Rc : uint16_t {
    Ok = 0,
    ErrCreateDb = 1,
    ErrOpenFile = 2,
    ErrExecQuery = 3,
    ErrPrepareQuery = 4,
    ErrDuplicate = 5,
    ErrNotFound = 6,
    ErrInvalidContentType = 7,
    ErrCreateCacheDir = 8,
    ErrReadFile = 9,
    ErrWriteFile = 10,
    ErrCommitFile = 11,
    ErrRemoveFile = 12,
    ErrClearCache = 13,
    ErrInvalidUrl = 14,
    ErrNetworkTimeout = 15,
    ErrNetworkRequest = 16,
};
