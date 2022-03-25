#include "listmodel.h"
#include "database.h"

CategoryModel::CategoryModel(QObject* parent): QSqlQueryModel(parent) {
    this->updateModel();
}

//get data from the model
QVariant CategoryModel::data(const QModelIndex& index, int role) const {
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> CategoryModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[idRole] = "id";
    roles[catRole] = "category";
    return roles;
}

void CategoryModel::updateModel() {
    this->setQuery("SELECT id, category FROM " CTABLE);
}

int CategoryModel::getId(int row) {
    return this->data(this->index(row, 0), idRole).toInt();
}


