project(PlayBar)

find_package(KDE4 REQUIRED)

include(KDE4Defaults)

add_subdirectory( contents )
add_subdirectory( KCM_PlayBarShortcuts )
add_subdirectory( PlayBarEngine )

install( FILES metadata.desktop CHANGELOG.md DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbar/ )
