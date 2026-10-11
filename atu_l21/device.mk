# ATU-L21: device configuration on top of the phh A-only GSI base.
# The ramdisk keeps the stock (Huawei-modified) Android 8.0 init (only FBE is disabled there), which matters for
# properties. It loads /system/etc/prop.default, then /vendor/build.prop, and never /system/build.prop or
# /product/build.prop (tested on the phone). BoardConfig.mk has build.prop appended to prop.default, so ro.* values
# from the system win (first write); other values (dalvik.vm.heap*) are overwritten by the vendor -> set again from
# init (atu-l21.rc).
PRODUCT_COPY_FILES += \
    device/atu/atu_l21/atu-l21.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/atu-l21.rc
