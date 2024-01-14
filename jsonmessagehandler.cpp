
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


    gameEventJson.insert("game", GAME);
    gameEventJson.insert("event", EVENT_NAME);
    QJsonObject dataObj;
    dataObj.insert("value", QJsonValue(255));
    QJsonValue dataValue = QJsonValue(dataObj);
    gameEventJson.insert("data", dataValue);

    removeGameJson.insert("game", GAME);

    removeEventJson.insert("game", GAME);
    removeEventJson.insert("event", EVENT_NAME);

    bindJson.insert("game", GAME);
    bindJson.insert("event", EVENT_NAME);
    bindJson.insert("min_value", 0);
    bindJson.insert("max_value", 255);
    // binding requires handlers:
    // define JSON handlers
    // for mouse illumination:
    QJsonObject handler;
    handler.insert("device-type", QJsonValue("mouse"));
    handler.insert("zone", QJsonValue("logo"));
    //handler.insert("zone", QJsonValue("wheel"));
    handler.insert("mode", QJsonValue("color"));
    QJsonObject rgb;
    rgb.insert("red", 255);
    rgb.insert("green", 255);
    rgb.insert("blue", 0);
    handler.insert("color", QJsonValue(rgb));
    QJsonObject frequency;
    frequency.insert("frequency", QJsonValue(4));
    handler.insert("rate", QJsonValue(frequency));
    // handlers in array
    QJsonArray handlerArray;
    handlerArray.push_back(QJsonValue(handler));
    bindJson.insert("handlers", QJsonValue(handlerArray));
    heartBeatJson.insert("game", GAME);

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
