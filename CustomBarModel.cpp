#include "CustomBarModel.h"
#include <QDebug>
CustomBarModel::CustomBarModel(QObject* parent): QAbstractTableModel(parent) {
    //init data
    this->labels = {QString("Jose"), QString("Tom")};
    this->values = {{100,100,99}, {50, 70, 25}};
    qDebug() << this->labels;
    qDebug() << this->values;
    this->cols = this->labels.count();
}

int CustomBarModel::getCols() {
    return this->cols;
}

int CustomBarModel::rowCount(const QModelIndex &parent) const {
    if (!parent.isValid()) {
        int rows = 1 + this->values[0].size();
        qDebug() << "Return row: " << rows;
        return 1 + this->values[0].size(); //label + number of rows
    }
    return 0;
}


int CustomBarModel::columnCount(const QModelIndex &parent) const {
    if (!parent.isValid()) {
        qDebug() << "Return cols: " << this->labels.size();
        return this->labels.size();
    }
    return 0;
}


QVariant CustomBarModel::data(const QModelIndex &index, int role) const {
    qDebug() << "Role: " << role;

    if (!index.isValid()) {
        return QVariant();
    }

    switch(role) {
        case Qt::DisplayRole:
            int col = index.column();
            int row = index.row();
            if (row == 0) {
                qDebug() << index << "Label" << this->labels[col];
                return this->labels[col];
            }
            qDebug() << index << "Value" << this->values[col][row-1];
            return this->values[col][row - 1];
    }

    return QVariant();
}

/*
 *Swift Gaming
 *1        2
 *2        4
 *3        6
 */
