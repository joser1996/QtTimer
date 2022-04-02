#ifndef CUSTOMPIEMODEL_H
#define CUSTOMPIEMODEL_H
#include <QAbstractTableModel>

class CustomPieModel: public QAbstractTableModel {

public:
    explicit CustomPieModel(QObject* parent = 0);

    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setCurrentWeek();
    bool setToday();
private:
    QList<QString> labels;
    QList<int> values;
};

#endif // CUSTOMPIEMODEL_H
