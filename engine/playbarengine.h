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

#ifndef PLAYBARENGINE_H
#define PLAYBARENGINE_H

#include <Plasma/DataEngine>
#include <Plasma/DataContainer>
#include <Plasma/Service>
#include <Plasma/ServiceJob>

#include <KAction>
#include <KActionCollection>
#include <KConfigGroup>

using Plasma::Service;

class PlayBarEngine : public Plasma::DataEngine
{
    Q_OBJECT
public:
    PlayBarEngine(QObject* parent, const QVariantList& args);
    virtual ~PlayBarEngine();

    virtual Service* serviceForSource(const QString& source);

    static QString mpris2Source;

protected:

    virtual void init();
    virtual bool sourceRequestEvent(const QString& source);
    virtual bool updateSourceEvent(const QString& source);

private slots:
    void playpause();
    void play();
    void pause();
    void stop();
    void next();
    void previous();

private:
    void startOperation(const QString& name);
    KAction* createAction(const char* name, Qt::Key key);
    inline void updatePS(){
        data = mpris2->query(mpris2Source);
        playing = data.value("PlaybackStatus", "") == "Playing";
    };

    Plasma::DataEngine* mpris2;
    Plasma::DataEngine::Data data;
    Plasma::Service* serv;
    Plasma::ServiceJob* job;
    KActionCollection* mediaActions;
    KConfigGroup op;
    bool playing;

};

#endif // PLAYBARENGINE_H
// kate: indent-mode cstyle; indent-width 4; replace-tabs on;
