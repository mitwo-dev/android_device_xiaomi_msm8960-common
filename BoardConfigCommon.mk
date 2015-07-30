#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/xiaomi/msm8960-common

TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true

QCOM_BOARD_PLATFORMS         := msm8960
TARGET_BOARD_PLATFORM        := msm8960
TARGET_BOOTLOADER_BOARD_NAME := MSM8960

# Flags
TARGET_GLOBAL_CFLAGS   += -DQCOM_HARDWARE
TARGET_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE
COMMON_GLOBAL_CFLAGS   += -D__ARM_USE_PLD -D__ARM_CACHE_LINE_SIZE=64

# Architecture
TARGET_CPU_ABI             := armeabi-v7a
TARGET_CPU_ABI2            := armeabi
TARGET_CPU_SMP             := true
TARGET_CPU_VARIANT         := krait
TARGET_ARCH                := arm
TARGET_ARCH_VARIANT        := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
BOARD_USES_QCOM_HARDWARE   := true

# Krait optimizations
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET            := true
TARGET_KRAIT_BIONIC_PLDOFFS         := 10
TARGET_KRAIT_BIONIC_PLDTHRESH       := 10
TARGET_KRAIT_BIONIC_BBTHRESH        := 64
TARGET_KRAIT_BIONIC_PLDSIZE         := 64

# boot image
BOARD_KERNEL_BASE     := 0x80200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET  := 0x02000000
BOARD_MKBOOTIMG_ARGS  := --ramdisk_offset 0x02000000
BOARD_KERNEL_CMDLINE  := console=null androidboot.hardware=qcom ehci-hcd.park=3 maxcpus=2 androidboot.bootdevice=msm_sdcc.1 androidboot.selinux=permissive
TARGET_PREBUILT_KERNEL :=

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
TARGET_USES_WCNSS_CTRL           := true
TARGET_USES_QCOM_WCNSS_QMI       := true
TARGET_WCNSS_MAC_PREFIX          := e8bba8
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"

# FM
COMMON_GLOBAL_CFLAGS     += -DQCOM_FM_ENABLED
QCOM_FM_ENABLED          := true
BOARD_HAVE_QCOM_FM       := true
AUDIO_FEATURE_ENABLED_FM := true

# QCOM BSP
COMMON_GLOBAL_CFLAGS += -DQCOM_BSP
TARGET_USES_QCOM_BSP := true

# QCOM enhanced A/V
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Display
TARGET_USES_ION                 := true
USE_OPENGL_RENDERER             := true
TARGET_USES_C2D_COMPOSITION     := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# GPU
OVERRIDE_RS_DRIVER              := libRSDriver_adreno.so
HAVE_ADRENO_SOURCE              := false
BOARD_EGL_CFG                   := $(LOCAL_PATH)/configs/egl.cfg

# Audio
BOARD_USES_ALSA_AUDIO               := true
TARGET_USES_QCOM_MM_AUDIO           := true
TARGET_USES_QCOM_COMPRESSED_AUDIO   := true
BOARD_USES_LEGACY_ALSA_AUDIO        := true
QCOM_ANC_HEADSET_ENABLED            := true
QCOM_FLUENCE_ENABLED                := false
TUNNEL_MODE_SUPPORTS_AMRWB          := true
USE_TUNNEL_MODE                     := true
QCOM_TUNNEL_LPA_ENABLED             := true
QCOM_PROXY_DEVICE_ENABLED           := true
QCOM_ACDB_ENABLED                   := true
QCOM_AUDIO_FORMAT_ENABLED           := true
QCOM_CSDCLIENT_ENABLED              := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE  := true
AUDIO_FEATURE_ENABLED_AUXPCM_BT     := false
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS  := true
QCOM_OUTPUT_FLAGS_ENABLED           := true
QCOM_USBAUDIO_ENABLED               := true
QCOM_FLUENCE_ENABLED                := true
QCOM_MULTI_VOICE_SESSION_ENABLED    := true

# GPS
#The below will be needed if we ever want to build GPS HAL from source
#TARGET_PROVIDES_GPS_LOC_API := true
#BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
#TARGET_NO_RPC := true

# Bluetooth
BOARD_HAVE_BLUETOOTH       := true
BOARD_HAVE_BLUETOOTH_QCOM  := true
BLUETOOTH_HCI_USE_MCT      := true

# Webkit
ENABLE_WEBGL            := true
TARGET_FORCE_CPU_UPLOAD := true

# Recovery
TARGET_RECOVERY_FSTAB            := $(LOCAL_PATH)/rootdir/etc/fstab.qcom

# Lights HAL
TARGET_PROVIDES_LIBLIGHT := true

# SELinux
-include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    device/xiaomi/msm8960-common/sepolicy

BOARD_SEPOLICY_UNION += \
       btnvtool.te \
       syspart_select.te

BOARD_USES_SECURE_SERVICES := true

SUPERUSER_EMBEDDED := true

PRODUCT_BOOT_JARS += \
    qcom.fmradio \
    qcmediaplayer \
    org.codeaurora.Performance \
    tcmiface

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# legacy support flags
TARGET_USES_LOGD := false

MALLOC_IMPL := dlmalloc

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(call match-word-in-list,$(TARGET_BUILD_VARIANT),user),true)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

ifdef CM_BUILD
# Try to build the kernel
TARGET_KERNEL_SOURCE := kernel/xiaomi/aries
TARGET_KERNEL_CONFIG := aries-perf_defconfig

# Use CM PowerHAL by default
TARGET_POWERHAL_VARIANT := cm
endif

# TWRP config
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_HAS_NO_REAL_SDCARD := true
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
TW_INCLUDE_L_CRYPTO := true
TW_FLASH_FROM_STORAGE := true
TW_NO_USB_STORAGE := false

TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/usb-otg"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "usb-otg"
