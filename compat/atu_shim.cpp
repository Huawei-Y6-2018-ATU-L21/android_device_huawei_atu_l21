// ATU-L21: Android 12 compatibility shim for Android 8.0 vendor binaries.
// Loaded through libhidltransport (linked by every 8.0 HIDL user) and the hidl.base stub.
#include <new>

#include <android/log.h>

// 1) liblog: android_log_shouldPrintLine is not exported on Android 12 (used by Huawei libhwlog).
static int atu_unused_shouldPrintLine(void* /*format*/, const char* /*tag*/, int pri) {
    return pri >= ANDROID_LOG_DEBUG;
}

// Old logprint API: Huawei libhwlog tries to print the line itself; ignore it.
static int atu_unused_printLogLine(void* /*format*/, int /*fd*/, const void* /*entry*/) {
    return 0;
}

// 2) The old libbase LogMessage constructor -> lives in system/libbase/logging.cpp (ATU-L21).

// 3) HIDL descriptor symbols: constexpr in headers on Android 12, not exported from the .so.
extern "C" {
__attribute__((visibility("default"))) const char* atu_health10_desc
        __asm__("_ZN7android8hardware6health4V1_07IHealth10descriptorE") =
                "android.hardware.health@1.0::IHealth";
}

// 4) HIDL toString: inline in headers on Android 12; Android 8.0 vendor libraries look for the exported
//    versions. They only produce debug text, so a numeric rendering is enough.
#include <cstdint>
#include <string>

#define ATU_TOSTRING(TYPE, SYM) \
    __attribute__((visibility("default"))) std::string SYM##_impl(TYPE v) __asm__(#SYM); \
    std::string SYM##_impl(TYPE v) { return std::to_string(v); }

ATU_TOSTRING(int32_t, _ZN7android10frameworks13sensorservice4V1_08toStringENS2_6ResultE)
ATU_TOSTRING(int32_t, _ZN7android8hardware4gnss4V1_08toStringENS2_15IGnssNiCallback18GnssNiEncodingTypeE)
ATU_TOSTRING(uint32_t, _ZN7android8hardware4gnss4V1_08toStringENS2_15IGnssNiCallback20GnssUserResponseTypeE)
ATU_TOSTRING(int32_t, _ZN7android8hardware4gnss4V1_08toStringENS2_21IGnssGeofenceCallback18GeofenceTransitionE)
ATU_TOSTRING(uint32_t, _ZN7android8hardware4gnss4V1_08toStringINS2_15IGnssNiCallback17GnssNiNotifyFlagsEEENSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEj)
ATU_TOSTRING(int32_t, _ZN7android8hardware4gnss4V1_08toStringINS2_21IGnssGeofenceCallback18GeofenceTransitionEEENSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEi)
ATU_TOSTRING(int32_t, _ZN7android8hardware5radio4V1_08toStringENS2_13PersoSubstateE)
ATU_TOSTRING(int32_t, _ZN7android8hardware5radio4V1_08toStringENS2_9CallStateE)
ATU_TOSTRING(int32_t, _ZN7android8hardware8graphics6common4V1_08toStringENS3_11PixelFormatE)

__attribute__((visibility("default"))) std::string atu_wifi_cb_tostring(const void* sp)
        __asm__("_ZN7android8hardware4wifi4V1_08toStringERKNS_2spINS2_22IWifiChipEventCallbackEEE");
std::string atu_wifi_cb_tostring(const void*) { return "IWifiChipEventCallback"; }

// 5) libhwbinder: IPCThreadState::disableBackgroundScheduling(bool) (wpa_supplicant) — removed in Android 12.
extern "C" __attribute__((visibility("default"))) void atu_disable_bg_sched(bool)
        __asm__("_ZN7android8hardware14IPCThreadState27disableBackgroundSchedulingEb");
extern "C" void atu_disable_bg_sched(bool) {}

// 6) tinyxml2 XMLDocument(bool) -> lives in external/tinyxml2 (ATU-L21).
