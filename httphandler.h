
#ifndef HTTPHANDLER_H
#define HTTPHANDLER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QString>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonObject>

#include "jsonmessagehandler.h"

class HttpHandler : public QObject
{
    Q_OBJECT
public:
    explicit HttpHandler(QObject *parent = nullptr);
    void postJson(QString destination, quint16 port,
                  QString endpoint, QJsonObject data);
private:
    QNetworkAccessManager *QNAM;
signals:
private slots:
    void onReplyFinished(QNetworkReply *reply);
    void onSlotError(QNetworkReply::NetworkError code);
    void onSlotReadyRead();
};

#endif // HTTPHANDLER_H
