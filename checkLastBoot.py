#!/usr/bin/env python
import os
import subprocess

apk_loaded = "/data/params/d/APKLoaded"
last_boot = "/data/params/d/LastBootedRepo"
file_exists = os.path.exists("%s" % apk_loaded)

loaded = False

if file_exists:
  f = open("%s" % apk_loaded, "r")
  loaded = True if f.read().rstrip('\r\n') == '1' else False
  f.close()
else:
  username = subprocess.check_output("ls -ld /data/openpilot | perl -lne 'print $1 if /-\> (.*)/'", shell=True)
  os.system("echo %s > %s" % (username.rstrip('\r\n'), last_boot))
  os.system("echo 1 > %s" % apk_loaded)
  loaded = True

if (not loaded):
  # Revert to last good booted repo
  f = open("%s" % last_boot, "r")
  lastboot = f.read().rstrip('\r\n')
  cmd = "ln -s %s /data/openpilot" % lastboot
  os.system("rm /data/openpilot")
  os.system("%s" % cmd)

os.system("echo 0 > %s" % apk_loaded)
