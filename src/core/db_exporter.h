#pragma once

#include "../log.h"

#include "../db/db.h"
#include "../rc.h"

#include <QUrl>

class DbExporter {
  public:
    explicit DbExporter(const Logger& logger) : logger_(logger) {}
    ~DbExporter() = default;

    Rc exportDb(Database& db, const QUrl& to) const;

  private:
    const Logger& logger_;
};
