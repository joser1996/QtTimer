#ifndef CUSTOMBARMODEL_H
#define CUSTOMBARMODEL_H
#include <QAbstractTableModel>
#include <QObject>

class CustomBarModel: public QAbstractTableModel {
    //Q_OBJECT
public:
    explicit CustomBarModel(QObject* parent = 0);
    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    int getCols();

private:
    QList<QString> labels;
    QList<QList<int>> values;// values[i]: values for label[i]
    int cols;
};

#endif // CUSTOMBARMODEL_H
