if [ -n "$MMM_EXT_SUPPORT" ]; then
  ui_print "#!useExt"
  mmm_exec() {
    ui_print "$(echo "#!$@")"
  }
else
  mmm_exec() { true; }
fi
if ! $BOOTMODE; then
    abort "- ERROR: Installation via recovery is NOT supported."
fi
mmm_exec setSupportLink "https://github.com/nift4/microg_installer_revived/issues"

MAX_VER="244735012"
MAX_VERN="0.3.6.244735"

if [ -f /data/adb/Phonesky.apk ]; then
    ui_print "- INFO: Phonesky.apk is found in /data/adb, but this module no longer uses this file."
    ui_print "- INFO: It won't break anything, but having that there won't make you use real Play Store anymore."
fi

mmm_exec showLoading
ui_print "Collecting information about com.google.android.gms"
# check microG
DUMP_GMS="$(pm dump com.google.android.gms)"
if [[ $? -gt 0 ]]; then
    ui_print "- WARNING: pm dump may have failed?"
fi
ui_print "Checking if com.google.android.gms is installed"
if (echo "$DUMP_GMS" | grep "Unable to find package: com.google.android.gms") >/dev/null; then
    abort "- ERROR: You do not have official microG installed."
fi
ui_print "Collecting file path of com.google.android.gms"
GMS_PATH="$(realpath $(echo "$DUMP_GMS" | grep path: | head -n1 | cut -d: -f2))"
ui_print "Checking if file path of com.google.android.gms is on /data"
if [[ "$GMS_PATH" = "${GMS_PATH#/data/}" ]]; then
    abort "- ERROR: expected microG install path to be on /data, but it's $GMS_PATH"
fi
ui_print "Checking if file path of com.google.android.gms exists"
if ! [[ -f "$GMS_PATH" ]]; then
    abort "- ERROR: expected microG install path to exist: $GMS_PATH"
fi
ui_print "Checking if com.google.android.gms is microG"
if ! (echo "$DUMP_GMS" | grep "android.permission.FAKE_PACKAGE_SIGNATURE") >/dev/null; then
    abort "- ERROR: You appear to have Google Play Services installed instead of microG."
fi
ui_print "Checking if com.google.android.gms is a supported version"
GMS_VER="$(echo "$DUMP_GMS" | grep versionCode | head -n1 | cut -d" " -f5 | cut -d= -f2)"
GMS_VERN="$(echo "$DUMP_GMS" | grep versionName | head -n1 | cut -d" " -f5 | cut -d= -f2)"
if [[ "$GMS_VER" -gt "$MAX_VER" ]]; then
    abort "- ERROR: You have microG version $GMS_VERN ($GMS_VER) but the maximum supported version is $MAX_VERN ($MAX_VER)."
fi
# check Vending
ui_print "Collecting information about com.android.vending"
DUMP_VD="$(pm dump com.android.vending)"
if [[ $? -gt 0 ]]; then
    ui_print "- WARNING: pm dump may have failed?"
fi
ui_print "Checking if com.android.vending is installed"
if (echo "$DUMP_VD" | grep "Unable to find package: com.android.vending") >/dev/null; then
    abort "- ERROR: You do not have microG Companion or Play Store installed."
fi
ui_print "Collecting file path of com.android.vending"
VD_PATH="$(realpath $(echo "$DUMP_VD" | grep path: | head -n1 | cut -d: -f2))"
ui_print "Checking if file path of com.android.vending is on /data"
if [[ "$VD_PATH" = "${VD_PATH#/data/}" ]]; then
    abort "- ERROR: expected microG Companion / Play Store install path to be on /data, but it's $VD_PATH"
fi
ui_print "Checking if file path of com.android.vending exists"
if ! [[ -f "$VD_PATH" ]]; then
    abort "- ERROR: expected microG Companion / Play Store install path to exist: $VD_PATH"
fi
# Do install tasks
ui_print "- Installing microG GmsCore"
if [ ! -d "/my_bigball/priv-app/GmsCore" ]; then
  mkdir -p "$MODPATH/system/product/priv-app/GmsCore"
  cp "$GMS_PATH" "$MODPATH/system/product/priv-app/GmsCore/GmsCore.apk"
else
  mkdir -p "$MODPATH/system/priv-app/microG"
  cp "$GMS_PATH" "$MODPATH/system/priv-app/microG/microG.apk"
fi
if (echo "$DUMP_VD" | grep "android.permission.FAKE_PACKAGE_SIGNATURE") >/dev/null; then
  ui_print "- Installing microG Companion"
  pm grant com.android.vending android.permission.FAKE_PACKAGE_SIGNATURE 2>/dev/null
  ui_print "Installing microG Companion"
else
  ui_print "- Installing Play Store"
fi
if ! [ -d "/my_bigball/priv-app/GmsCore" ]; then
  mkdir -p "$MODPATH/system/product/priv-app/Phonesky"
  cp "$VD_PATH" "$MODPATH/system/product/priv-app/Phonesky/Phonesky.apk"
else
  mkdir -p "$MODPATH/system/priv-app/Phonesky"
  cp "$VD_PATH" "$MODPATH/system/priv-app/Phonesky/Phonesky.apk"
fi
mmm_exec hideLoading
