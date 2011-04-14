#!/bin/bash
########################################################
# Copyright 2011 Yigit Ozkan.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0
########################################################
# this little script will install some additional software on your Fedora installation for more pleasure and ease of use.
# this script WILL install non-proprietary (non-open-source software).

# based on http://www.fedorafaq.com/ (13/4/2011)

# PACKAGE SHOULD BE RUN AS ROOT

echo 'Fedora_Restricted_Extras by Yigit Ozkan. All logs are in /tmp/ and begin with yo_*.log'

# adding rpmfusion repository
echo 'Adding rpmfusion repository. All events will be logged to /tmp/yo_rpm.log'
yum --nogpgcheck install http://rpm.livna.org/livna-release.rpm http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm >> /tmp/yo_rpm.log

# installing java
echo 'Installing Java plugin. All events will be logged to /tmp/yo_java.log'
yum install java-1.6.0-openjdk-plugin >> /tmp/yo_java.log

# installing Flash in Firefox
echo '(in 3 steps) Installing Flash in Firefox. All events will be logged to /tmp/yo_flash1.log, /tmp/yo_flash2.log and /tmp/yo_flash3.log'
echo '1/3) Adding Adobe repository for yum'
yum --nogpgcheck install http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm >> /tmp/yo_flash1.log
echo '2/3) Installing Flash plugin'
yum install --exclude=AdobeReader* flash-plugin nspluginwrapper.{i686,x86_64} pulseaudio-libs.i686 alsa-plugins-pulseaudio.i686 libcurl.i686 >> /tmp/yo_flash2.log
echo '3/3) Configuring Firefox to see the plugin'
mozilla-plugin-config -i -g -v >> /tmp/yo_flash3.log

# installing mozplugger & xpdf
echo 'Do you wanna see PDF files inside your browser?'
echo 'Installing mozplugger and xpdf. All events will be logged to /tmp/yo_mplugger_xpdf.log'
yum install mozplugger xpdf >> /tmp/yo_mplugger_xpdf.log

# installing totem plugin
echo 'Do you wanna watch movies in your web browser?'
echo 'Installing Totem plugin. All events will be logged to /tmp/yo_totem.log'
yum install totem-mozplugin gstreamer-plugins-ugly gstreamer-plugins-bad >> /tmp/yo_totem.log

# installing pidgin
echo 'Do you wanna use MSN Messenger/AIM/ICQ/Yahoo instant messaging in Fedora?'
echo 'Installing Pidgin. All events will be logged to /tmp/yo_pdgn.log'
yum install pidgin >> /tmp/yo_pdgn.log

# installing standard Windows fonts
echo 'Do you wanna install standard Windows fonts on Fedora?'
echo '1/5) Installing chkfontpath package from ATrpms. All events will be logged to /tmp/yo_chk1.log (for 64-bit) and to /tmp/yo_chk2.log (for 32-bit)'
yum install --nogpgcheck http://dl.atrpms.net/all/chkfontpath-1.10.1-2.fc14.x86_64.rpm >> /tmp/yo_chk1.log
yum install --nogpgcheck http://dl.atrpms.net/all/chkfontpath-1.10.1-2.fc14.i686.rpm >> /tmp/yo_chk2.log
echo "2/5) Installing some packages we'll need for the following steps. All events will be logged to /tmp/yo_fntpckgs.log"
yum install rpm-build cabextract ttmkfdir wget >> /tmp/yo_fntpckgs.log
echo '3/5) Downloading the MS Core Fonts Smart Package File. All events will be logged to /tmp/yo_corefonts.log'
wget http://corefonts.sourceforge.net/msttcorefonts-2.0-1.spec >> /tmp/yo_corefonts.log
echo '4/5) Building the Core Fonts package. All events will be logged to /tmp/yo_build_core_fonts.log'
rpmbuild -ba msttcorefonts-2.0-1.spec >> /tmp/yo_build_core_fonts.log
echo '5/5) Installing Core Fonts package. All events will be logged to /tmp/yo_install_core_fonts.log'
yum install --nogpgcheck /root/rpmbuild/RPMS/noarch/msttcorefonts-2.0-1.noarch.rpm >> /tmp/yo_install_core_fonts.log

