# android_device_huawei_atu_l21 — branch `lineage-17.1`

Device configuration for an **unofficial** LineageOS 17.1 (Android 10) build for the Huawei Y6 2018 (ATU-L21).
Not affiliated with or endorsed by the LineageOS project.

The build is AndyYan's `treble_arm64_avN` stack (phh A-only arm64 GSI on top of LineageOS 17.1) plus:

| File | What |
|---|---|
| `atu_l21/atu_l21_common.mk` | product base, brand/model |
| `atu_l21/atu_l21.mk` / `atu_l21_microg.mk` | vanilla (F-Droid on first boot) / microG flavour |
| `atu_l21/BoardConfig.mk` | phh `phhgsi_arm64_a` board, system partition size |
| `atu_l21/system.prop` | identity, Android Go, llkd off, logd and display workarounds |
| `atu_l21/atu-l21.rc` | Go heap values (the 8.0 vendor overrides them otherwise) |

The phone keeps the stock Android 8.0 init in the ramdisk (only file-based encryption is disabled), so
`/product/build.prop` is not read and `/vendor/build.prop` is loaded after `/system/build.prop`; see `device.mk`.

Build instructions and the source patches: [android_huawei_atu_l21](https://github.com/Huawei-Y6-2018-ATU-L21/android_huawei_atu_l21).
