# ATU-L21: vanilla (no Google services); F-Droid is installed as a user app on first boot
include device/atu/atu_l21/atu_l21_common.mk
PRODUCT_NAME := atu_l21

PRODUCT_PACKAGES += \
    atu-firstboot-apps \
    atu_app_fdroid
