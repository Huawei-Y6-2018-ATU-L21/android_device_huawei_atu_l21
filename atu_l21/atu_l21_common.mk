# ATU-L21: common product base — phh treble_arm64_bvN (no su; root via Magisk) + device configuration.
# Varyantlar: atu_l21.mk (vanilla), atu_l21_microg.mk (microG).
TARGET_GAPPS_ARCH := arm64
$(call inherit-product, device/phh/treble/base-pre.mk)
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/phh/treble/base.mk)
$(call inherit-product, device/atu/atu_l21/device.mk)

PRODUCT_DEVICE := atu_l21
PRODUCT_BRAND := HUAWEI
PRODUCT_SYSTEM_BRAND := HUAWEI
PRODUCT_MANUFACTURER := HUAWEI
PRODUCT_MODEL := ATU-L21
PRODUCT_SYSTEM_MODEL := ATU-L21
PRODUCT_SYSTEM_MANUFACTURER := HUAWEI

PRODUCT_CHARACTERISTICS := device

# Browser: Jelly (LineageOS, Apache-2.0; packages/apps/Jelly lineage-19.1, uses the system WebView)
PRODUCT_PACKAGES += \
    Jelly
