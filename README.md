MICROPLAY-HUB (RetroPie-N3XT)
========================

<img src="https://github.com/microplay-hub/mpcore-splashscreens/raw/master/mpcore-splashscreen.png" width="320" height="180"><img src="https://github.com/Liontek1985/rpmenu-icons/raw/master/icons_nes/rpsetup.png" width="180" height="180"><img src="https://github.com/Liontek1985/tekcommand/raw/master/configs/nes/launching.png" width="300" height="160">

This custom fork from RetroPie is optimized by microplay-hub and Liontek1985 for Allwinner-Devices(H3, H6, H616) and similar like sunxi and Raspberry PI Series

## General Information

Shell script to setup sunxi Devices (Allwinner) like Orangepi, Bananapi, Mangopi, Tritium with many emulators and games, using a custom version of EmulationStation as the graphical front end. https://microplay-hub.de

This script is designed for use on Armbian OS or Debian OS on your SBC-Board.

To run the RetroPie Setup Script make sure that your APT repositories are up-to-date and that Git is installed:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git
```

Then you can download the latest RetroPie setup script with:

```shell
cd
git clone --depth=1 https://github.com/microplay-hub/RetroPie-N3XT.git
```

The script is executed with:

```shell
cd RetroPie-Setup
sudo ./retropie_setup.sh
```

When you first run the script it may install some additional packages that are needed.


## RetroPie Menu-Screenshorts (MPCORE)

<img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-managepackages.png" width="400" height="240"><img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-packages-list.png" width="400" height="240"></br>
<img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-config.png" width="400" height="240"><img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-cfg-list.png" width="400" height="240"></br>
<img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-update.png" width="400" height="240"><img src="https://github.com/microplay-hub/mpcore-library/raw/main/Imagebase/_Moduls/retropie-reboot.png" width="400" height="240">


## Microplay Guides
You can find useful information and guides on the mpcore-library(https://github.com/microplay-hub/mpcore-library/tree/main/Guides)

For more information, visit the site at https://microplay-hub.de or the repository at https://github.com/microplay-hub/RetroPie-N3XT.
