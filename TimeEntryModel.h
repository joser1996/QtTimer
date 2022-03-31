#ifndef TIMEENTRYMODEL_H
#define TIMEENTRYMODEL_H
#include <QObject>
#include <QSqlQueryModel>

class TimeEntryModel: public QSqlQueryModel {
    Q_OBJECT
public:
    enum Roles {
        idRole = Qt::UserRole + 1,
        categoryRole,
        dateRole,
        durationRole
    };

    explicit TimeEntryModel(QObject* parent = 0);

    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateModelWeek();
    int getId(int row);
};

#endif // TIMEENTRYMODEL_H
