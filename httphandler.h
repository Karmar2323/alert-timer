
#ifndef HTTPHANDLER_H
#define HTTPHANDLER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class HttpHandler : public QObject
{
    Q_OBJECT
public:
    explicit HttpHandler(QObject *parent = nullptr);
    void postJson(QString destination, QString jsonData);
signals:

};

#endif // HTTPHANDLER_H
