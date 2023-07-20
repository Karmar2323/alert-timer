#ifndef JSONMESSAGEHANDLER_H
#define JSONMESSAGEHANDLER_H

#include <QObject>
#include <QJsonDocument>
#include <QString>
#include <QStringList>
#include <QJsonObject>

#include "httphandler.h"

class JsonMessageHandler : public QObject
{
    Q_OBJECT
public:
    explicit JsonMessageHandler(QObject *parent = nullptr);

    const QString GAME = "ALERT_TIMER";
    const QString EVENT_NAME = "ALERT";
    const QString REQUEST = "POST";
    const QString EVENT_ENDPOINT = "/event";
    const QString HEARTBEAT_ENDPOINT = "/game_heartbeat";
    const QString REGISTER_ENDPOINT = "/register_game_event";
    const QString BIND_ENDPOINT = "/bind_game_event";
    const QString REMOVE_ENDPOINT = "/remove_game_event";
    const QStringList deviceType = {"keyboard", "mouse", "headset", "indicator"};
    const QStringList zone = {"function-keys", "main-keyboard", "keypad", "number-keys",
                            "wheel", "logo", "base", "earcups", "one"};

    enum endPoints {
        eventEp, heartEp, registerEp, bindEp, removeEp
    };

    QJsonObject jsonHandler, gameEventJson, removeGameJson,
        heartBeatJson, registerJson, bindJson, removeEventJson;

    QString getGAME() const;

    QString getCONTENT_TYPE() const;
    QJsonObject setupLedMessage(int);
signals:

};

#endif // JSONMESSAGEHANDLER_H
