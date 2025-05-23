#include "qmllanguage.h"

/*
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Users\y36zhao\code\git\qml_mine\qml_mine>C:\Qt\Qt5.14.2\5.14.2\mingw73_64\bin
\lupdate.exe main.qml -ts zh_CN.ts en_us.ts
Updating 'zh_CN.ts'...
    Found 13 source text(s) (13 new and 0 already existing)
Updating 'en_us.ts'...
    Found 13 source text(s) (13 new and 0 already existing)

C:\Users\y36zhao\code\git\qml_mine\qml_mine>
*/

QmlLanguage::QmlLanguage(QGuiApplication &app, QQmlApplicationEngine& engine)
{
    m_app = &app;
    m_engine = &engine;
}

void QmlLanguage::setLocalLanguage(){
    QTranslator translator;
    QLocale locale;
    if( locale.language() == QLocale::English ) {
        translator.load(":/en_us.qm");
    }
    else if( locale.language() == QLocale::Chinese ) {
        translator.load(":/zh_CN.qm");
    }
    m_app->installTranslator(&translator);
    //重新载入语言包
    m_engine->retranslate();
}

void QmlLanguage::setLanguage(int indexOfLanguage)
{
    QTranslator translator;
    bool b = false;
    if (indexOfLanguage == 0)
    {
        qDebug("QmlLanguage::setLanguage load en_US.qm");
        b = translator.load(".\\en_US.qm");
        if (b)
            qDebug("translator.load return true");
        else
            qDebug("translator.load return false");
    }
    else if (indexOfLanguage == 1)
    {
        qDebug("QmlLanguage::setLanguage load zh_CN.qm");
        translator.load(".\\zh_CN.qm");
    }
    else
    {
        qDebug("QmlLanguage::setLanguage load en_US.qm");
        translator.load(".\\en_US.qm");
    }
    m_app->installTranslator(&translator);
    m_engine->retranslate();
}

int QmlLanguage::getLocalLanguage(){
    QLocale locale;
    if(locale.language() == QLocale::English){
        return 0;
    }else if(locale.language() == QLocale::Chinese){
        return 1;
    }
    return 0;
}

