#!/usr/bin/bash

export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
export HOME=/data/data/com.termux/files/home
export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin

if [ $1 = 'install' ]
then
  echo "Configuring custom APK $2"
  cd /data/openpilot
  username=`/data/data/com.termux/files/usr/bin/git remote -v | head -1 | /data/data/com.termux/files/usr/bin/perl -lne 'print $1 if /\.com\/(.*)\/openpilot/'`
  branch=`/data/data/com.termux/files/usr/bin/git status | head -1 | /data/data/com.termux/files/usr/bin/perl -lne 'print $1 if /On branch (.*)$/'`
  mv /data/openpilot /data/openpilot.$username
  ln -s /data/openpilot.$username /data/openpilot
  cp $2/ai.comma.plus.offroad.apk /data/openpilot/apk/
  echo "{\"apk_hash\":\"$3\",\"config_url\":\"$4\",\"installer\":\"$5\",\"apk_url\":\"$6\",\"repos\":[{\"name\":\"openpilot\",\"user\":\"$username\"}]}" > /data/params/d/CommunityPilotConfig

  #We do this because if the repo auto updates the APK gets reverted
  sed -i 's/cd \/data\/openpilot/python \/data\/communitypilot_scripts\/checkLastBoot.py\ncp \/data\/communitypilot_scripts\/ai\.comma\.plus\.offroad\.apk \/data\/openpilot\/apk\/\ncd \/data\/openpilot/' /data/data/com.termux/files/continue.sh
fi
