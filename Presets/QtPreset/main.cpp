#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.loadFromModule("QtPresetModule", "Main");
    if (engine.rootObjects().isEmpty())
        exit(-1);

    return QGuiApplication::exec();
}
