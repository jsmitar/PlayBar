/****************************************************************************
** Meta object code from reading C++ file 'mprisservice.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/mprisservice.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mprisservice.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MprisService[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      19,   14,   13,   13, 0x0a,
      43,   13,   13,   13, 0x0a,
      56,   13,   13,   13, 0x0a,
      63,   13,   13,   13, 0x0a,
      71,   13,   13,   13, 0x0a,
      78,   13,   13,   13, 0x0a,
      89,   13,   13,   13, 0x0a,
      96,   13,   13,   13, 0x0a,
     107,   13,   13,   13, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_MprisService[] = {
    "MprisService\0\0name\0startOperation(QString)\0"
    "play_pause()\0play()\0pause()\0stop()\0"
    "previous()\0next()\0upVolume()\0downVolume()\0"
};

void MprisService::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MprisService *_t = static_cast<MprisService *>(_o);
        switch (_id) {
        case 0: _t->startOperation((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->play_pause(); break;
        case 2: _t->play(); break;
        case 3: _t->pause(); break;
        case 4: _t->stop(); break;
        case 5: _t->previous(); break;
        case 6: _t->next(); break;
        case 7: _t->upVolume(); break;
        case 8: _t->downVolume(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MprisService::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MprisService::staticMetaObject = {
    { &Plasma::Applet::staticMetaObject, qt_meta_stringdata_MprisService,
      qt_meta_data_MprisService, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MprisService::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MprisService::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MprisService::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MprisService))
        return static_cast<void*>(const_cast< MprisService*>(this));
    typedef Plasma::Applet QMocSuperClass;
    return QMocSuperClass::qt_metacast(_clname);
}

int MprisService::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    typedef Plasma::Applet QMocSuperClass;
    _id = QMocSuperClass::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
