# ATU-L21: Huawei Y6 2018 (msm8917, A-only, 8.0 vendor) — Android 12 Go based on phh v416
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/atu_l21.mk \
    $(LOCAL_DIR)/atu_l21_microg.mk
COMMON_LUNCH_CHOICES := \
    atu_l21-userdebug \
    atu_l21_microg-userdebug
