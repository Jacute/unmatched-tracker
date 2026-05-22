#include <QPainter>
#include <QPainterPath>
#include <QImage>

#include "imagerounded.h"
#include "../../log.h"

constexpr const char* componentName = "ImageRounded";

ImageRounded::ImageRounded(QQuickItem* parent) : QQuickPaintedItem(parent) {}

QString ImageRounded::getSrc() {
    return src_;
}

void ImageRounded::setSrc(QString s) {
    if (s.startsWith("qrc:/")) {
        s.remove(0, 3);
    }
    log(componentName) << "load image with source " << s;
    if (src_ == s) {
        return;
    }
    src_ = s;

    QImage image(s);
    if (image.isNull()) {
        log(componentName) << "image " << src_ << " cannon be imported";
        return;
    }
    img_ = image;
    
    emit srcChanged();
    update();
}

void ImageRounded::paint(QPainter* painter) {
    painter->setRenderHint(QPainter::Antialiasing, true);

    log(componentName) << "id=" << objectName() << "paint call";

    QRectF rect(0, 0, width(), height());

    QPainterPath path;
    path.addRoundedRect(rect, width()/2, height()/2);

    painter->setClipPath(path);

    painter->drawImage(rect, img_);
}