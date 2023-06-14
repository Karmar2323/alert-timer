
#include "backend.h"

Backend::Backend()
{

    setAlertCounter(m_defaultTimeout);
    m_timeLeftTimer.setInterval(500);
    QObject::connect(&m_alertCounter, &QTimer::timeout, this, &Backend::stopCounting);
    QObject::connect(&m_alertCounter, &QTimer::timeout, this, &Backend::soundAlarm);
    QObject::connect(&m_timeLeftTimer, &QTimer::timeout, this, &Backend::setTimeLeftProperty);

    m_corePropsPath = chooseCorePropsPath();
    m_ledStatus = findLED();

}


void Backend::setTimeLeftProperty(){
    setTimeLeft(m_alertCounter.remainingTime());
}


void Backend::setAlarmDuration(int newAlarmDuration)
{
    if (m_alarmDuration == newAlarmDuration)
        return;
    m_alarmDuration = newAlarmDuration;
    emit alarmDurationChanged();
}

QString Backend::getLedAddress() const
{
    return m_ledAddress;
}

void Backend::setLedAddress(const QString &newLedAddress)
{
    m_ledAddress = newLedAddress;
}

bool Backend::getLedStatus() const
{
    return m_ledStatus;
}

void Backend::setLedStatus(bool newLedStatus)
{
    m_ledStatus = newLedStatus;
}


QString Backend::chooseCorePropsPath()
{
    QString filePath;
    QString pathEnd = "/SteelSeries Engine 3/coreProps.json";

#ifdef Q_OS_WINDOWS
    filePath = "%PROGRAMDATA%/SteelSeries" + pathEnd;
    filePath = getRealWinPath(&filePath);
#elif defined(Q_OS_DARWIN)
    filePath = "/Library/Application Support" + pathEnd;
#endif

    qDebug() << "filePath: " << filePath;

    return filePath;
}


QString Backend::getRealWinPath(QString* filePath){

    QChar *unwanted = filePath->begin();

    filePath->remove(*unwanted); //filePath->remove("%");
    filePath->prepend("C:/");

    return *filePath;

}

void Backend::readCoreProps()
{

}


bool Backend::findLED()
{

    QString address = "";
    QPointer<FileHandler> FH = new FileHandler;
    QJsonObject jsonObj = FH->readJsonFile(m_corePropsPath);

    // check obj
    if (jsonObj.value("address").isUndefined()) {
        // undefined key
        setLedAddress(address);
        setLedStatus(false);
    }
    else if (jsonObj.value("address").isString()) {
        address = jsonObj.value("address").toString();

        if (address.size() > 8) {
            // good address
            setLedAddress(address);
            setLedStatus(true);
            // TODO use address try LED
        }
        else setLedStatus(false);

    }
    else setLedStatus(false);

    qDebug() << "LedAddress: " << getLedAddress();

    FH = 0;
    return getLedStatus();

}


void Backend::setAlertCounter(int newValue) {
    //update timer timeout
    m_alertCounter.setInterval(newValue);
    emit defaultTimeoutChanged();
}


void Backend::startCounting()
{

    m_alertCounter.start();
    m_timeLeftTimer.start();
    setCounterOn(true);
    qDebug() << "starts counting, counter active: " << m_alertCounter.isActive();

}


void Backend::soundAlarm() {
    setAlarm(true);
    qDebug() << "alarm:" << alarm();
    // start timer to turn alarm off
    QTimer::singleShot(m_alarmDuration, this, &Backend::stopAlarm);
    stopCounting();
}

void Backend::stopAlarm() {
    setAlarm(false);
    qDebug() << "alarm:" << alarm();
}

void Backend::stopCounting()
{

    if (m_alertCounter.isActive()) {
        m_alertCounter.stop();
        setCounterOn(false);

    }

    qDebug() << "stop counting, counter active: " << m_alertCounter.isActive();

}


bool Backend::counterOn() const
{
    return m_counterOn;
}

void Backend::setCounterOn(bool newCounterOn)
{
    if (m_counterOn == newCounterOn)
        return;
    m_counterOn = newCounterOn;
    emit counterOnChanged();
}

int Backend::defaultTimeout() const
{
    return m_defaultTimeout;
}

void Backend::setDefaultTimeout(int newDefaultTimeout)
{
    if (m_defaultTimeout == newDefaultTimeout)
        return;
    m_defaultTimeout = newDefaultTimeout;
    emit defaultTimeoutChanged();
}

int Backend::timeLeft() const
{
    return m_timeLeft;
}

int Backend::alarmDuration() const
{
    return m_alarmDuration;
}

void Backend::setAlertTime(int newAlertTime)
{
    setAlertCounter(newAlertTime);
    m_defaultTimeout = newAlertTime;
}

void Backend::setTimeLeft(int newTimeLeft)
{
    if (m_timeLeft == newTimeLeft)
        return;
    m_timeLeft = newTimeLeft;
    emit timeLeftChanged();
}


bool Backend::alarm() const
{
    return m_alarm;
}

void Backend::setAlarm(bool newAlarm)
{
    if (m_alarm == newAlarm)
        return;
    m_alarm = newAlarm;
    emit alarmChanged();
}
