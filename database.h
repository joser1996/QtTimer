#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QSqlError>
#include <QFile>
#include <QDebug>
#include <QString>

#define DATABASE_HOSTNAME "LocalHostDB"
#define DATABASE_NAME "TimerDB"

#define CTABLE "categoryTable"

class DataBase: public QObject {
    Q_OBJECT

public:
    explicit DataBase(QObject* parent = 0);
    ~DataBase();
    void connectToDataBase();

private:
    QSqlDatabase db;
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();

public slots:
    bool insertIntoTable(const QVariantList& data);
    bool insertIntoTable(const QString& cat);
    bool removeRecord(const int id);
};

#endif // DATABASE_H
