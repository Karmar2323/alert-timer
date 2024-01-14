
#include "httphandler.h"

HttpHandler::HttpHandler(QObject *parent)
    : QObject{parent}
{
    QNAM = new QNetworkAccessManager();
    connect(QNAM, &QNetworkAccessManager::finished,
            this, &HttpHandler::onReplyFinished);
}

void HttpHandler::postJson(QString address, quint16 port,
                           QString endpoint, QJsonObject data)
{

    this->QNAM->connectToHost(address, port);

    QNetworkRequest request;
    QUrl url = QUrl("http://" + address);
    url.setPath(endpoint);
    url.setPort(port);

    request.setUrl(url);
    request.setRawHeader("Content-Type", "application/json");

    QByteArray dataBytes = QJsonDocument(data).toJson();
    qDebug() << "data object: " << data;
    qDebug() << "URL: " << request.url();

    QNetworkReply *reply = QNAM->post(request, dataBytes);

    connect(reply, &QIODevice::readyRead, this, &HttpHandler::onSlotReadyRead);
    connect(reply, &QNetworkReply::errorOccurred,
            this, &HttpHandler::onSlotError);

}

void HttpHandler::onReplyFinished(QNetworkReply *reply){

    if(reply->error() != QNetworkReply::NoError) {
        qDebug() << reply->errorString() << ", error: " <<  reply->error();
    }

    qDebug() << "Reply status code: "
             << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString();

    reply->deleteLater();
}

void HttpHandler::onSlotError(QNetworkReply::NetworkError code){
    qDebug() << "onSlotError: " << code;
}

void HttpHandler::onSlotReadyRead() {
    qDebug() << "onSlotReadyRead called";
}
