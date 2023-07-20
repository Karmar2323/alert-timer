
#include "jsonmessagehandler.h"

JsonMessageHandler::JsonMessageHandler(QObject *parent)
    : QObject{parent}
{

    //JSON object definitions

    // register event, required keys
    registerJson.insert("game", GAME);
    registerJson.insert("event", EVENT_NAME);
    // optional keys:
    // "icon_id": 1, "value_optional": false
    //    registerJson.insert("min_value", 3);
    //    registerJson.insert("max_value", 3);
    // TODO others

    // TODO define JSON handlers

    // for mouse illumination:
    QJsonObject handler;
    handler.insert("device-type", QJsonValue("mouse"));
    handler.insert("zone", QJsonValue("logo"));
    handler.insert("mode", QJsonValue("color"));
    QJsonObject rgb;
    rgb.insert("red", 255);
    rgb.insert("green", 255);
    rgb.insert("blue", 255);
    handler.insert("color", QJsonValue(rgb).toString());

}


QJsonObject JsonMessageHandler::setupLedMessage(int endPoint) {

    QString addressEndpoint;
    QJsonObject data;

    switch (endPoint) {
    case eventEp:
        addressEndpoint = EVENT_ENDPOINT;
        data = gameEventJson;
        break;
    case registerEp:
        addressEndpoint = REGISTER_ENDPOINT;
        data = registerJson;
        break;
    case bindEp:
        addressEndpoint = BIND_ENDPOINT;
        data = bindJson;
        break;
    case removeEp:
        addressEndpoint = REMOVE_ENDPOINT;
        data = removeEventJson;
        break;
    case heartEp:
    default:
        addressEndpoint = HEARTBEAT_ENDPOINT;
        data = heartBeatJson;
    }

    //temporary key for returning value
    data.insert("endpoint", addressEndpoint);

    return data;

}