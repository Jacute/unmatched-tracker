#pragma once

#include "../db/db.h"
#include "../rc.h"

#include <QUrl>

class DbExporter {
  public:
    DbExporter() = default;
    ~DbExporter() = default;

    Rc exportDb(Database& db, const QUrl& to) const;
};
