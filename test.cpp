void MyWindow::mousePressEvent(QMouseEvent *e)
{
    const int bw = 8; // 边框宽度
    Qt::Edges edges;

    if (e->pos().x() < bw)             edges |= Qt::LeftEdge;
    if (e->pos().x() > width() - bw)   edges |= Qt::RightEdge;
    if (e->pos().y() < bw)             edges |= Qt::TopEdge;
    if (e->pos().y() > height() - bw)  edges |= Qt::BottomEdge;

    if (edges != Qt::Edges{}) {
        if (windowHandle())
            windowHandle()->startSystemResize(edges);
        return;
    }

    QWidget::mousePressEvent(e);
}
