#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "MyClass.h"
#include "qmllanguage.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //切换为本地语言
    //检测本系统语言自动装载翻译文件
    //使用qt的QLocale这个类，通过这个类来获取系统本地语言环境
    //QTranslator的load方法装载语言包
    //QGuiApplication的实例化对象的installTranslator去实现语言翻译
    QTranslator translator;
    QLocale locale;
    bool b = false;
    if( locale.language() == QLocale::English ) {
        qDebug("QLocale::English");
        b = translator.load(":/en_us.qm");
    }
    else if( locale.language() == QLocale::Chinese ) {
        b = translator.load(":/zh_CN.qm");
        if (b)
            qDebug("QLocale::Chinese return true");
        else
            qDebug("QLocale::Chinese return false");
    }
    app.installTranslator(&translator);

    //将QmlLanguage中的所有函数暴露给qml调用
    QmlLanguage qmlLanguage(app, engine);
    engine.rootContext()->setContextProperty("qmlLanguage", &qmlLanguage);

    MyClass myClass;
    // 将 C++ 对象暴露到 QML
    engine.rootContext()->setContextProperty("myClass", &myClass);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

