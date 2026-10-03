// ATU-L21: Android 8.0 vendor ses HAL'i (android.hardware.audio@2.0-impl) eski android::HidlUtils
// symbols; on Android 12 the class moved under ...::audio::common::V2_0::implementation.
#include <memory>

#include <android/hardware/audio/common/2.0/types.h>
#include <system/audio.h>
#include <utils/Errors.h>

using ::android::status_t;
using ::android::hardware::hidl_vec;
using namespace ::android::hardware::audio::common::V2_0;

namespace android::hardware::audio::common::V2_0::implementation {
struct HidlUtils {
    static status_t audioConfigFromHal(const audio_config_t&, bool isInput, AudioConfig*);
    static status_t audioConfigToHal(const AudioConfig&, audio_config_t*);
    static status_t audioPortConfigToHal(const AudioPortConfig&, struct audio_port_config*);
    static status_t audioPortConfigsToHal(const hidl_vec<AudioPortConfig>&,
                                          std::unique_ptr<audio_port_config[]>*);
    static status_t audioPortFromHal(const struct audio_port&, AudioPort*);
    static status_t audioPortToHal(const AudioPort&, struct audio_port*);
};
}  // namespace android::hardware::audio::common::V2_0::implementation

namespace android {
using NewUtils = ::android::hardware::audio::common::V2_0::implementation::HidlUtils;

// Old (Android 8.0) signatures; symbol names match the vendor binary exactly.
struct __attribute__((visibility("default"))) HidlUtils {
    static void audioConfigFromHal(const audio_config_t& hal, AudioConfig* c);
    static void audioConfigToHal(const AudioConfig& c, audio_config_t* hal);
    static void audioPortConfigToHal(const AudioPortConfig& c, struct audio_port_config* hal);
    static std::unique_ptr<audio_port_config[]> audioPortConfigsToHal(
            const hidl_vec<AudioPortConfig>& configs);
    static void audioPortFromHal(const struct audio_port& hal, AudioPort* p);
    static void audioPortToHal(const AudioPort& p, struct audio_port* hal);
};

void HidlUtils::audioConfigFromHal(const audio_config_t& hal, AudioConfig* c) {
    NewUtils::audioConfigFromHal(hal, false, c);
}
void HidlUtils::audioConfigToHal(const AudioConfig& c, audio_config_t* hal) {
    NewUtils::audioConfigToHal(c, hal);
}
void HidlUtils::audioPortConfigToHal(const AudioPortConfig& c, struct audio_port_config* hal) {
    NewUtils::audioPortConfigToHal(c, hal);
}
std::unique_ptr<audio_port_config[]> HidlUtils::audioPortConfigsToHal(
        const hidl_vec<AudioPortConfig>& configs) {
    std::unique_ptr<audio_port_config[]> out;
    NewUtils::audioPortConfigsToHal(configs, &out);
    return out;
}
void HidlUtils::audioPortFromHal(const struct audio_port& hal, AudioPort* p) {
    NewUtils::audioPortFromHal(hal, p);
}
void HidlUtils::audioPortToHal(const AudioPort& p, struct audio_port* hal) {
    NewUtils::audioPortToHal(p, hal);
}
}  // namespace android
