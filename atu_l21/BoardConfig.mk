# ATU-L21: phh A-only arm64 board + device-specific settings
include device/phh/treble/phhgsi_arm64_a/BoardConfig.mk

# system = mmcblk0p54, 0xa4000000 bytes (fixed size instead of the generic board's reserved-size mode)
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE :=
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2751463424

# Goes into /system/build.prop (see system.prop)
TARGET_SYSTEM_PROP += device/atu/atu_l21/system.prop
