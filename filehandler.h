
#ifndef FILEHANDLER_H
#define FILEHANDLER_H


#include <QObject>
#include <QDataStream>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject *parent = nullptr);

signals:

};

#endif // FILEHANDLER_H
