set(playbar_src code config theme ui)

install(FILES metadata.desktop
        DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbar/ )

install(DIRECTORY ${playbar_src}
        DESTINATION ${DATA_INSTALL_DIR}/plasma/plasmoids/playbar/contents )

install(FILES metadata.desktop
        DESTINATION ${KDE4_SERVICES_INSTALL_DIR} RENAME playbar.desktop )
