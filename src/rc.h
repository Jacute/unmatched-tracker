#pragma once

#include <cstdint>

enum class Rc : uint16_t {
    Ok = 0,
    ErrCreateDb = 1,
    ErrCantOpenFile = 2,
    ErrCantExecQuery = 3
};
