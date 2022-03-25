#ifndef LISTMODEL_H
#define LISTMODEL_H
#include <QObject>
#include <QSqlQueryModel>

class CategoryModel: public QSqlQueryModel {
    Q_OBJECT
public:

    enum Roles {
        idRole = Qt::UserRole + 1,
        catRole
    };

    explicit CategoryModel(QObject* parent = 0);

    //overrid method that returns the data
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL_H
