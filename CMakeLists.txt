project(PlayBar)

find_package(KDE4 REQUIRED)

include(KDE4Defaults)

add_subdirectory( contents )
add_subdirectory( addons )
add_subdirectory( engine )
#This is not yet implemented
#add_subdirectory( kcm_shortcuts )

