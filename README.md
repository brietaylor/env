# Overview

Configuration files and fixes for editors, hardware, etc.

# Garmin GPS

    $ sudo cp 51-garmin.rules /etc/udev/rules.d/
    $ sudo cp garmin_gps /etc/modprobe.d/

First file allows programs like gpsbabel to access my Garmin GPS without being
root.  Second file prevents the kernel `garmin_gps` module from loading.

# HP Accelerometer

    $ sudo cp 50-accelerometer.hwdb /etc/udev/hwdb.d/

This file fixes accelerometer directions on my HP CW-series laptop.  I've
tried an upstream push to systemd, but they'd prefer a kernel patch.

https://github.com/systemd/systemd/pull/10532 (failed PR)
