# ATU-L21: microG (GmsCore + Companion + GsfProxy + Aurora Store)
include device/atu/atu_l21/atu_l21_common.mk
$(call inherit-product, vendor/atu/atu-microg/microg.mk)
PRODUCT_NAME := atu_l21_microg
