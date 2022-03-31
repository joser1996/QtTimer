#include "TimeEntryModel.h"
#include "database.h"

TimeEntryModel::TimeEntryModel(QObject* parent): QSqlQueryModel(parent) {
    this->updateModel();
}

QVariant TimeEntryModel::data(const QModelIndex &index, int role) const {
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> TimeEntryModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[idRole] = "id";
    roles[categoryRole] = "category";
    roles[dateRole] = "date";
    roles[durationRole] = "duration";
    return roles;
}

void TimeEntryModel::updateModel() {
    this->setQuery("SELECT id, category, date, duration FROM " TTABLE);
}

void TimeEntryModel::updateModelWeek() {
    QString q = "SELECT * FROM timeTable WHERE date > datetime('now', 'start of day', 'weekday 6', '-7 day');";
    this->setQuery(q);
}

int TimeEntryModel::getId(int row) {
    return this->data(this->index(row, 0), idRole).toInt();
}
