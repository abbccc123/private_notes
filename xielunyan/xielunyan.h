
#include <QWidget>


class XieLunYan final : public QWidget {
    Q_OBJECT

public:
    explicit XieLunYan(QWidget *parent = nullptr);

private:
    QSize sizeHint() const override;
    void paintEvent(QPaintEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

    QPoint m_p {};
};
