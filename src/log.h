#pragma once

#include <QDebug>

/// @brief Creates a debug log stream prefixed with the provided tag.
QDebug ldebug(const char* tag);

/// @brief Creates a warning log stream prefixed with the provided tag.
QDebug lwarn(const char* tag);

/// @brief Creates an info log stream prefixed with the provided tag.
QDebug linfo(const char* tag);

/// @brief Creates a critical error log stream prefixed with the provided tag.
QDebug lerr(const char* tag);
