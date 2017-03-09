---
layout: post
locale: en
title:  "Installing Thunderbird on Ubuntu 15.04"
date:   2015-07-25 17:04:43
meta: How to install the lastest version of Thunderbird on your Ubuntu
excerpt: Go get the [last version](http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/latest/) of Thunderbird for your architecture in your language.
categories: ubuntu
---

{% highlight bash %}
wget ftp.mozilla.org/pub/thunderbird/releases/latest/linux-x86_64/en-GB/thunderbird-38.3.0.tar.bz2
tar -xjvf thunderbird-*
sudo rm -rf /opt/thunderbird*
sudo mv thunderbird /opt/thunderbird
sudo ln -sf /opt/thunderbird/thunderbird /usr/bin/thunderbird
{% endhighlight %}

You can now open thunderbird from your terminal by typing `thunderbird`.
If you want to access thunderbird from your dash, you might have to create a thunderbird.desktop.

{% highlight bash %}
sudo su
mkdir -pv /usr/share/{applications,pixmaps} &&

cat > /usr/share/applications/thunderbird.desktop << "EOF" &&
[Desktop Entry]
Encoding=UTF-8
Name=Thunderbird Mail
Comment=Send and receive mail with Thunderbird
GenericName=Mail Client
Exec=thunderbird %u
Terminal=false
Type=Application
Icon=thunderbird
Categories=Application;Network;Email;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/xml;application/rss+xml;x-scheme-handler/mailto;
StartupNotify=true
EOF

ln -sfv /opt/thunderbird/chrome/icons/default/default256.png /usr/share/pixmaps/thunderbird.png
{% endhighlight %}

## Linking your Microsoft Exchange Calendar with Thunderbird

You should only need to download the correct [add-on] `exchangecalendar-*.xpi` and from your thunderbird, go into Preferences > Add-ons > From file and select your freshly downloaded .xpi

[add-on]: https://github.com/Ericsson/exchangecalendar/releases
