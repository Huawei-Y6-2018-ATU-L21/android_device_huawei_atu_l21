// ATU-L21: the Android 8.0 vendor audio.primary.msm8937.so links ICU 58 ucnv_* functions.
// On Android 12 ICU lives in an APEX with another version (_68). Stubs that behave as if no converter can be opened:
// the audio HAL loads; optional paths that need ICU return an error.
#include <stddef.h>
#include <stdint.h>

extern "C" {
typedef int UErrorCode;
static const int U_UNSUPPORTED_ERROR = 16;

__attribute__((visibility("default"))) void* ucnv_open_58(const char*, UErrorCode* err) {
    if (err) *err = U_UNSUPPORTED_ERROR;
    return nullptr;
}
__attribute__((visibility("default"))) void ucnv_close_58(void*) {}
__attribute__((visibility("default"))) void ucnv_convertEx_58(void*, void*, char**, const char*,
                                                              const char**, const char*, void*,
                                                              void**, void**, const void*, int8_t,
                                                              int8_t, UErrorCode* err) {
    if (err) *err = U_UNSUPPORTED_ERROR;
}
__attribute__((visibility("default"))) void ucnv_setFromUCallBack_58(void*, void*, const void*,
                                                                     void*, const void**,
                                                                     UErrorCode* err) {
    if (err) *err = U_UNSUPPORTED_ERROR;
}
__attribute__((visibility("default"))) void ucnv_setToUCallBack_58(void*, void*, const void*,
                                                                   void*, const void**,
                                                                   UErrorCode* err) {
    if (err) *err = U_UNSUPPORTED_ERROR;
}
__attribute__((visibility("default"))) void UCNV_FROM_U_CALLBACK_STOP_58(const void*, void*,
                                                                         const void*, int32_t,
                                                                         int32_t, int,
                                                                         UErrorCode*) {}
__attribute__((visibility("default"))) void UCNV_TO_U_CALLBACK_STOP_58(const void*, void*,
                                                                       const char*, int32_t, int,
                                                                       UErrorCode*) {}
}
