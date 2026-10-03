# android_device_huawei_atu_l21

Device configuration for running Android 12 (phh-treble v416 base) on the **Huawei Y6 2018 (ATU-L21)**
with its stock Android 8.0 vendor. Clone into `device/atu`:

```bash
git clone https://github.com/Huawei-Y6-2018-ATU-L21/android_device_huawei_atu_l21 device/atu
```

Full build guide and the reasoning behind every change:
[android_huawei_atu_l21](https://github.com/Huawei-Y6-2018-ATU-L21/android_huawei_atu_l21).

## Layout

| Path | Content |
|---|---|
| `atu_l21/AndroidProducts.mk` | Lunch targets `atu_l21-userdebug` (vanilla) and `atu_l21_microg-userdebug` |
| `atu_l21/atu_l21_common.mk` | Common product: phh `treble_arm64_bvN` + `device.mk` + Jelly |
| `atu_l21/BoardConfig.mk` | phh arm64 GSI board, root mount points, system partition size (0xa4000000), no shared blocks |
| `atu_l21/device.mk` | Packages, compat libraries, props (Go/low-RAM, perflock off, color, brand) |
| `atu_l21/sepolicy/` | file_contexts for root mount points and system-side services |
| `atu_l21/overlay-*` | RROs: no privacy-dot layers, no wallpaper zoom / rounded corners, clean-install defaults |
| `compat/` | 8.0 vendor compatibility: hidl.base/manager stubs, `libatu_shim`, ICU stub, init overrides, VINTF fragments, Android 9 protobuf, webrtc preprocessing |

## Dependencies

- `vendor/atu` → [android_vendor_atu](https://github.com/Huawei-Y6-2018-ATU-L21/android_vendor_atu) (microG / F-Droid packages)
- Patched AOSP tree → [atu_l21_patches](https://github.com/Huawei-Y6-2018-ATU-L21/atu_l21_patches)

## Binaries in this repository

- `compat/atu-compat-libs/{lib,lib64}/libprotobuf-cpp-{lite,full}.so` — AOSP Android 9 (VNDK 28) protobuf, Apache-2.0/BSD;
  needed by the 8.0 RIL (`libsettings`), Widevine and the audio preprocessing library.
- `compat/atu-compat-libs/stock/{lib,lib64}/libwebrtc_audio_preprocessing.so` — AOSP WebRTC audio processing (BSD),
  taken from the stock ATU-L21 C432 system image; used by the audio effect HAL (call noise suppression/echo cancellation).

## License

Apache-2.0.
