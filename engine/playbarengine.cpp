/*
 * Copyright (C) 2014  smith AR <audoban@openmailbox.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#include "playbarengine.h"
#include "service.h"

#include <Plasma/DataContainer>
#include <Plasma/DataEngineManager>

using Plasma::DataContainer;
using Plasma::DataEngineManager;

PlayBarEngine::PlayBarEngine(QObject* parent, const QVariantList& args)
    : DataEngine(parent, args)
{
    Q_UNUSED(args)
    mediaActions = 0;
    setMinimumPollingInterval(-1);
}


PlayBarEngine::~PlayBarEngine()
{
    if (mediaActions) {
        mediaActions->clear();
        delete mediaActions;
    }
}

Service* PlayBarEngine::serviceForSource(const QString& source)
{
    if (source != "Shortcuts") return createDefaultService(this);
    return new PlayBarService(this);
}


void PlayBarEngine::init()
{
    DataEngineManager* engine = DataEngineManager::self();
    mpris2 = engine->loadEngine("mpris2");
    //updateSourceEvent("Shortcuts");
}

KAction* PlayBarEngine::createAction(const char* name)
{
    QString text;
    if (strcmp(name, "PlayPause") == 0)
        text = ki18n("Play").toString() + '/' + ki18n("Pause").toString();
    else text = ki18n(name).toString();

    KAction* action = new KAction("PlayBar: "+text, 0);
    action->setObjectName(name);
    action->setParent(mediaActions);
    action->setGlobalShortcut(KShortcut());
    return action;
}

KAction* PlayBarEngine::createAction(const char* name, Qt::Key key)
{
    KAction* action = createAction(name);
    action->setGlobalShortcut(KShortcut(key));
    return action;
}


bool PlayBarEngine::sourceRequestEvent(const QString& source)
{
    if (source != "Shortcuts") return false;

    if (mediaActions) return true;
    mediaActions = new KActionCollection(this->parent(), *(new KComponentData("PlayBar")));

    KAction* previous =
        createAction("Previous", Qt::Key_MediaPrevious);
    KAction* pause =
        createAction("Pause", Qt::Key_MediaPause);
    KAction* play =
        createAction("Play", Qt::Key_MediaPlay);
    KAction* stop =
        createAction("Stop", Qt::Key_MediaStop);
    KAction* play_pause =
        createAction("PlayPause", Qt::Key_MediaTogglePlayPause);
    KAction* next =
        createAction("Next", Qt::Key_MediaNext);
    KAction* open =
        createAction("Open Media Player");
    KAction* quit =
        createAction("Quit Media Player");

    mediaActions->addAction("Play", play);
    mediaActions->addAction("Pause", pause);
    mediaActions->addAction("PlayPause", play_pause);
    mediaActions->addAction("Stop", stop);
    mediaActions->addAction("Previous", previous);
    mediaActions->addAction("Next", next);
    mediaActions->addAction("Open", open);
    mediaActions->addAction("Quit", quit);
    mediaActions->setConfigGlobal(true);
    mediaActions->setConfigGroup("PlayBar");

    connect(play_pause, SIGNAL(triggered(bool)), this, SLOT(playpause()));
    connect(play, SIGNAL(triggered(bool)), this, SLOT(play()));
    connect(pause, SIGNAL(triggered(bool)), this, SLOT(pause()));
    connect(stop, SIGNAL(triggered(bool)), this, SLOT(stop()));
    connect(next, SIGNAL(triggered(bool)), this, SLOT(next()));
    connect(previous, SIGNAL(triggered(bool)), this, SLOT(previous()));
    connect(open, SIGNAL(triggered(bool)), this, SLOT(open()));
    connect(quit, SIGNAL(triggered(bool)), this, SLOT(quit()));

    return updateSourceEvent(source);
}


bool PlayBarEngine::updateSourceEvent(const QString& source)
{
    QList<QAction*> actions = mediaActions->actions();

    foreach (const QAction * act, actions) {
        setData(source, act->text(), (static_cast<const KAction*>(act))->globalShortcut().toString());
    }
    setData(source, "SourceMpris2", mpris2Source);
    return true;
}

void PlayBarEngine::startOperation(const QString& name)
{
    serv = mpris2->serviceForSource(mpris2Source);
    op = serv->operationDescription(name);
    job = serv->startOperationCall(op);
    connect(job, SIGNAL(finished(KJob*)), serv, SLOT(deleteLater()));
}


//SLOTS
void PlayBarEngine::playpause()
{
    updatePS();
    if (mpris2Source == "spotify") {
        startOperation("PlayPause");
        return;
    }
    if (playing) startOperation("PlayPause");
    else startOperation("Play");

}

void PlayBarEngine::play()
{
    updatePS();
    if (mpris2Source == "spotify" && !playing) startOperation("PlayPause");
    else if (!playing) startOperation("Play");
}

void PlayBarEngine::pause()
{
    updatePS();
    if (mpris2Source == "spotify" && playing) startOperation("Play");
    else if (playing) startOperation("Pause");
}

void PlayBarEngine::stop()
{
    updatePS();
    if (data.value("PlaybackStatus") != "Stopped") startOperation("Stop");
}

void PlayBarEngine::next()
{
    startOperation("Next");
}

void PlayBarEngine::previous()
{
    startOperation("Previous");
}

void PlayBarEngine::open()
{
    startOperation("Raise");
}

void PlayBarEngine::quit()
{
    startOperation("Quit");
}


QString PlayBarEngine::mpris2Source;

K_EXPORT_PLASMA_DATAENGINE(playbarkeys, PlayBarEngine)

#include "playbarengine.moc"
// kate: indent-mode cstyle; indent-width 4; replace-tabs on;
