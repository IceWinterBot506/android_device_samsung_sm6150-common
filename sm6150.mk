#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

COMMON_PATH := device/samsung/sm6150-common

PRODUCT_TARGET_VNDK_VERSION := 29

# AID/fs configs
PRODUCT_PACKAGES += \
    fs_config_files

# Camera
PRODUCT_PACKAGES += \
    Snap

# Input
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl

# IPC router config
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config \
    $(COMMON_PATH)/configs/sec_config_oem:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config_oem

# IRQ
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service.samsung \
    libkeymaster4support.vendor:64 \
    libkeymaster4_1support.vendor:64

# Media
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/media/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(COMMON_PATH)/configs/media/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml \
    $(COMMON_PATH)/configs/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(COMMON_PATH)/configs/media/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    device/samsung/qcom-common/overlay \
    $(COMMON_PATH)/overlay \
    $(COMMON_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    $(COMMON_PATH)/overlay-lineage/lineage-sdk \
    $(COMMON_PATH)/overlay-lineage/packages/apps/Snap
 
# OTA Updater
AB_OTA_UPDATER := false

# Public Libraries
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# QCOM
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    $(COMMON_PATH)/configs/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    hostapd \
    libwifi-hal-qcom \
    wcnss_service \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(COMMON_PATH)/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(COMMON_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# Get non-open-source specific aspects
$(call inherit-product, vendor/samsung/sm6150-common/sm6150-common-vendor.mk)
