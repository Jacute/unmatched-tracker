#pragma once

#include <QString>

#include "../rc.h"

class FileProvider {
  public:
    virtual ~FileProvider() = default;
    virtual Rc get(const QString& path, QString& sourceUrl) = 0;
};
