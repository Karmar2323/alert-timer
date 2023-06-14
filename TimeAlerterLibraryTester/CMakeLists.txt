cmake_minimum_required(VERSION 3.5)

project(file_test LANGUAGES CXX)

enable_testing()

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Test) #Gui
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Test) #Gui

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(file_test tst_file_test.cpp)
add_test(NAME file_test COMMAND file_test)

qt_add_library(filehandler STATIC
    ../filehandler.cpp
    ../filehandler.h
)

qt_add_resources(file_test "resources"
    PREFIX "/"
    FILES
    resources/coreProps.json
    resources/test1.txt)

target_link_libraries(filehandler PRIVATE Qt6::Core)

target_link_libraries(file_test PRIVATE Qt${QT_VERSION_MAJOR}::Test
    filehandler
    Qt6::Core)
#Qt${QT_VERSION_MAJOR}::Gui

