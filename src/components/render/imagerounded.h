#pragma once

#include <QImage>
#include <QQuickPaintedItem>

class ImageRounded : public QQuickPaintedItem {
    Q_OBJECT

    Q_PROPERTY(QString src READ getSrc WRITE setSrc NOTIFY srcChanged)

  public:
    explicit ImageRounded(QQuickItem *parent = nullptr);
    virtual ~ImageRounded() = default;

    QString getSrc();
    void setSrc(QString s);

    void paint(QPainter *painter) override;

  signals:
    void srcChanged();

  private:
    QString src_;
    QImage img_;
};