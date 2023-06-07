
#ifndef FILEHANDLER_H
#define FILEHANDLER_H


#include <QObject>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject *parent = nullptr);

    QJsonObject readJsonFile(QString fileName);
    QByteArray readFile(QString fileName);

private:

signals:

};

#endif // FILEHANDLER_H
