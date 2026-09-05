#pragma once

#include "../rc.h"

#include <QString>
#include <functional>

enum FileSource {
    Cache = 0,
    Http
};

using FileCallback = std::function<void(const QString&, Rc, FileSource)>;

class FileProvider {
  public:
    virtual ~FileProvider() = default;

    // @brief Get file from storage/api
    // @param[in] path Http path of file in REST api
    // @param[out] sourceUrl Local url of file which starts with file://
    // @return Return code
    virtual void get(
        const QString& path,
        FileCallback onFile
    )  = 0;
};
