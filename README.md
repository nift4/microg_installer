# microG Installer Revived

This is a Magisk module - originally based on Hieu Van's microG Installer - that installs microG GmsCore, GsfProxy and FakeStore (or Play Store if you want so) to `/system/priv-app`.

There are two copies of this online: The [Magisk alt module repo](https://github.com/Magisk-Modules-Alt-Repo/microG_Installer) and the [personal](https://github.com/nift4/microg_installer) one. The personal one contains the latest development version and is used for pull requests and issues and the Magisk alt repo one is the stable code only.

## Why you may want to use it

In short: this is the cleanest option to install microG and just be done with it.

UnifiedNlp, which is bundled with GmsCore, if installed as an user app doesn't work on Android 7 and newer without [an additional patch](https://github.com/microg/android_packages_apps_UnifiedNlp/blob/master/patches/android_frameworks_base-N.patch). An another solution to the above problem is to install the app as a privileged system app. However, this way is not perfect, due to those kind of apps being wiped after an OTA update. Therefore, I'm creating this module to help simplify the installation of microG with working network-based location. Aditionally, this module forces UnifiedNlp support even when no NLP provider is configured in your ROM. And GsfProxy needs to be an system app for some third-party apps.

Currently, GmsCore 0.3.1 (including Companion, previously known as FakeStore), GsfProxy 0.1.0 and MapsV1 0.1.0 are bundled in the module.

**Note**: Install this module before installing any GMS-dependent apps, as well as do not disable it after installing such apps, unless you know what you're doing.

## Installation
**Again, if you have Google services currently installed, DO NOT INSTALL THIS MODULE.**
- Choose an solution for [Signature spoofing](https://github.com/microg/android_packages_apps_GmsCore/wiki/Signature-Spoofing) (Note: If your ROM does not support signature spoofing, I recommened [whew-inc's FakeGApps fork](https://github.com/whew-inc/FakeGApps/releases))
- Install the module

## How do I get the real Play Store?

First, if you experience an bootloop, use [Magisk Safe Mode](https://topjohnwu.github.io/Magisk/faq.html#q-i-installed-a-module-and-it-bootlooped-my-device-help) to disable the module and use an older Play Store APK, then post a bug report. This module needs to be updated for new Play Store versions every while. If it boots, but Play Store is broken, it's probably a microG issue. Feel free to report issues in the bugtracker here though.

Get an Play Store APK (I suggest unpatched Play Store from APKMirror) - please note that the file has to be a non-bundle APK, which means APKM files are not supported. Then put it into `/data/adb/` named `Phonesky.apk`(`/data/adb/Phonesky.apk`). You need to do that only once. If you now install, update or reflash microG Installer Revived there will be an message "Installing real Play Store". This indicates it worked. Now grant all permissions. You can now install updates for the Play Store like for every app.

## Can I update to new versions without waiting for module updates?

**Yes**, just download the new APK (in the normal variant, not -hw or -lh) from microG GitHub, download page or microG F-Droid repo (all those use the exact same APK files!) and install it as you always would. If you use Companion, update it this way too. Please note that some F-Droid clients report signature compatibility issues, which however appears to be a problem with interactions between the microG repo, clients and signature spoofing. In this case, download the APKs using a web browser and install them normally.

## Common issues

- Magisk crashes while installation: Ignore it and manually reboot
- microG Companion / real Play Store keeps crashing: Remove it from Magisk Hide / Denylist / disable KSU Unmount modules from its app profile
- black screen / bootloop: don't use Magisk Delta's SuList
- app misbehaves/crashes with missing microg overlay (eg. chromium based browsers): disable KSU Unmount modules from its app profile
- microG itself keeps crashing: [download](https://github.com/nift4/microg_installer_revived/raw/master/system/priv-app/microG/microG.apk) & install APK as update
- can't grant background location and SMS permission: [download](https://github.com/nift4/microg_installer_revived/raw/master/system/priv-app/microG/microG.apk) & install APK as update

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
