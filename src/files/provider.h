#pragma once

#include "../api/api.h"
#include "../core/fileprovider.h"
#include "../rc.h"
#include "filecache.h"

#include <functional>

class File : public FileProvider {
  private:
    const FileCache& cache_;
    Api& api_;

  public:
    File(const FileCache&, Api&);
    ~File() = default;

    //
    void get(
        const QString& path,
        FileCallback onFile
    ) override;

  private:
    Rc getCached(const QString& path, QString& sourceUrl) const;
};
