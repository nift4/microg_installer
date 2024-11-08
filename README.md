## This project is in reduced maintenance / no support mode and I will only release updates for my personal usage from now on. There are too many issues with KernelSU, stock ROMs and everything too far from my personal usecase, and I'd rather use my free time with other projects, so I am not really able (or motivated) to support most cases anymore. If you can, use recovery-based installers, those will always be more reliable and universal.
## For better KernelSU support and an alternative that works (mainly Android 14 AOSP ROMs), check out [MinMicroG - Official Repo](https://github.com/FriendlyNeighborhoodShane/MinMicroG) and [MinMicroG - a Fork with a compatibility patch](https://github.com/HPsaucii/MinMicroG/tree/NikFixes) (works out of the box this way).

# microG Installer Revived

This is a Magisk module - originally based on Hieu Van's microG Installer - that installs microG GmsCore, GsfProxy and Companion (or Play Store if you want so) to `/system/priv-app`.

Currently, GmsCore 0.3.2 (including Companion, previously known as FakeStore) and earlier are supported. GsfProxy 0.1.0 and MapsV1 0.1.0 are bundled in the module.

**Note**: Install this module before installing any GMS-dependent apps, as well as do not disable it after installing such apps, unless you know what you're doing.

There are two copies of this online: The [Magisk alt module repo](https://github.com/Magisk-Modules-Alt-Repo/microG_Installer) and the [personal](https://github.com/nift4/microg_installer) one. The personal one contains the latest development version and is used for pull requests and issues and the Magisk alt repo one is the stable code only.

## Installation
**Again, if you have Google services currently installed, DO NOT INSTALL THIS MODULE.**
- Choose an solution for [Signature spoofing](https://github.com/microg/android_packages_apps_GmsCore/wiki/Signature-Spoofing) (Note: If your ROM does not support signature spoofing, I recommened [whew-inc's FakeGApps fork](https://github.com/whew-inc/FakeGApps/releases))
- Install microG 0.3.2 and Companion (or real Play Store) as normal user app
- Install the module to convert them to system apps with all bells and whistles (like Maps V1, GsfProxy, etc)

## How do I get the real Play Store?

First, if you experience an bootloop, use [Magisk Safe Mode](https://topjohnwu.github.io/Magisk/faq.html#q-i-installed-a-module-and-it-bootlooped-my-device-help) to disable the module and use an older Play Store APK, then post a bug report. This module needs to be updated for new Play Store versions every while. If it boots, but Play Store is broken, it's probably a microG issue. Feel free to report issues in the bugtracker here though.

Get an Play Store APK (I suggest unpatched Play Store from APKMirror) - please note that the file has to be a non-bundle APK, which means APKM files are not supported. Then, just install it before flashing the module! If you now install, update or reflash microG Installer Revived there will be an message "Installing real Play Store". This indicates it worked. Now grant all permissions. You can now install updates for the Play Store like for every app.

Note: previously, this module told you to put it into `/data/adb/Phonesky.apk`. This is no longer needed and the module will ignore that file.

## Can I update to new versions without waiting for module updates?

**Yes**, just download the new APK (in the normal variant, not -hw or -lh) from microG GitHub, download page or microG F-Droid repo (all those use the exact same APK files!) and install it as you always would **without reflashing the module**. If you use Companion, update it this way too. Please note that some F-Droid clients report signature compatibility issues, which however appears to be a problem with interactions between the microG repo, clients and signature spoofing. In this case, download the APKs using a web browser and install them normally.

## Common issues

- black screen / bootloop: don't use Magisk Delta's SuList
- app misbehaves/crashes with missing microg overlay (eg. chromium based browsers): disable KSU Unmount modules from its app profile
- can grant SMS permission but can't grant background location: go to App Info > Permissions > Location > (press "Location access" in the warning dialog), then go back to self test and try to grant background location again - it should now work
- real Play Store error DF-DFERH-01: make sure you have Device Registration enabled in microG settings, and make sure Internet access is enabled for Play Store and microG (some custom ROMs have a toggle in App info)

## Build

### Linux, BSD, macOS, Android
Requires wget.

    wget -O META-INF/com/google/android/update-binary https://raw.githubusercontent.com/topjohnwu/Magisk/master/scripts/module_installer.sh && zip microG_Installer_Revived.zip -9r * -x update.json


### Other
Download [this](https://raw.githubusercontent.com/topjohnwu/Magisk/master/scripts/module_installer.sh) and put it into `META-INF/com/google/android/update-binary`. And ZIP it.

### About microGOverlay.apk
This APK file is an simple overlay containing configuration for UnifiedNlp. The source can not be checked in into this git repository because of compatibility reasons with module repositories, so I posted the trivial source code on [an extra branch](https://github.com/nift4/microg_installer_revived/tree/overlay). You can use any signing keystore to sign the overlay, but it needs to be signed.

## Credits

- **microG project** for their awesome work
- **Hieu Van** for the [original microG Installer](https://github.com/nift4/microg_installer_revived/tree/23de13101d8dd5807f713d0cace4a565478c6cfd)
- **Fs00** for many bug fixes
- **chris42** and **FriendlyNeighborhoodShane** for privapp permission files
- **felinira**, **akaessens** and **soracqt** for contributing through pull requests
