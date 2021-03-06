#ifndef VKBSERVER_H
#define VKBSERVER_H

#include "mainwindow.h"

#include <QtCore/QObject>

class VkbServer: public QObject
{
    Q_OBJECT

public:
    VkbServer(QObject *parent = 0) : QObject(parent) { 

    view.setGeometry(0, 416, 1024, 352); // 600 - 352 = 248; 

    view.setWindowFlags(Qt::FramelessWindowHint|
        Qt::WindowStaysOnTopHint|Qt::X11BypassWindowManagerHint);
    view.setFocusPolicy(Qt::NoFocus);

    view.setAttribute(Qt::WA_TranslucentBackground, true);
//    view.setStyleSheet("background:transparent;");

    view.show();

    qDebug() << view.winId();
}

public slots:
    void toggle() {
    view.toggle();
    qDebug() << __PRETTY_FUNCTION__;
    };

    void focusout() { view.focusout();     qDebug() << __PRETTY_FUNCTION__; };
    void focusin() { view.focusin();     qDebug() << __PRETTY_FUNCTION__;};

public: 
    MainWindow view;
};

#endif
