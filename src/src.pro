TEMPLATE = app
TARGET = raskbrowser

QT += webkit declarative

HEADERS += mainwindow.h \
           scrollbar.h \
           kineticscroll.h \
           mobilewebview.h

SOURCES += main.cpp \
           mainwindow.cpp \
           scrollbar.cpp \
           kineticscroll.cpp \
           mobilewebview.cpp

isEmpty(RESOLUTION) {
    RESOLUTION = "800x480"
}

RESOURCES = ../resource/$$RESOLUTION/resource.qrc