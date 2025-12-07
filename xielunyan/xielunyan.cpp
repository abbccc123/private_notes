#include "xielunyan.h"
#include <QPainter>
#include <QtMath>
#include <QPainterPath>
#include <QMouseEvent>
#include <QTimer>
#include <QRandomGenerator>

namespace {
    constexpr qint32 WIDTH { 800 };
    constexpr qint32 HEIGHT { 400 };
}

namespace {
    QVector<QGradient::Preset> genGradient() {
        static QVector<QGradient::Preset> arr {
            static_cast<QGradient::Preset>(QRandomGenerator::global()->bounded(16)),
            static_cast<QGradient::Preset>(QRandomGenerator::global()->bounded(16) + 16),
            static_cast<QGradient::Preset>(QRandomGenerator::global()->bounded(16) + 32)
        };
        return arr;
    }
    
    void Tao(QPainter &painter, qreal const outerRadius) {
        const qint32 dist { 50 };
        QPainterPath path;

        path.moveTo(outerRadius, -dist);
        path.arcTo(-outerRadius, -dist - outerRadius, outerRadius * 2, outerRadius * 2, 0, 180);

        path.arcTo(-outerRadius, -dist - outerRadius / 2, outerRadius, outerRadius, 180, -180);
        path.arcTo(0, -dist - outerRadius / 2, outerRadius, outerRadius, 180, 180);

        painter.drawPath(path);
    }
}

XieLunYan::XieLunYan(QWidget *parent):
    QWidget(parent, Qt::FramelessWindowHint | Qt::WindowStaysOnTopHint)
{
    setAttribute(Qt::WA_TranslucentBackground);

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, qOverload<>(&XieLunYan::update));

    move(QRandomGenerator::global()->bounded(2000), QRandomGenerator::global()->bounded(1000));
    timer->start(25);
}

QSize XieLunYan::sizeHint() const
{
    return QSize(WIDTH, HEIGHT);
}

void XieLunYan::paintEvent(QPaintEvent *event)
{
    constexpr qint32 rad { 28 };
    constexpr qint32 step = 2;
    static qint32 tick = 0;

    QPainter painter(this);

    painter.setRenderHint(QPainter::Antialiasing);

    painter.setPen(QPen(Qt::black, 8));
    //painter.setBrush(QGradient(QGradient::HighFlight));
    painter.setBrush(QColor(233, 233, 233, 122));
    painter.drawEllipse(5, 10, WIDTH - 10, HEIGHT - 20);

    painter.translate(width() / 2, height() / 2);
    painter.scale(2, 2);
    painter.setPen(QPen(Qt::black, 4));
    painter.setBrush(QColor(255, 28, 28, 122));
    painter.drawEllipse(-90, -90, 180, 180);

    painter.setBrush(QColor(15, 15, 15, 189));
    painter.drawEllipse(-30, -30, 60, 60);

    auto rot = step * (++tick);
    if (rot % 360 == 0) rot = tick = 0;
    painter.rotate(rot);

    painter.save();
    //painter.translate(0, -45);
    painter.setBrush(QGradient(genGradient()[0]));
    painter.setPen(Qt::NoPen);
    Tao(painter, rad);
    //painter.restore();

    painter.rotate(120);
    painter.setBrush(QGradient(genGradient()[1]));
    Tao(painter, rad);
    //painter.restore();

    painter.rotate(120);
    painter.setBrush(QGradient(genGradient()[2]));
    Tao(painter, rad);

    painter.restore();
}

void XieLunYan::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        m_p = event->globalPosition().toPoint() - geometry().topLeft();
        event->accept();
    }
}

void XieLunYan::mouseMoveEvent(QMouseEvent *event)
{
    if (event->buttons() & Qt::LeftButton) {
        move(event->globalPosition().toPoint() - m_p);
        event->accept();
    }
}
