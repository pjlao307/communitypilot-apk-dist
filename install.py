#!/usr/bin/env python
import os
import json
import hashlib

script_dir = "/data/communitypilot_scripts"

def sha256_checksum(filename, block_size=65536):
  sha256 = hashlib.sha256()
  with open(filename, 'rb') as f:
    for block in iter(lambda: f.read(block_size), b''):
      sha256.update(block)
  return sha256.hexdigest()

def check_file(url, fhash, filename):
  try:
    assert sha256_checksum(filename).lower() == fhash.lower()
    print("already downloaded %s" % url)
    return
  except Exception:
    pass

  os.system("curl -O %s" % url)
  os.system("curl -L %s -o %s/%s" % (url, script_dir, filename))
  fn = url.split("/")[-1]
  assert sha256_checksum(fn).lower() == fhash.lower()
  print("hash check pass")

def download(url,filename):
  os.system("curl -L %s -o %s/%s" % (url, script_dir, filename))

def load_config(url):
  os.system("curl -L %s -o %s/config.json" % (url, script_dir))

def run_installer(url,apk_hash,config_url,apk_url):
  os.system("curl -L %s | bash -s install '%s' '%s' '%s' '%s' '%s'" % (url, script_dir, apk_hash, config_url, url, apk_url))

def install_script(url):
  os.system("curl -L %s -o %s/switchRepo.sh" % (url, script_dir))

path_exists = os.path.isdir(script_dir)
if not path_exists:
 print "Creating folder"
 os.system("mkdir %s" % script_dir)

print "Retrieving configuration"
load_config("https://raw.githubusercontent.com/pjlao307/communitypilot-apk-dist/master/config.json")
config = json.load(open("%s/config.json" % script_dir))

file_exists = os.path.exists("%s/ai.comma.plus.offroad.apk" % script_dir)
if not file_exists:
  print "Downloading APK"
  download(config['apk_url'], "ai.comma.plus.offroad.apk")

print "Running installer"
run_installer(config['installer'],config['apk_hash'],config['config_url'],config['apk_url'])

print "Installing script"
install_script(config['script_url'])

print "Installation complete - Reboot your EON"
