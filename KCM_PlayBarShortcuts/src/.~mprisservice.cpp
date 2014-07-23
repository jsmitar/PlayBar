/*
 * <one line to give the program's name and a brief idea of what it does.>
 * Copyright (C) 2014  smith AR <audoban@openmailbox.org>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include "mprisservice.h"

#include "iostream"
#include <KService>
#include <KServiceTypeTrader>
#include <Plasma/Applet>

MprisService::MprisService(QObject* parent, const QVariantList& args)
: Plasma::Applet(parent, args)
{
//     KService::List services;
//     KServiceTypeTrader* trader = KServiceTypeTrader::self();
//
//     QString constraint = "'mpris2' ~~ Library";
//     services = trader->query("Plasma/DataEngine", constraint);
//
//     KService::Ptr service = services[0];

    //mpris2 = dataEngine("mpris2");
    //serv = mpris2->serviceForSource("@multiplex");
}

MprisService::~MprisService()
{
    delete serv;
}

/* Public media slots
 *
 */
void MprisService::play_pause()
{

}
void MprisService::play()
{

}
void MprisService::pause()
{

}
void MprisService::stop()
{

}
void MprisService::next()
{

}
void MprisService::previous()
{

}
void MprisService::downVolume()
{

}
void MprisService::upVolume()
{

}
void MprisService::startOperation(const QString& name)
{

}
// kate: indent-mode cstyle; indent-width 4; replace-tabs on;
