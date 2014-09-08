/*
 * <one line to give the library's name and an idea of what it does.>
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

#include "service.h"
#include "playbarengine.h"

#include <filetype.h>
#include <id3v2tag.h>
#include <tfile.h>
#include <tpropertymap.h>
#include <tstring.h>

#define QStrToTStr(s) TagLib::String(s.toUtf8().data(), TagLib::String::UTF8)
#define TStrToQStr(s) QString::fromUtf8(s.toCString(true))

using namespace TagLib;

PlayBarService::PlayBarService(const DataEngine::Data& data, QObject* parent)
    : Service(parent), data(data)
{
    setName("playbarservice");
}

ServiceJob* PlayBarService::createJob(const QString& operation,
                                      QMap< QString, QVariant >& parameters)
{
    setDestination(name() + ": " + operation);
    parameters.insert("Metadata", data.value("Metadata"));

    return new Job(destination(), operation, parameters, this);
}

Job::Job(const QString& destination,
         const QString& operation,
         const QMap< QString, QVariant >& parameters,
         QObject* parent):
    ServiceJob(destination, operation, parameters, parent)
{
}

void Job::start()
{
    const QString operation(operationName());

    bool result = false;

    if (operation == QLatin1String("SetSource")) {
        PlayBarEngine::p_mpris2Source = parameters().value("name").toString();
        result = true;
    } else if (operation == QLatin1String("SetRating")) {
        const QVariantMap metadata(parameters().value("Metadata").toMap());

        if (metadata.isEmpty()) qDebug() << "metadata isEmpty";

        result = setRating(metadata.value("xesam:url").toString(), parameters().value("rating", "0").toString());
    }

    setResult(result);
}

bool Job::setRating(const QString& url, const QString& rating)
{
//     File *f(0);
//     f = FileType::createFile(url);
//
//     ID3v2::Tag* tag = f
//
//     if (tag && !tag->isEmpty()) {
//         PropertyMap props(tag->properties());
//         const TagLib::String FMPS_RATING("FMPS_RATING");
//
//         props.replace(FMPS_RATING, QStrToTStr(rating));
//
//         qDebug() << "f->tag: " << TStrToQStr(tag->properties().toString());
//         qDebug() << "props" << TStrToQStr(props.toString());
//         qDebug() << "fileName: " << fileName;
//         qDebug() << "rating: " << rating;
//         bool propsReplaced = tag->setProperties(props) == props;
//         f->save();
//         if (propsReplaced) return true;
//     }

    return false;
}


#include "service.moc"
// kate: indent-mode cstyle; indent-width 4; replace-tabs on;
