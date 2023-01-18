QT += quick
QT += core gui network
SOURCES += \
        main.cpp \
        tcpclient.cpp

resources.files = main.qml
resources.files += Groupbox.qml
resources.files += MyButton.qml
resources.files += Header.qml
resources.files += LoginTxt.qml
resources.files += MyTextField.qml
resources.files += Signup.qml
resources.files += Signup_gb.qml
resources.files += SignupTxt.qml
resources.files += Messanger.qml
resources.files += MButton.qml
resources.files += MLine.qml
resources.prefix = /$${TARGET}
RESOURCES += resources \
    Resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=
HEADERS += \
    tcpclient.h
