#include "ScreenHelper.h"
// Qt
#include <QGuiApplication>
#include <QScreen>

ScreenHelper::ScreenHelper(QObject *parent)
    : QObject(parent)
    , m_DPI(QGuiApplication::primaryScreen()->physicalDotsPerInch())
{

}

qreal ScreenHelper::dp(const qreal &size)
{
#ifdef _WIN32
    return qRound(size * (m_DPI / 90.0));
#else
    return qRound(size * (m_DPI / 160.0));
#endif // _WIN32
}
