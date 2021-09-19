
# Setting up a Fedora System (as per Jeff)

## Get home folder copied over

Ideally this would be a "restore from backup", to test my backup system,
but currently I'm using Deja Dup, which backs up every day but can't
actually restore anything.

## Add RPMFusion

From: https://rpmfusion.org/Configuration

 * Follow install directions.  I used the graphical install, just click the packages and type in password twice.
 * Run `dnf groupupdate core`, for Appstream data (software manager, probably not necessary).
 * Run `dnf groupupdate multimedia`, which installs a TON of codecs.
 * Run `dnf groupupdate sound-and-video`, did nothing?
 * `dnf install rpmfusion-free-release-tainted`, `dnf install rpmfusion-nonfree-release-tainted`

I don't actually use libdvdcss at this point or any of the firmwares, so I'm just going to leave this for now.

# Update the system

    sudo dnf upgrade -y

# Install my favorite packages

```
cd ~/env
sudo <~/env/packages.txt xargs dnf install -y
```

# Spotify

The Spotify license prohibits redistributing packages, so we have to do use the Linux Package Factory (lpf).

https://www.itsmarttricks.com/how-to-install-spotify-music-streaming-on-fedora-30-linux-workstation/

    usermod -a -G pkg-build jeff
    ## Log out and log in, or run `bash`.
    sudo dnf install -y lpf-spotify-client
    lpf update spotify-client

    ## Kill when it asks for a password so that we can inspect the package.
    ## Looks good, lets install it.
    sudo dnf install /var/lib/lpf/rpms/spotify-client/spotify-client-1.1.26.501-1.fc32.x86_64.rpm

# Zoom

Get from their website: https://zoom.us/support/download

At this time (2020-08-01), the package is "nice" (no pre/post install scripts that break things), so just install it the normal way. :)

# Slack

https://slack.com/intl/en-ca/downloads/linux

No scripts, but it does install a little backdoor cronjob.  You could delete the cron.d file,



# Perforce

## Command line

Website describes how to setup their repo: https://www.perforce.com/manuals/p4sag/Content/P4SAG/install.linux.packages.install.html

Packages are here: http://package.perforce.com/yum/rhel/8/x86_64/

I've had a look at the helix-cli and helix-cli-core packages, and they don't define any evil scripts or weird packages.  So I just install them as-is.  The `helix-cli-core` package installs the CLI, and `helix-cli` creates a symlink to it in /usr/bin

Their GPG check fails.  Meh, disable it for now. :/

```
sudo tee /etc/yum.repos.d/perforce.repo << EOF
[perforce]
name=Perforce
baseurl=http://package.perforce.com/yum/rhel/8/x86_64
enabled=1
gpgcheck=0
EOF

sudo dnf install -y helix-cli
```

## Visual

Download the visual client from: https://www.perforce.com/downloads/helix-visual-client-p4v

This comes down as a tarfile split into bin/ and lib/ directories.  This does *not* come with
the p4 command line client.

I just extract it into my .local folder and then create a symlink to it.


# General Admin

* Disable cron, used for evil more often than good:

    systemctl stop crond
    systemctl disable crond

* Disable multipathd, failing on my current system and I don't care:

    systemctl stop multipathd
    systemctl disable multipathd

* Set hostname, Installer makes us `localhost.localdomain` by default :/

    echo rosario | sudo tee /etc/hostname


# Is my backup script working?

Run `scu status backup`.  Last time we were lacking duplicity, but it's good to check.

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
