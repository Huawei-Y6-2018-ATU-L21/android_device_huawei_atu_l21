# ATU-L21: what is needed to run the Android 8.0 Huawei/Qualcomm vendor on Android 12.
# Details: docs/PATCHES.md in the android_huawei_atu_l21 repository

# --- Compatibility libraries (device/atu/compat) ---
PRODUCT_PACKAGES += \
    atu_compat_hidl_base \
    atu_compat_hidl_manager \
    libatu_shim \
    libatu_audio_shim \
    atu_compat_icuuc

# --- Libraries the 8.0 vendor expects in /system (not installed by default on Android 12) ---
PRODUCT_PACKAGES += \
    android.hardware.camera.device@1.0 \
    android.hardware.camera.provider@2.4 \
    android.hardware.gatekeeper@1.0 \
    android.hardware.graphics.composer@2.1 \
    android.hardware.health@1.0 \
    android.hardware.keymaster@3.0 \
    android.hardware.nfc@1.0 \
    android.hardware.soundtrigger@2.0 \
    android.hardware.usb@1.0 \
    android.hardware.wifi.supplicant@1.0 \
    android.hardware.audio.common@2.0-util \
    libaudioroute \
    libnbaio \
    libwifi-system \
    libwifi-system-iface \
    libfs_mgr

# --- Services running from the system side ---
PRODUCT_PACKAGES += \
    atu_vndservicemanager \
    atu_health_2_0_service \
    atu_omx_service

# --- Overlays (8.0 SDM HWC layer limit; see docs/PATCHES.md) ---
PRODUCT_PACKAGES += \
    AtuOverlaySystemUI \
    AtuOverlayFramework \
    AtuOverlaySettingsProvider

# --- init / marker files (VINTF fragments live in the libatu_shim module) ---
PRODUCT_COPY_FILES += \
    device/atu/compat/atu-shim.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/zz-atu-shim.rc \
    device/atu/compat/atu-overrides.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/atu-overrides.rc \
    device/atu/atu_l21/files/atu_disable_fbe:$(TARGET_COPY_OUT_SYSTEM)/etc/atu_disable_fbe \
    device/atu/atu_l21/files/atu_disable_verity:$(TARGET_COPY_OUT_SYSTEM)/etc/atu_disable_verity

# --- Android 9 (VNDK 28) protobuf; linkerconfig "legacy_vendor" section (RIL libsettings, Widevine) ---
# No libbinder here: Parcel size compatibility is solved in the Android 12 libbinder (one vndbinder protocol).
PRODUCT_COPY_FILES += \
    $(foreach a,lib lib64,$(foreach l,libprotobuf-cpp-full libprotobuf-cpp-lite,\
        device/atu/compat/atu-compat-libs/$(a)/$(l).so:$(TARGET_COPY_OUT_SYSTEM)/$(a)/atu-compat/$(l).so))

# AOSP library that was in /system on 8.0 but not on Android 12 (from the stock C432 system.img; webrtc, BSD licensed):
# noise suppression / echo cancellation preprocessing of the audio effect HAL (calls). Only the legacy_vendor section sees it.
PRODUCT_COPY_FILES += \
    $(foreach a,lib lib64,device/atu/compat/atu-compat-libs/stock/$(a)/libwebrtc_audio_preprocessing.so:$(TARGET_COPY_OUT_SYSTEM)/$(a)/atu-compat/libwebrtc_audio_preprocessing.so)

# --- Prop'lar ---
# The Huawei kernel log prefix sends the logd.klogd parser into a 100% CPU loop.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.logd.kernel=false

# Android 12 Go / 2 GB RAM. The product partition is loaded last, so it overrides the vendor
# values (Huawei default.prop dalvik.vm.heapsize=36m).
# The 8.0 vendor build.prop sets ro.product.brand=Android; product is loaded last and overrides it.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.product.brand=HUAWEI

# Without a value ColorDisplayService picks "BOOSTED" (saturation 1.1) -> non-identity color matrix ->
# the 8.0 SDM HWC sends the whole frame to the GPU. Natural color (1.0) is the default.
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.sf.color_saturation=1.0

# The 8.0 perf HAL (vendor.qti.hardware.perf) aborts with a HIDL error when releasing a perflock; then the camera
# provider crashes in openCamera. The video codec and camera dlopen the perflock library named by this prop;
# with an unloadable name ("none") they run without perflocks.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.vendor.extension_library=none

PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.low_ram=true \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=128m \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m \
    ro.lmk.use_psi=false \
    ro.lmk.use_minfree_levels=true \
    ro.lmk.critical_upgrade=true \
    ro.lmk.upgrade_pressure=40 \
    ro.lmk.downgrade_pressure=60 \
    ro.lmk.kill_heaviest_task=false \
    dalvik.vm.dex2oat-threads=2 \
    dalvik.vm.image-dex2oat-threads=2 \
    debug.sf.latch_unsignaled=1 \
    debug.sf.disable_backpressure=1
