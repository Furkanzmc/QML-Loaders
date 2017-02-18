#pragma once
#include <QObject>

class ScreenHelper : public QObject
{
    Q_OBJECT

public:
    explicit ScreenHelper(QObject *parent = 0);

    Q_INVOKABLE qreal dp(const qreal &size);

private:
    const qreal m_DPI;

};
