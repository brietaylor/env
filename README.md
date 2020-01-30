# env

In this turbulent day and age, it has yet become impossible to log into a system and have a tasteful set of editor defaults ready to go.  Thus, I must store a set of custom editor settings so that the many machines I use may have some semblence of harmony.

The person reading this may, upon his or her discretion, choose that a thing such as custom editor settings is not worth one's time.  That is acceptable.  If the reader wishes for a glimpse into the author's soul—I offer no guarantee of your sanity—but nonetheless, kindly welcome you.

# 51-garmin.rules

    $ sudo cp 51-garmin.rules /etc/udev/rules.d/

Been a while since I've used this...  IIRC it allows programs like gpsbabel
to access my Garmin GPS without being root.  Might also need to blacklist the
kernel `garmin_gps` driver

# 50-accelerometer.hwdb

    $ sudo cp 50-accelerometer.hwdb /etc/udev/hwdb.d/

This file fixes accelerometer directions on my HP CW-series laptop.  I've
tried an upstream push to systemd, but they'd prefer a kernel patch.

https://github.com/systemd/systemd/pull/10532 (failed PR)
