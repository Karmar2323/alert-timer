
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
    Q_PROPERTY(bool alarm READ alarm WRITE setAlarm NOTIFY alarmChanged)
public:
    Backend();

    Q_INVOKABLE void startCounting();
    Q_INVOKABLE void stopCounting();
    int defaultTimeout() const;
    int timeLeft() const;


    bool alertTime() const;
    Q_INVOKABLE void setAlertTime(int newAlertTime);

    bool alarm() const;
    void setAlarm(bool newAlarm);

private:
    bool m_counterOn;

    QTimer m_alertCounter;
    QTimer m_timeLeftTimer;

    int m_defaultTimeout = 4000;//1.8e6 + 5000;
    int m_timeLeft = 0;
    int m_alarmDuration = 30000;//1800000;
    bool m_alarm = false; // set true when counter zeroes

    bool counterOn() const;
    void setCounterOn(bool newCounterOn);
    void setAlertCounter(int newValue);
    void setTimeLeft(int newTimeLeft);
    void getTimeLeft();

    void setDefaultTimeout(int newDefaultTimeout);
    void setTimeLeftProperty();

public slots:
    void stopAlarm();
    void soundAlarm();
signals:
    void counterOnChanged();
    void defaultTimeoutChanged();

    void timeLeftChanged();
    void alertTimeChanged();
    void alarmChanged();
};

#endif // BACKEND_H
