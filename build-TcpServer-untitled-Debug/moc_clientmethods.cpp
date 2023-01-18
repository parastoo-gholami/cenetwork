/****************************************************************************
** Meta object code from reading C++ file 'clientmethods.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.4.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../TcpServer/clientmethods.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'clientmethods.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.4.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
namespace {
struct qt_meta_stringdata_clientMethods_t {
    uint offsetsAndSizes[60];
    char stringdata0[14];
    char stringdata1[11];
    char stringdata2[1];
    char stringdata3[8];
    char stringdata4[11];
    char stringdata5[12];
    char stringdata6[11];
    char stringdata7[3];
    char stringdata8[10];
    char stringdata9[28];
    char stringdata10[12];
    char stringdata11[9];
    char stringdata12[23];
    char stringdata13[15];
    char stringdata14[12];
    char stringdata15[5];
    char stringdata16[18];
    char stringdata17[7];
    char stringdata18[12];
    char stringdata19[13];
    char stringdata20[3];
    char stringdata21[31];
    char stringdata22[8];
    char stringdata23[6];
    char stringdata24[26];
    char stringdata25[5];
    char stringdata26[11];
    char stringdata27[19];
    char stringdata28[4];
    char stringdata29[9];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_clientMethods_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_clientMethods_t qt_meta_stringdata_clientMethods = {
    {
        QT_MOC_LITERAL(0, 13),  // "clientMethods"
        QT_MOC_LITERAL(14, 10),  // "newMessage"
        QT_MOC_LITERAL(25, 0),  // ""
        QT_MOC_LITERAL(26, 7),  // "message"
        QT_MOC_LITERAL(34, 10),  // "Get_client"
        QT_MOC_LITERAL(45, 11),  // "QTcpSocket*"
        QT_MOC_LITERAL(57, 10),  // "Set_Client"
        QT_MOC_LITERAL(68, 2),  // "cl"
        QT_MOC_LITERAL(71, 9),  // "Set_QHash"
        QT_MOC_LITERAL(81, 27),  // "QHash<QString,QTcpSocket*>*"
        QT_MOC_LITERAL(109, 11),  // "All_CLients"
        QT_MOC_LITERAL(121, 8),  // "Set_QMap"
        QT_MOC_LITERAL(130, 22),  // "QMap<QString,QString>*"
        QT_MOC_LITERAL(153, 14),  // "Active_Clients"
        QT_MOC_LITERAL(168, 11),  // "sendMessage"
        QT_MOC_LITERAL(180, 4),  // "type"
        QT_MOC_LITERAL(185, 17),  // "const QTcpSocket*"
        QT_MOC_LITERAL(203, 6),  // "client"
        QT_MOC_LITERAL(210, 11),  // "onReadyRead"
        QT_MOC_LITERAL(222, 12),  // "onNewMessage"
        QT_MOC_LITERAL(235, 2),  // "ba"
        QT_MOC_LITERAL(238, 30),  // "inform_update_of_message_state"
        QT_MOC_LITERAL(269, 7),  // "whosend"
        QT_MOC_LITERAL(277, 5),  // "toWho"
        QT_MOC_LITERAL(283, 25),  // "update_personal_chat_file"
        QT_MOC_LITERAL(309, 4),  // "time"
        QT_MOC_LITERAL(314, 10),  // "is_atchmnt"
        QT_MOC_LITERAL(325, 18),  // "inform_i_am_online"
        QT_MOC_LITERAL(344, 3),  // "iam"
        QT_MOC_LITERAL(348, 8)   // "chatlist"
    },
    "clientMethods",
    "newMessage",
    "",
    "message",
    "Get_client",
    "QTcpSocket*",
    "Set_Client",
    "cl",
    "Set_QHash",
    "QHash<QString,QTcpSocket*>*",
    "All_CLients",
    "Set_QMap",
    "QMap<QString,QString>*",
    "Active_Clients",
    "sendMessage",
    "type",
    "const QTcpSocket*",
    "client",
    "onReadyRead",
    "onNewMessage",
    "ba",
    "inform_update_of_message_state",
    "whosend",
    "toWho",
    "update_personal_chat_file",
    "time",
    "is_atchmnt",
    "inform_i_am_online",
    "iam",
    "chatlist"
};
#undef QT_MOC_LITERAL
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_clientMethods[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   80,    2, 0x06,    1 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       4,    0,   83,    2, 0x0a,    3 /* Public */,
       6,    1,   84,    2, 0x0a,    4 /* Public */,
       8,    1,   87,    2, 0x0a,    6 /* Public */,
      11,    1,   90,    2, 0x0a,    8 /* Public */,
      14,    3,   93,    2, 0x08,   10 /* Private */,
      18,    0,  100,    2, 0x08,   14 /* Private */,
      19,    1,  101,    2, 0x08,   15 /* Private */,
      21,    2,  104,    2, 0x08,   17 /* Private */,
      24,    5,  109,    2, 0x08,   20 /* Private */,
      27,    2,  120,    2, 0x08,   26 /* Private */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,

 // slots: parameters
    0x80000000 | 5,
    QMetaType::Void, 0x80000000 | 5,    7,
    QMetaType::Void, 0x80000000 | 9,   10,
    QMetaType::Void, 0x80000000 | 12,   13,
    QMetaType::Void, QMetaType::QString, 0x80000000 | 16, QMetaType::QString,   15,   17,    3,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QByteArray,   20,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   22,   23,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Bool,   22,   23,    3,   25,   26,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   28,   29,

       0        // eod
};

