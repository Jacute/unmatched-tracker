#pragma once

#include <QString>

#include "../rc.h"

class FileProvider {
  public:
    virtual ~FileProvider() = default;

    // @brief Get file from storage/api
    // @param[in] path Http path of file in REST api
    // @param[out] sourceUrl Local url of file which starts with file://
    // @return Return code
    virtual Rc get(const QString& path, QString& sourceUrl) = 0;
};
