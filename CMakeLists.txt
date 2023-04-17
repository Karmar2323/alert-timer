cmake_minimum_required(VERSION 3.16)

project(TimeAlerter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appTimeAlerter
    main.cpp
    backend.h
    backend.cpp
)

qt_add_qml_module(appTimeAlerter
    URI TimeAlerter
    VERSION 1.0
    QML_FILES Main.qml

    RESOURCES
    logic.mjs
)

set_target_properties(appTimeAlerter PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTimeAlerter
    PRIVATE Qt6::Quick
)

install(TARGETS appTimeAlerter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})