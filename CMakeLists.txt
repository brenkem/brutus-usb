cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(brutus_usb C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(brutus_usb brutus_usb.c)

pico_enable_stdio_usb(brutus_usb 1)
pico_enable_stdio_uart(brutus_usb 0)

pico_add_extra_outputs(brutus_usb)

target_link_libraries(brutus_usb pico_stdlib)
