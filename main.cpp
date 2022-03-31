#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "database.h"
#include "listmodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    DataBase database;
    database.connectToDataBase();

    CategoryModel* model = new CategoryModel();
    engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("database", &database);

    QQuickStyle::setStyle("Fusion");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
