#pragma once

#include <QImage>
#include <QQuickPaintedItem>

class ImageRounded : public QQuickPaintedItem {
    Q_OBJECT

    Q_PROPERTY(QString src READ getSrc WRITE setSrc NOTIFY srcChanged)
    Q_PROPERTY(qreal radius READ getRadius WRITE setRadius NOTIFY radiusChanged)

  public:
    explicit ImageRounded(QQuickItem *parent = nullptr);
    virtual ~ImageRounded() = default;

    QString getSrc();
    void setSrc(QString s);
    qreal getRadius();
    void setRadius(qreal s);

    void paint(QPainter *painter) override;

  signals:
    void srcChanged();
    void radiusChanged();

  private:
    QString src_;
    QImage img_;
    qreal radius_;
};