Q_CONSTINIT const QMetaObject clientMethods::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_clientMethods.offsetsAndSizes,
    qt_meta_data_clientMethods,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_clientMethods_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<clientMethods, std::true_type>,
        // method 'newMessage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>,
        // method 'Get_client'
        QtPrivate::TypeAndForceComplete<QTcpSocket *, std::false_type>,
        // method 'Set_Client'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QTcpSocket *, std::false_type>,
        // method 'Set_QHash'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QHash<QString,QTcpSocket*> *, std::false_type>,
        // method 'Set_QMap'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QMap<QString,QString> *, std::false_type>,
        // method 'sendMessage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QTcpSocket *, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onReadyRead'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'onNewMessage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>,
        // method 'inform_update_of_message_state'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'update_personal_chat_file'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'inform_i_am_online'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>
    >,
    nullptr
} };

void clientMethods::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<clientMethods *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->newMessage((*reinterpret_cast< std::add_pointer_t<QByteArray>>(_a[1]))); break;
        case 1: { QTcpSocket* _r = _t->Get_client();
            if (_a[0]) *reinterpret_cast< QTcpSocket**>(_a[0]) = std::move(_r); }  break;
        case 2: _t->Set_Client((*reinterpret_cast< std::add_pointer_t<QTcpSocket*>>(_a[1]))); break;
        case 3: _t->Set_QHash((*reinterpret_cast< std::add_pointer_t<QHash<QString,QTcpSocket*>*>>(_a[1]))); break;
        case 4: _t->Set_QMap((*reinterpret_cast< std::add_pointer_t<QMap<QString,QString>*>>(_a[1]))); break;
        case 5: _t->sendMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<const QTcpSocket*>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 6: _t->onReadyRead(); break;
        case 7: _t->onNewMessage((*reinterpret_cast< std::add_pointer_t<QByteArray>>(_a[1]))); break;
        case 8: _t->inform_update_of_message_state((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 9: _t->update_personal_chat_file((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[5]))); break;
        case 10: _t->inform_i_am_online((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QTcpSocket* >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (clientMethods::*)(const QByteArray & );
            if (_t _q_method = &clientMethods::newMessage; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject *clientMethods::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *clientMethods::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_clientMethods.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int clientMethods::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void clientMethods::newMessage(const QByteArray & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
