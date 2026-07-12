#pragma once

#include <QString>

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
    ErrInvalidStatusCode = 17,
    ErrCreateFile = 18,
};

inline QString rc2str(Rc rc) {
    switch (rc) {
    case Rc::Ok:
        return "ok";
    case Rc::ErrCreateDb:
        return "error create db";
    case Rc::ErrOpenFile:
        return "error open file";
    case Rc::ErrExecQuery:
        return "error execute query";
    case Rc::ErrPrepareQuery:
        return "error prepare query";
    case Rc::ErrDuplicate:
        return "error duplicate";
    case Rc::ErrNotFound:
        return "error not found";
    case Rc::ErrInvalidContentType:
        return "error invalid content type";
    case Rc::ErrCreateCacheDir:
        return "error create cache dir";
    case Rc::ErrReadFile:
        return "error read file";
    case Rc::ErrWriteFile:
        return "error write file";
    case Rc::ErrCommitFile:
        return "error commit file";
    case Rc::ErrRemoveFile:
        return "error remove file";
    case Rc::ErrClearCache:
        return "error clear cache";
    case Rc::ErrInvalidUrl:
        return "error invalid url";
    case Rc::ErrNetworkTimeout:
        return "error network timeout";
    case Rc::ErrNetworkRequest:
        return "error network request";
    case Rc::ErrInvalidStatusCode:
        return "invalid response status code";
    case Rc::ErrCreateFile:
        return "error create file";
    }

    return "error unknown";
}
