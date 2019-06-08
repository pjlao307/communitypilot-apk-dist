#!/usr/bin/bash

now=`date +"%Y/%m/%d %T"`

export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib 
export HOME=/data/data/com.termux/files/home 
export PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin

if [ $1 = "switch" ] 
then
  echo "[ $now ] Switching to repo '$2'"
  if [ ! -d /data/openpilot.$2 ] 
  then
    echo "[ $now ] Repo '$2' does not exists, exiting"
    exit
  fi  

  now=`date +"%Y/%m/%d %T"`
  echo "[ $now ] Cleaning repo"
  cd /data/openpilot.$2 
  /data/data/com.termux/files/usr/bin/git checkout apk/ai.comma.plus.offroad.apk

  now=`date +"%Y/%m/%d %T"`
  echo "[ $now ] Switching branch $4"
  /data/data/com.termux/files/usr/bin/git checkout $4
  echo "[ $now ] Copying APK to /data/openpilot.$2/apk/"
  cp /data/communitypilot_scripts/ai.comma.plus.offroad.apk /data/openpilot.$2/apk/

  now=`date +"%Y/%m/%d %T"`
  echo "[ $now ] linking repository"
  rm /data/openpilot
  ln -sf /data/openpilot.$2 /data/openpilot
  echo "[ $now ] Done, rebooting"
  service call power 16 i32 0 i32 0 i32 1
elif [ $1 = 'update' ]
then
  curl -L https://github.com/pjlao307/communitypilot-apk-dist/raw/master/update.py | python
  service call power 16 i32 0 i32 0 i32 1
elif [ $1 = 'currentrepo' ]
then
  ls -ld /data/openpilot | perl -lne 'print $1 if /-\> \/data\/(.*)/'
fi
