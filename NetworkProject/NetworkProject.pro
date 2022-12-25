QT += quick

SOURCES += \
        main.cpp

resources.files = main.qml 
resources.files += HeadText.qml
resources.files += Circles.qml
resources.files += MyGroupbox.qml
resources.files += ModeButton.qml
resources.files += MyRow.qml
resources.files += Txt_in_groupbox.qml
resources.files += TxtField_in_groupbox.qml
resources.files += Submit_btn.qml
resources.files += Signup_link.qml

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

DISTFILES += \
    #MyGroupbox.qml
    #HeadText.qml
    #Circles.qml
    #ModeButton.qml
    #MyRow.qml
