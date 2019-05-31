CommunityPilot APK Distribution
======
This repository contains the pre-compiled custom openpilot apk (offroad) that includes additional functionality.

Current functionality inlcude:
* Ability to switch between different repositories loaded on the EON.

Installation
------
To install this on your EON you need to SSH into your EON and run this command:

```
curl -L https://raw.githubusercontent.com/pjlao307/communitypilot-apk-dist/master/install.py | python
```

This install script will configure your EON to use the custom APK.  Once done you will need to reboot your EON.  You can access this functionality under the Settings > CommunityPilot Forks menu.

Contribution
------
Pull requests are welcome.  Please visit the source repository at https://github.com/pjlao307/openpilot-apk to submit PRs or issues.
