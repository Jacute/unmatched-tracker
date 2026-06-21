#ifndef ASSETS_PROVIDER_H
#define ASSETS_PROVIDER_H

#include <QString>

class AssetsProvider {
  public:
    virtual size_t get(const QString &path, char *out);
};

#endif