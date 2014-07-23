#include <kdialog.h>
#include <klocale.h>

/********************************************************************************
** Form generated from reading UI file 'kcm_playbarshortcuts.ui'
**
** Created by: Qt User Interface Compiler version 4.8.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_KCM_PLAYBARSHORTCUTS_H
#define UI_KCM_PLAYBARSHORTCUTS_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>
#include "kshortcutseditor.h"

QT_BEGIN_NAMESPACE

class Ui_mainWidget
{
public:
    QVBoxLayout *verticalLayout;
    KShortcutsEditor *kshortcutseditor;

    void setupUi(QWidget *mainWidget)
    {
        if (mainWidget->objectName().isEmpty())
            mainWidget->setObjectName(QString::fromUtf8("mainWidget"));
        mainWidget->resize(424, 493);
        QSizePolicy sizePolicy(QSizePolicy::Maximum, QSizePolicy::Maximum);
        sizePolicy.setHorizontalStretch(1);
        sizePolicy.setVerticalStretch(1);
        sizePolicy.setHeightForWidth(mainWidget->sizePolicy().hasHeightForWidth());
        mainWidget->setSizePolicy(sizePolicy);
        mainWidget->setAutoFillBackground(false);
        verticalLayout = new QVBoxLayout(mainWidget);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        kshortcutseditor = new KShortcutsEditor(mainWidget);
        kshortcutseditor->setObjectName(QString::fromUtf8("kshortcutseditor"));
        QSizePolicy sizePolicy1(QSizePolicy::Preferred, QSizePolicy::MinimumExpanding);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(kshortcutseditor->sizePolicy().hasHeightForWidth());
        kshortcutseditor->setSizePolicy(sizePolicy1);

        verticalLayout->addWidget(kshortcutseditor);


        retranslateUi(mainWidget);

        QMetaObject::connectSlotsByName(mainWidget);
    } // setupUi

    void retranslateUi(QWidget *mainWidget)
    {
        mainWidget->setWindowTitle(tr2i18n("Form", 0));
    } // retranslateUi

};

namespace Ui {
    class mainWidget: public Ui_mainWidget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // KCM_PLAYBARSHORTCUTS_H

