# ATU-L21: device configuration on top of the phh A-only GSI base.
# The ramdisk keeps the stock Android 8.0 init (only FBE is disabled there), which matters for properties:
#  - /product/build.prop is never loaded -> everything goes to /system/build.prop (system.prop);
#  - /vendor/build.prop is loaded AFTER /system/build.prop: ro.* values from system win (first write),
#    other values (dalvik.vm.heap*) are overwritten by the vendor -> set again from init (atu-l21.rc).
PRODUCT_COPY_FILES += \
    device/atu/atu_l21/atu-l21.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/atu-l21.rc
