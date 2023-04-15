
#ifndef BACKEND_H
#define BACKEND_H


#include <QObject>
#include <QTimer>
#include <QQmlEngine>


class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(bool counterOn READ counterOn WRITE setCounterOn NOTIFY counterOnChanged)
    Q_PROPERTY(int defaultTimeout READ defaultTimeout WRITE setDefaultTimeout NOTIFY defaultTimeoutChanged)
    Q_PROPERTY(int timeLeft READ timeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)
public:
    Backend();

    Q_INVOKABLE void startCounting();
    Q_INVOKABLE void stopCounting();
    int defaultTimeout() const;
    int timeLeft() const;


private:
    bool m_counterOn;

    QTimer m_alertCounter;
    QTimer m_timeLeftTimer;
    int m_defaultTimeout = 4000;
    int m_timeLeft;

    bool counterOn() const;
    void setCounterOn(bool newCounterOn);
    void setAlertCounter(int newValue);
    void setTimeLeft(int newTimeLeft);
    void getTimeLeft();

    void setDefaultTimeout(int newDefaultTimeout);
    void setTimeLeftProperty();
signals:
    void counterOnChanged();
    void defaultTimeoutChanged();

    void timeLeftChanged();
};

#endif // BACKEND_H
