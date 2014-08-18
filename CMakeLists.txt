project(PlayBar)

find_package(KDE4 REQUIRED)

include(KDE4Defaults)

add_subdirectory( contents )
add_subdirectory( engine )
#This is not yet implemented
#add_subdirectory( kcm_shortcuts )

install( FILES metadata.desktop CHANGELOG.md DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbar/ )
