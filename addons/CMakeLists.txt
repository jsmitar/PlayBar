install(FILES metadata.desktop
        DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbaraddons/ )

install(DIRECTORY contents
        DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbaraddons )

install(FILES metadata.desktop
        DESTINATION ${KDE4_SERVICES_INSTALL_DIR} RENAME playbaraddons.desktop )
