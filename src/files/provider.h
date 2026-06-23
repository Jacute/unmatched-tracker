#pragma once

#include "../api/api.h"
#include "../core/fileprovider.h"
#include "../rc.h"
#include "filecache.h"

class File : public FileProvider {
  private:
    const FileCache& cache_;
    const Api& api_;

  public:
    File(const FileCache&, const Api&);
    ~File() = default;

    Rc get(const QString& path, QString& sourceUrl) override;
};
