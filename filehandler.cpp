
#include "filehandler.h"

FileHandler::FileHandler(QObject *parent)
    : QObject{parent}
{

}

QJsonObject FileHandler::readJsonFile(QString fileName)
{
    QJsonObject jsonObj;
    QByteArray byteArray = readFile(fileName);
    QJsonDocument jsonDoc;
    try {
        jsonDoc = QJsonDocument::fromJson(byteArray);//from qbytearray from file
    } catch (QJsonParseError error) {
        qDebug() << "Error: " << error.errorString();
    }

    if(!jsonDoc.isNull()) {
        jsonObj = jsonDoc.object();
    }

    return jsonObj;
}

QByteArray FileHandler::readFile(QString fileName)
{
    // From Qt Essentials tutorial
    QFile file(fileName);
    if (!file.open(QFile::ReadWrite | QIODevice::Text)) {
        qDebug() << "Error opening file: " << fileName;
        return QByteArray(); // return empty
    }

    const auto fileSize(file.size());
    QByteArray readBuffer;

    readBuffer.clear();
    file.reset();
    const int bufferSize(100);
    char chunk[bufferSize];
    auto readBytes(0);
    while ((readBytes = file.read(chunk, bufferSize)) > 0) {
        readBuffer.append(chunk, readBytes);
    }
    file.close();
    return readBuffer;
}

