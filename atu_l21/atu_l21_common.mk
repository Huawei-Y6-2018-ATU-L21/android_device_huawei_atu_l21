# ATU-L21: common product base. Same stack as AndyYan's treble_arm64_avN (phh A-only arm64, vanilla, no su;
# root via Magisk) plus the device configuration. Product names deliberately have no "lineage_" prefix:
# that prefix switches the build to Lineage device-tree mode (BoardConfigLineage, device/lineage/sepolicy),
# which the phh GSI base is not made for.
TARGET_GAPPS_ARCH := arm64
$(call inherit-product, device/phh/treble/base-pre.mk)
include build/make/target/product/aosp_arm64_ab.mk
$(call inherit-product, vendor/vndk/vndk.mk)
# No phh hardware_overlay list (TrebleApp "Phh Treble Settings" + ~340 overlays for other phones); only the overlays
# that are active on ATU-L21 (checked with `cmd overlay dump` on the phone).
TARGET_PHH_NO_HARDWARE_OVERLAYS := true
$(call inherit-product, device/phh/treble/base.mk)
PRODUCT_PACKAGES += \
    treble-overlay-huawei-ATU \
    treble-overlay-devinputjack \
    treble-overlay-NightMode \
    treble-overlay-highpriomisc \
    treble-overlay-Telephony-LTE \
    treble-overlay-SystemUI-FalseLocks
$(call inherit-product, device/phh/treble/base-sas.mk)
$(call inherit-product, device/phh/treble/lineage.mk)
$(call inherit-product, device/atu/atu_l21/device.mk)

PRODUCT_DEVICE := atu_l21
PRODUCT_BRAND := HUAWEI
PRODUCT_MANUFACTURER := HUAWEI
PRODUCT_MODEL := ATU-L21
