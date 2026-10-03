# ATU-L21: vanilla (no Google services)
include device/atu/atu_l21/atu_l21_common.mk
PRODUCT_NAME := atu_l21

# Vanilla: F-Droid as the app store (installed on first boot)
PRODUCT_PACKAGES += \
    atu-firstboot-apps \
    atu_app_fdroid
