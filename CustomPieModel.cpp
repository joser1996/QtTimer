#include "CustomPieModel.h"
#include "database.h"
#include <unordered_map>
#include <string>
#include <iomanip>
#include <ctime>
#include <sstream>

CustomPieModel::CustomPieModel(QObject* parent): QAbstractTableModel(parent) {
    if (this->setToday()) {
//        qDebug() << "Succesfully Initialized?";
//        qDebug() << this->labels;
//        qDebug() << this->values;
    } else {
        qDebug() << ":(";
    }
}

int CustomPieModel::rowCount(const QModelIndex &parent) const {
    if (!parent.isValid()) { //parent is the root
        return this->labels.size();
    }
    return 0;
}

int CustomPieModel::columnCount(const QModelIndex &parent) const {
    if (!parent.isValid()) {
        return 2;
    }
    return 0;
}

QVariant CustomPieModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || role != Qt::DisplayRole) {
        return QVariant();
    }

    if (index.column() == 0) {
        //getting a Label
        return this->labels[index.row()];
    } else if (index.column() == 1) {
        //getting a Value
        return this->values[index.row()];
    }
    return QVariant();
}

bool CustomPieModel::setCurrentWeek() {
    QString q = "SELECT category, duration FROM timeTable WHERE date > datetime('now', 'start of day', 'weekday 6', '-7 day');";
    QSqlQuery query;
    query.prepare(q);
    QMap<QString, int> pieData;
    if (!query.exec()) {
        qDebug() << "error select from" << TTABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        QList<QString> labels;
        QList<int> values;
        while(query.next()) {
            //0: category, 1: duration
            QString category = query.value(0).toString();
            int duration = query.value(1).toInt();
            if (pieData.find(category) != pieData.end()) {
                pieData[category] += duration;
            } else {
                pieData[category] = duration;
            }
        }
        QMapIterator<QString, int> it(pieData);
        while(it.hasNext()) {
            it.next();
            labels.push_back(it.key());
            values.push_back(it.value());
        }
        this->labels = labels;
        this->values = values;
        return true;
    }
    return false;
}

bool CustomPieModel::updateModel() {
    if(this->setToday()) {
        qDebug() << "Succesfully updated";
        return true;
    }
    qDebug() << "Did not update";
    return false;
}

bool CustomPieModel::setToday() {
    std::time_t t = std::time(nullptr);
    tm tmo = *std::localtime(&t);
    std::ostringstream oss;
    oss << std::put_time(&tmo, "%Y-%m-%d");
    auto str = oss.str();
    QString today = QString::fromStdString(str);
    QString q = QString("SELECT category, duration FROM timeTable WHERE date > datetime('%1') ;").arg(today);
    qDebug() << "Todays Query: " << q;
    QSqlQuery query;
    if (!query.prepare(q)) {
        qDebug() << "Error Preparing";
        qDebug() << query.lastError().text();
    }
    if (query.exec()) {
        QMap<QString, int> table;
        QList<QString> labels;
        QList<int> values;
        while(query.next()) {
            QString category = query.value(0).toString();
            int duration = query.value(1).toInt();

            if (table.find(category) != table.end()) {
                table[category] += duration;
            } else {
                table[category] = duration;
            }
        }
        QMapIterator<QString, int> it(table);
        while(it.hasNext()) {
            it.next();
            labels.push_back(it.key());
            values.push_back(it.value());
        }
        this->labels = labels;
        this->values = values;
        return true;
    } else {
        qDebug() << "Error setting to today";
        qDebug() << query.lastError().text();
        return false;
    }
    return false;
}

//for the right time frame like current week

//for each of hte same category add duratoin to get a new label and duration

//ge
