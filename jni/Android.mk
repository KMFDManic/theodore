LOCAL_PATH := $(call my-dir)

CORE_DIR = $(LOCAL_PATH)/..

include $(CORE_DIR)/Makefile.common

COREFLAGS := -std=gnu99 -fsigned-char -DANDROID -D__LIBRETRO__ $(INCFLAGS)

GIT_VERSION := "$(shell git describe --dirty --always --tags || echo unknown)"
ifneq ($(GIT_VERSION)," unknown")
	COREFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
endif

include $(CLEAR_VARS)
LOCAL_MODULE       := retro
LOCAL_SRC_FILES    := $(SOURCES_C)
LOCAL_CFLAGS       := $(COREFLAGS)
LOCAL_LDFLAGS      := -Wl,-version-script=$(CORE_DIR)/link.T
LOCAL_LDLIBS       := -lz
include $(BUILD_SHARED_LIBRARY)

