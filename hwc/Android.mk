LOCAL_PATH := $(call my-dir)

# HAL module implementation, not prelinked and stored in
# hw/<HWCOMPOSE_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/../vendor/lib/hw
LOCAL_SHARED_LIBRARIES := liblog libEGL libcutils libutils libhardware libhardware_legacy libz \
                          libion_ti
LOCAL_SRC_FILES := hwc.c rgz_2d.c dock_image.c sw_vsync.c display.c
LOCAL_STATIC_LIBRARIES := libpng

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := hwcomposer.omap4
LOCAL_CFLAGS := -DLOG_TAG=\"ti_hwc\" -Wall -Werror
LOCAL_C_INCLUDES += external/libpng external/zlib

ifeq ($(TARGET_TI_HWC_HDMI_DISABLED),true)
    LOCAL_CFLAGS += -DHDMI_DISABLED
endif

LOCAL_C_INCLUDES += \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
    $(LOCAL_PATH)/../edid/inc \
    $(LOCAL_PATH)/../include

LOCAL_ADDITIONAL_DEPENDENCIES += \
    $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_SHARED_LIBRARIES += libedid

include $(BUILD_SHARED_LIBRARY)
