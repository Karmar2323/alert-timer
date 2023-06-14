#include <QtTest>
//#include <QCoreApplication>
#include <QString>
#include <QJsonObject>
#include <QPointer>

// add necessary includes here
#include "../filehandler.h"

class file_test : public QObject
{
    Q_OBJECT

public:
    file_test();
    ~file_test();
private:
    //QPointer<FileHandler> FH = new FileHandler;
    QPointer<FileHandler> FH;
private slots:
    void initTestCase();
    void cleanupTestCase();
    void test_case1();
    void test_case_object_empty();
    void test_case_json_ok();
    void test_case_file_error();
    void test_case_file_ok();

};

file_test::file_test()
{

}

file_test::~file_test()
{

}

void file_test::initTestCase()
{

}

void file_test::cleanupTestCase()
{

}

void file_test::test_case1()
{

}

void file_test::test_case_object_empty()
{
    QJsonObject jsonObj = FH->readJsonFile("invalid-path");
    QVERIFY(jsonObj.isEmpty());
}

void file_test::test_case_json_ok()
{
    QJsonObject jsonObj = FH->readJsonFile("./coreProps.json");
    qDebug() << "obj.keys.size: " << jsonObj.keys().size();

    QVERIFY(!jsonObj.isEmpty());

}

void file_test::test_case_file_error()
{
    QByteArray byteArray;
    byteArray = FH->readFile("INVALID");
    QVERIFY(byteArray.isEmpty());
}

void file_test::test_case_file_ok()
{
    QByteArray byteArray;
    byteArray = FH->readFile("./test1.txt"); // should have content, but?
    QVERIFY(!byteArray.isEmpty());
}

//QTEST_MAIN(file_test)
QTEST_APPLESS_MAIN(file_test)

#include "tst_file_test.moc"
