// JSON objects to use with SteelSeries GameSense SDK
// <https://github.com/SteelSeries/gamesense-sdk>

#ifndef JSONHANDLER_H
#define JSONHANDLER_H

#include <QJsonObject>

const string GAME = "ALERT_TIMER";
const string CONTENT_TYPE = "application/json";
const string REQUEST = "POST";
const string EVENT_ENDPOINT = "/event";
const string HEARTBEAT_ENDPOINT = "/game_heartbeat";
const string REGISTER_ENDPOINT = "/register_game_event";
const string BIND_ENDPOINT = "/bind_game_event";
const string REMOVE_ENDPOINT = "/remove_game_event";

QJsonObject jsonHandler {

    {"device-type", "keyboard" || "mouse" || "headset" || "indicator"},
    {"zone", "function-keys" || "main-keyboard" || "keypad" || "number-keys"
    || "wheel" || "logo" || "base" || "earcups" || "one"},
    {"custom-zone-keys", []},
    {"mode", "color"},
    {"color", { "red", 0, "green", 255, "blue", 255 }},
    {"rate", {
              {"frequency", 2}, {"repeat_limit", 1200}
             }
    },
    {"context-frame-key", ""}

};

QJsonObject gameEvent {
    {"game", GAME},
    {"event", "ALERT"},
    {"data", {"value", 2}}
};

QJsonObject removeGame, heartBeat {
    {"game", GAME}
};

QJsonObject registerJson {
    {"game", GAME},
    {"event", "ALERT"},
    {"min_value", 0},
    {"max_value", 20}
};

QJsonObject bindJson {
    {"game", GAME},
    {"event", "ALERT"},
    {"min_value", 0},
    {"max_value", 20},
    {"handlers", jsonHandler}};

QJsonObject removeEvent {
    {"game", GAME},
    {"event", "ALERT"}};

#endif // JSONHANDLER_H
