#pragma once

#include <cstdint>

enum class Rc : uint16_t {
    Ok = 0,
    ErrCreateDb = 1,
    ErrOpenFile = 2,
    ErrExecQuery = 3,
    ErrPrepareQuery = 4
};
