install_phonesky()
{
    pm install --dont-kill "$MODPATH/system/priv-app/Phonesky/Phonesky.apk"
    pm grant com.android.vending android.permission.FAKE_PACKAGE_SIGNATURE
}

if $BOOTMODE; then

    pm install --dont-kill -g "$MODPATH/system/priv-app/GmsCore/GmsCore.apk"
    pm install --dont-kill "$MODPATH/SigSpoofHelper.apk" 2>/dev/null
    rm -f "$MODPATH/SigSpoofHelper.apk"
    if [ -f /data/adb/Phonesky.apk ]; then
        cp /data/adb/Phonesky.apk "$MODPATH/system/priv-app/Phonesky/Phonesky.apk"
        # If the real Play Store is already installed, don't install it again since
        # it will result in an error if real Play Store is not patched and has
        # already auto-updated itself
        if [ ! $(pm list packages | grep com.android.vending) ]; then
            ui_print "- Installing real Play Store"
            install_phonesky
        fi
    else
        ui_print "- Real Play Store not found, installing Fake Store"
        install_phonesky
    fi

else
    abort "- ERROR: Installation via recovery is NOT supported."
fi

