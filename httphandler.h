
#ifndef HTTPHANDLER_H
#define HTTPHANDLER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QString>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonObject>
#include <QPointer>

class HttpHandler : public QObject
{
    Q_OBJECT
public:
    explicit HttpHandler(QObject *parent = nullptr);
    void postJson(QString destination, quint16 port, QJsonObject data);
private:
    QPointer<QNetworkAccessManager> QNAM;
signals:

};

#endif // HTTPHANDLER_H
