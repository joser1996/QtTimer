#ifndef CUSTOMPIEMODEL_H
#define CUSTOMPIEMODEL_H
#include <QAbstractTableModel>

class CustomPieModel: public QAbstractTableModel {
    Q_OBJECT
public:
    explicit CustomPieModel(QObject* parent = 0);

    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setCurrentWeek();
    bool setToday();
    Q_INVOKABLE bool setDay(const QString& date);
    Q_INVOKABLE bool updateModel();
private:
    QList<QString> labels;
    QList<int> values;
};

#endif // CUSTOMPIEMODEL_H
