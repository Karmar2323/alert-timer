
#ifndef BACKEND_H
#define BACKEND_H


#include <QObject>
#include <QTimer>
#include <QQmlEngine>
#include <QString>
#include <QJsonObject>
#include <QPointer>

#include "filehandler.h"

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(bool counterOn READ counterOn WRITE setCounterOn NOTIFY counterOnChanged)
    Q_PROPERTY(int defaultTimeout READ defaultTimeout WRITE setDefaultTimeout NOTIFY defaultTimeoutChanged)
    Q_PROPERTY(int timeLeft READ timeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)
    Q_PROPERTY(bool alarm READ alarm WRITE setAlarm NOTIFY alarmChanged)
    Q_PROPERTY(int alarmDuration READ alarmDuration WRITE setAlarmDuration NOTIFY alarmDurationChanged)
public:
    Backend();

    Q_INVOKABLE void startCounting();
    Q_INVOKABLE void stopCounting();
    int defaultTimeout() const;
    int timeLeft() const;
    int m_alarmDuration = 30000;

    bool alertTime() const;
    Q_INVOKABLE void setAlertTime(int newAlertTime);

    bool alarm() const;
    void setAlarm(bool newAlarm);

    int alarmDuration() const;
    Q_INVOKABLE bool findLED(QString propsPath = "");

    QString getLedAddress() const;
    void setLedAddress(const QString &newLedAddress);

    Q_INVOKABLE bool getLedStatus() const;
    void setLedStatus(bool newLedStatus);

private:
    bool m_counterOn;

    QTimer m_alertCounter;
    QTimer m_timeLeftTimer;
    QString m_corePropsPath;
    QString m_ledAddress;
    quint16 m_port;

    bool m_ledStatus = true;
    int m_defaultTimeout = 4000;//1.8e6 + 5000;
    int m_timeLeft = 0;
    bool m_alarm = false; // set true when counter zeroes

    bool counterOn() const;
    void setCounterOn(bool newCounterOn);
    void setAlertCounter(int newValue);
    void setTimeLeft(int newTimeLeft);
    void getTimeLeft();

    void setDefaultTimeout(int newDefaultTimeout);
    void setTimeLeftProperty();
    void setAlarmDuration(int newAlarmDuration);
    QString chooseCorePropsPath();
    QString getRealWinPath(QString *filePath);
    QJsonObject setupLedMessage();

public slots:
    void stopAlarm();
    void soundAlarm();
signals:
    void counterOnChanged();
    void defaultTimeoutChanged();

    void timeLeftChanged();
    void alertTimeChanged();
    void alarmChanged();
    void alarmDurationChanged();
};

#endif // BACKEND_H
