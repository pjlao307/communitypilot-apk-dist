<p align="center">
<img src="https://github.com/pjlao307/communitypilot-apk-dist/raw/master/images/header.jpg">
</p>

CommunityPilot APK Distribution
======
This repository contains the pre-compiled custom openpilot apk (offroad) that includes additional functionality.

Current functionality include:
* Ability to switch between different repositories loaded on the EON.

Installation
------
To install this on your EON you need to SSH into your EON and run this command:

```
curl -L https://raw.githubusercontent.com/pjlao307/communitypilot-apk-dist/master/install.py | python
```

This install script will configure your EON to use the custom APK.  Once done you will need to reboot your EON.  You can access this functionality under the Settings > CommunityPilot Forks menu.

Usage
------
In order to switch between repositories on your EON that repository will need to already be cloned onto your EON.

Each repository that you want to be able to switch to will need to be cloned into directory name in the following format:
```/data/openpilot.USERNAME```
where USERNAME is the github username of the owner of the repository.

For example, for the comma.ai openpilot you would run this command:

```git clone https://github.com/commaai/openpilot.git /data/openpilot.commaai```

This USERNAME should match the Github username field when you add the repository from the GUI.

[![](https://github.com/pjlao307/communitypilot-apk-dist/raw/master/images/add_repo.jpg)](#)

When you switch to a different fork logging information is stored in a log file in `/data/communitypilot_scripts/cp.log` that you can view to see what has been done.

Known Issues
------
There is a known issue in the Settings > Account screen where it does not allow you to log into your Google account but instead shows you a "Device Paired: Yes" setting.  This issue has been submitted to the official openpilot-apk repository.

Contribution
------
Pull requests are welcome.  Please visit the source repository at https://github.com/pjlao307/openpilot-apks to submit PRs or issues.

Acknowledgment
------
**BIG THANKS to [comma.ai](https://comma.ai)** for providing an awesome development kit platform!

