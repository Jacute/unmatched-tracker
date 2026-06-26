#include <QImage>
#include <QPainter>
#include <QPainterPath>

#include "../../log.h"
#include "imagerounded.h"

constexpr const char *componentName = "ImageRounded";

ImageRounded::ImageRounded(QQuickItem *parent)
    : QQuickPaintedItem(parent) {
}

QString ImageRounded::getSrc() {
    return src_;
}

void ImageRounded::setSrc(QString s) {
    if (s.startsWith("qrc:/")) {
        s.remove(0, 3);
    }
    if (s.startsWith("file://")) {
        s.remove(0, 7);
    }

    ldebug(componentName) << "load image with source " << s;
    if (src_ == s) {
        return;
    }
    src_ = s;

    QImage image(s);
    if (image.isNull()) {
        ldebug(componentName) << "image " << src_ << " can't be imported";
        return;
    }
    img_ = image;
    radius_ = image.height() / 2; // default radius

    emit srcChanged();
    update();
}

qreal ImageRounded::getRadius() {
    return radius_;
}

void ImageRounded::setRadius(qreal r) {
    radius_ = r;
}

void ImageRounded::paint(QPainter *painter) {
    painter->setRenderHint(QPainter::Antialiasing, true);

    ldebug(componentName) << "id=" << objectName() << "paint call";

    QRectF rect(0, 0, width(), height());

    QPainterPath path;
    path.addRoundedRect(rect, radius_, radius_);

    painter->setClipPath(path);

    painter->drawImage(rect, img_);
}