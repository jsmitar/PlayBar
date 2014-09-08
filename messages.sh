#!/bin/bash
shopt -s extglob

help="\n
-add-language <LANGUAGE>\n
-u, -update-pot\n
-c, -compile-po"

if [ -z "$1" ] ; then
    echo -e $help ; exit
fi

xgettext="xgettext -ki18n -C"
extractrc="extractrc"

output_po='./messages.po'
output_pot='./messages.pot'
playbar_mo='plasma_applet_playbar.mo'
playbar_po='playbar.po'
input_files=(./plasmoid/contents/{ui,code}/*.*)
locale_dir='./plasmoid/locale'

if [ $1 == '-add-language' ] && [ -n $2  ] ; then
   mkdir -p "$locale_dir/$2/LC_MESSAGES"
   $xgettext -o $locale_dir/$2/"LC_MESSAGES"/$playbar_po ${input_files[@]} ./rc.js
   exit
fi

if [ $1 == '-u' ] || [ $1 == '-update-pot' ] ; then
    echo "input files: " ${input_files[@]}
    $extractrc './plasmoid/contents/ui/config.ui' > 'rc.js'
    $xgettext -o "$output_po" ${input_files[@]} ./rc.js
    mv $output_po $output_pot
    exit
fi

if [ $1 == '-c' ] || [ $1 == '-compile-po' ] ; then
    for d in $locale_dir/* ; do
        echo "Building $d/LC_MESSAGES/playbar.mo ..."
        msgfmt "$d/LC_MESSAGES/$playbar_po" -o "$d/LC_MESSAGES/$playbar_mo"
    done
fi
