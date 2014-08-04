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

#include <qtest_kde.h>

QTEST_KDEMAIN(PlayBarEngine, NoGUI);

void PlayBarEngine::initTestCase()
{
    // Called before the first testfunction is executed
}

void PlayBarEngine::cleanupTestCase()
{
    // Called after the last testfunction was executed
}

void PlayBarEngine::init()
{
    // Called before each testfunction is executed
}

void PlayBarEngine::cleanup()
{
    // Called after every testfunction
}

PlayBarEngine::PlayBarEngine(QObject* parent, const QVariantList& args): DataEngine(parent, args)
{

}

K_EXPORT_PLASMA_DATAENGINE(playbarkeys, PlayBarEngine)

#include "playbarengine.moc"
