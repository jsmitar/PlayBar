/***************************************************************************
 *   Copyright (C) %{CURRENT_YEAR} by %{AUTHOR} <%{EMAIL}>                 *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

#include "kcm_playbarshortcuts.h"

#include <KPluginFactory>
#include <KPluginLoader>
#include <KAboutData>
#include <QBoxLayout>

#include <KAction>
#include <KIcon>
#include <Plasma/DataEngine>

K_PLUGIN_FACTORY(PlayBarShortcutsFactory, registerPlugin<KCM_PlayBarShortcuts>();)

K_EXPORT_PLUGIN(PlayBarShortcutsFactory(
                    "kcm_playbarshortcuts" /* kcm name */,
                    "kcm_playbarshortcuts" /* catalog name */)
               )

KCM_PlayBarShortcuts::KCM_PlayBarShortcuts(QWidget*& parent, const QVariantList& args)
    : KCModule(PlayBarShortcutsFactory::componentData(), parent, args)
{
    KAboutData about("simple",
                     0,
                     ki18n("KCM_PlayBarShortcuts"), "0.6",
                     ki18n("Configure PlayBar global shortcuts"),
                     KAboutData::License_GPL,
                     ki18n("(C) 2014 Smith AR"),
                     KLocalizedString(),
                     0,
                     "audoban@openmailbox.org");

    about.addAuthor(ki18n("Smith AR"), KLocalizedString(), "mail@example.com");

    //Layout

    QVBoxLayout* vBox = new QVBoxLayout();

    shortcutsWidget = new KShortcutsEditor(0, KShortcutsEditor::GlobalAction);
    shortcutsWidget->setMinimumSize(200, 200);

    this->setLayoutDirection(Qt::LayoutDirectionAuto);
    this->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    this->setLayout(vBox);

    //create action collection
    createMediaActions(shortcutsWidget);
    shortcutsWidget->addCollection(actions, "PlayBar");

    vBox->addWidget(shortcutsWidget);

    mpris2 = new MprisService(parent, args);
}

KCM_PlayBarShortcuts::~KCM_PlayBarShortcuts()
{
}

void KCM_PlayBarShortcuts::createMediaActions(QWidget* parent)
{
    actions = new KActionCollection(parent);

    KAction* previous = createAction("media-skip-backward", "Previous", Qt::Key_MediaPrevious, actions);

    KAction* pause = createAction("media-playback-pause", "Pause", Qt::Key_MediaPause, actions);

    KAction* play = createAction("media-playback-start", "Play", Qt::Key_MediaPlay, actions);

    KAction* stop = createAction("media-playback-stop", "Stop", Qt::Key_MediaStop, actions);

    KAction* play_pause = createAction("media-playback-start", "Play/Pause", Qt::Key_MediaTogglePlayPause, actions);

    KAction* next = createAction("media-skip-forward", "Next", Qt::Key_MediaNext, actions);

    actions->addAction("Play", play);
    actions->addAction("Pause", pause);
    actions->addAction("Play/Pause", play_pause);
    actions->addAction("Stop", stop);
    actions->addAction("Previous", previous);
    actions->addAction("Next", next);
    actions->setConfigGlobal(true);
}

KAction* KCM_PlayBarShortcuts::createAction(const char* icon, const char* name, Qt::Key key, QObject* parent)
{
    KAction *action = new KAction(KIcon(icon), ki18n(name).toString(), parent);
    action->setObjectName(name);
    action->setGlobalShortcutAllowed(true);
    action->setGlobalShortcut(KShortcut(key));

    return action;
}

// kate: indent-mode cstyle; indent-width 4; replace-tabs on;
