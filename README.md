# BruTus (BrunnensTatus)
This simply RP2040 board delivers the status of a well and its water level.


# hardware
waveshare RP2040-Zero
https://www.waveshare.com/rp2040-zero.htm


## build firmware
# prepare for build
    mkdir build
    cd build
    cmake ..
# build/rebuild
    make


# schematic
    ____        ____
    oooo|      |oooo
    oooo|      |oooo
    oooo|  X3  |oooo
    oooo|      |oooo
    oooo|      |oooo
    oooo|  X2  |oooo
    oooo|      |oooo
    oooo|      |oooo
    oooo|  X1  |oooo
    oooo--------oooo
    oooooooooooooooo
    oooooooooooooooo


# pinout
    X3 = 11;
    X2 = 12;
    X1 = 13;
