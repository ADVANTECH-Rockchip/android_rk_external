LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS += -w

LOCAL_SRC_FILES := events.c resources.c graphics.c
LOCAL_C_INCLUDES +=\
    external/libpng\
    external/zlib\
	external/jpeg

# ========  rotate screen 0, 90, 180, 270  degree ===============
#
ifeq ($(strip $(ROTATE_SCREEN)), 90)
$(info ***screen rotate 90 degree***)
LOCAL_CFLAGS += -DROTATE_SCREEN_90
endif
ifeq ($(strip $(ROTATE_SCREEN)), 180)
$(info ***screen rotate 180 degree***)
LOCAL_CFLAGS += -DROTATE_SCREEN_180
endif
ifeq ($(strip $(ROTATE_SCREEN)), 270)
$(info ***screen rotate 270 degree***)
LOCAL_CFLAGS += -DROTATE_SCREEN_270
endif



ifeq ($(strip $(TARGET_BOARD_PLATFORM)), sofia3gr)
LOCAL_CFLAGS += -DSOFIA3GR_PCBA -DDB_DEBUG

endif

ifeq ($(strip $(TARGET_BOARD_PLATFORM)), rk3288)
LOCAL_CFLAGS += -DRK3288_PCBA_FONT
endif

ifeq ($(RECOVERY_TOUCHSCREEN_SWAP_XY), true)
LOCAL_CFLAGS += -DRECOVERY_TOUCHSCREEN_SWAP_XY
endif

ifeq ($(RECOVERY_TOUCHSCREEN_FLIP_X), true)
LOCAL_CFLAGS += -DRECOVERY_TOUCHSCREEN_FLIP_X
endif

ifeq ($(RECOVERY_TOUCHSCREEN_FLIP_Y), true)
LOCAL_CFLAGS += -DRECOVERY_TOUCHSCREEN_FLIP_Y
endif

ifeq ($(RECOVERY_GRAPHICS_USE_LINELENGTH), true)
LOCAL_CFLAGS += -DRECOVERY_GRAPHICS_USE_LINELENGTH
endif

#Remove the # from the line below to enable event logging
#TWRP_EVENT_LOGGING := true
ifeq ($(TWRP_EVENT_LOGGING), true)
LOCAL_CFLAGS += -D_EVENT_LOGGING
endif

ifeq ($(TARGET_RECOVERY_PIXEL_FORMAT),"RGBX_8888")
  LOCAL_CFLAGS += -DRECOVERY_RGBX
endif
ifeq ($(TARGET_RECOVERY_PIXEL_FORMAT),"BGRA_8888")
  LOCAL_CFLAGS += -DRECOVERY_BGRA
endif
ifeq ($(TARGET_RECOVERY_PIXEL_FORMAT),"BGR_565")
  LOCAL_CFLAGS += -DRECOVERY_BGR_565
else
  LOCAL_CFLAGS += -DRECOVERY_RGB_565
endif

ifeq ($(BOARD_HAS_FLIPPED_SCREEN), true)
LOCAL_CFLAGS += -DBOARD_HAS_FLIPPED_SCREEN
endif

ifneq ($(BOARD_USE_CUSTOM_RECOVERY_FONT),)
  LOCAL_CFLAGS += -DBOARD_USE_CUSTOM_RECOVERY_FONT=$(BOARD_USE_CUSTOM_RECOVERY_FONT)
endif

LOCAL_MODULE := libminuitwrp

include $(BUILD_STATIC_LIBRARY)
