
#ifndef HTTPHANDLER_H
#define HTTPHANDLER_H


#include <QObject>
#include <QNetworkAccessManager>


class HttpHandler : public QObject
{
    Q_OBJECT
public:
    explicit HttpHandler(QObject *parent = nullptr);

signals:

};

#endif // HTTPHANDLER_H
