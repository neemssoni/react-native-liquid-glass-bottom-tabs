cmake_minimum_required(VERSION 3.4.1)
project(LiquidGlassBottomTabs)

set (CMAKE_VERBOSE_MAKEFILE ON)

add_library(
    react-native-liquid-glass-bottom-tabs    STATIC
    ../cpp/LiquidGlassBottomTabsImpl.cpp
)

set_target_properties(
    react-native-liquid-glass-bottom-tabs PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_include_directories(
    react-native-liquid-glass-bottom-tabs    PUBLIC
    ../cpp
)

target_link_libraries(
    react-native-liquid-glass-bottom-tabs    jsi
    reactnative
    react_codegen_LiquidGlassBottomTabsSpec
)
