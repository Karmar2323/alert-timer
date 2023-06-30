
#include "httphandler.h"

HttpHandler::HttpHandler(QObject *parent)
    : QObject{parent}
{

}

void HttpHandler::postJson(QString address, quint16 port, QJsonObject data)
{

    QNAM->connectToHost(address, port);

}

