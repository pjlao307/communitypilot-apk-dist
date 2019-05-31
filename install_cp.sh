#!/usr/bin/bash

echo "Configuring custom APK $1"
cd /data/openpilot
username=`/data/data/com.termux/files/usr/bin/git remote -v | head -1 | /data/data/com.termux/files/usr/bin/perl -lne 'print $1 if /\.com\/(.*)\/openpilot/'`
branch=`/data/data/com.termux/files/usr/bin/git status | head -1 | /data/data/com.termux/files/usr/bin/perl -lne 'print $1 if /On branch (.*)$/'`
mv /data/openpilot /data/openpilot.$username
ln -s /data/openpilot.$username /data/openpilot
cp $1/ai.comma.plus.offroad.apk /data/openpilot/apk/
echo "[{\"name\":\"openpilot\",\"user\":\"$username\",\"branch\":\"$branch\"}]" > /data/params/d/CommunityPilotConfig
echo "Done.  Reboot your EON"