# drivers have been SKIPPED. you'll have to do it manually.

# read NTFS drive
echo 'Do you wanna read your NTFS partition in Fedora? Yes, you can!'
echo 'Installing ntfs-3g. All events will be logged /tmp/yo_ntfs.log'
yum install ntfs-3g >> /tmp/yo_ntfs.log

# edit menus in panel
echo 'Do you wanna edit the menus in the panel?'
echo 'Installing Alacarte. All events will be logged to /tmp/yo_alacarte.log'
yum install alacarte >> /tmp/yo_alacarte.log

# installing wine
echo 'Installing Wine (Wine is a way of running some Windows programs on Linux). All events will be logged /tmp/yo_wine.log'
yum install wine >> /tmp/yo_wine.log

# playing DVDs
echo 'Do you wanna play DVDs in Fedora?'
echo 'Installing some additional packages for Totem. All events will be logged to /tmp/yo_dvd.log'
yum install libdvdread libdvdcss libdvdnav gstreamer-plugins-ugly gstreamer-plugins-bad >> /tmp/yo_dvd.log

# play MP3s
echo 'Do you wanna play MP3s in Fedora?'
echo '1/2) Installing MP3 plugin for Rhythmbox or Totem. All events will be logged to /tmp/yo_mp3rt.log'
yum install gstreamer-plugins-ugly >> /tmp/yo_mp3rt.log
echo '2/2) Installing MP3 plugin for Audacious. All events will be logged to /tmp/yo_mp3a.log'
yum install audacious-plugins-freeworld-mp3 >> /tmp/yo_mp3a.log

# NOKEY warning solution
echo 'Solutions for NOKEY warning:'
echo 'Importing Red Hat and Fedora keys'
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*
echo 'Importing Livna.org key'
rpm --import http://rpm.livna.org/RPM-LIVNA-GPG-KEY
echo 'Importing FreshRPMs key'
rpm --import http://freshrpms.net/RPM-GPG-KEY-freshrpms
echo 'Importing DAG key'
rpm --import http://dag.wieers.com/packages/RPM-GPG-KEY.dag.txt
echo 'Importing ATRPMs key'
rpm --import http://atrpms.net/RPM-GPG-KEY.atrpms
echo 'Importing NewRPMs key'
rpm --import http://newrpms.sunsite.dk/gpg-pubkey-newrpms.txt
echo 'Importing "Dries" (RPMForge) key'
rpm --import http://apt.sw.be/dries/RPM-GPG-KEY.dries.txt
echo 'Importing JPackage key'
rpm --import http://www.jpackage.org/jpackage.asc
echo 'Importing kde-redhat key'
rpm --import http://kde-redhat.sourceforge.net/gpg-pubkey-ff6382fa-3e1ab2ca
echo 'Importing PlanetCCRMA key'
rpm --import http://ccrma.stanford.edu/planetccrma/RPM-GPG-KEY.planetccrma.txt

# enabling 3D support ATI Radeon card SKIPPED. user should do it manually.
# enabling 3D support nVidia graphics card SKIPPED. user should do it manually.

# CD's aren't bad!!!!!!
echo "Your CDs aren't bad! Fixing bug in kernel."
linux mediacheck ide=nodma

########################################################
# end of script
########################################################
# all credits go to the maintainer of the FedoraFAQ (http://www.fedorafaq.com/), Max Kanat-Alexander. That's max [at] fedorafaq *dot* org or "mkanat" in the #fedora IRC channel.
# yigit ozkan (yigitozkan2804@gmail.com) has only written this script in his free time.
# this script is licensed under the Apache license (see above)
# (you may) do the fuck you want with this.
# i don't care if you steal it, brotha!
# i love pull requests on GitHub.
########################################################
########################################################
########################################################
