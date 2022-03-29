#include "database.h"

DataBase::DataBase(QObject* parent): QObject(parent) {}

DataBase::~DataBase() {}

void DataBase::connectToDataBase() {
    QString dbPath = QString::fromUtf8(qgetenv("DB_PATH")) + QString::fromUtf8(DATABASE_NAME);
    //qDebug() << "Path to DB: " << dbPath;
    if (!QFile(dbPath).exists()) {
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}

bool DataBase::restoreDataBase() {
    if (this->openDataBase()) {
        return (this->createTable() && this->createTimeTable());
    } else {
        qDebug() << "Failed to restore the database";
        return false;
    }
    return false;
}

bool DataBase::openDataBase() {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    QString dbPath = QString::fromUtf8(qgetenv("DB_PATH")) + QString::fromUtf8(DATABASE_NAME);
    db.setDatabaseName(dbPath);
    if (db.open()) return true;
    return false;
}

void DataBase::closeDataBase() {
    db.close();
}

bool DataBase::createTable() {
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " CTABLE " ("
                        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                        "category VARCHAR(50) NOT NULL"
                    ")"

                )) {
        qDebug() << "Database error of create" << CTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::createTimeTable() {
    QString q = "CREATE TABLE " + QString::fromUtf8(TTABLE)
            + " (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "category VARCHAR(50) NOT NULL, " +
            "date VARCHAR(50) NOT NULL, " +
            "duration INTEGER NOT NULL)";
    QSqlQuery query;
    if (!query.exec(q)) {
        qDebug() << "Database error of create timeTable" << TTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::insertIntoTable(const QVariantList& data) {
    QSqlQuery query;
    query.prepare("INSERT INTO " CTABLE " (category)"
                  "VALUES (:cat)");
    query.bindValue(":cat", data[0].toString());

    if (!query.exec()) {
        qDebug() << "error insert into " << CTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else return true;

    return false;
}


//TODO: Make sure that category doesn't already exist
bool DataBase::insertIntoTable(const QString& cat) {
    QSqlQuery query;
    query.prepare("INSERT INTO " CTABLE " (category)"
                  "VALUES (:cat)");
    query.bindValue(":cat", cat);

    if (!query.exec()) {
        qDebug() << "error insert into " << CTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else return true;

    return false;
}

bool DataBase::insertIntoTimeTable(const QString& cat, const QString& date, const int time) {
    QSqlQuery query;
    query.prepare("INSERT INTO " TTABLE
                  " (category, date, duration) "
                  " VALUES (:cat, :date, :duration);");
    query.bindValue(":cat", cat);
    query.bindValue(":date", date);
    query.bindValue(":duration", time);

    if (!query.exec()) {
        qDebug() << "error insert into " << TTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::removeRecord(const int id) {
    QSqlQuery query;
    //qDebug() << "Removing id: " << id;
    QString q = "Delete FROM " + QString::fromUtf8(CTABLE) + " WHERE id = :ID;";
    //qDebug() << "Query: " << q;
    query.prepare(q);
    query.bindValue(":ID", id);
    if (!query.exec()) {
        qDebug() << "error delete row " << CTABLE;
        qDebug() << query.lastError().text();
    } else return true;
    return false;
}










