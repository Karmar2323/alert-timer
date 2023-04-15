
#include "backend.h"

Backend::Backend()
{

    setAlertCounter(m_defaultTimeout);
    m_timeLeftTimer.setInterval(300);
    connect(&m_alertCounter, &QTimer::timeout, this, &Backend::stopCounting);
    connect(&m_timeLeftTimer, &QTimer::timeout, this, &Backend::setTimeLeftProperty);
}

void Backend::setTimeLeftProperty(){
    setTimeLeft(m_alertCounter.remainingTime());
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

void Backend::setTimeLeft(int newTimeLeft)
{
    if (m_timeLeft == newTimeLeft)
        return;
    m_timeLeft = newTimeLeft;
    emit timeLeftChanged();
}
