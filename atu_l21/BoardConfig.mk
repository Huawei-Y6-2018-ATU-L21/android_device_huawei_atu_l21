# ATU-L21: phh arm64 GSI board + device-specific settings
include device/phh/treble/phhgsi_arm64_ab/BoardConfig.mk

# With 2SI the root is the read-only system; the Huawei vendor/odm init mounts onto these.
BOARD_ROOT_EXTRA_FOLDERS += firmware dsp cust version patch_hw log

# system = mmcblk0p54, 0xa4000000 bytes. Shared blocks disabled so `mount -o rw,remount /` works.
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE :=
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2751463424
BOARD_EXT4_SHARE_DUP_BLOCKS :=

# Labels for the root mount points
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/atu/atu_l21/sepolicy
