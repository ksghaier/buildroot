################################################################################
#
# libcamera-apps
#
################################################################################

LIBCAMERA_APPS_VERSION = 1.4.4
LIBCAMERA_APPS_SITE = $(call github,raspberrypi,libcamera-apps,v$(LIBCAMERA_APPS_VERSION))
LIBCAMERA_APPS_LICENSE = BSD-2-Clause
LIBCAMERA_APPS_LICENSE_FILES = license.txt
LIBCAMERA_APPS_DEPENDENCIES = \
	host-pkgconf \
	boost \
	jpeg \
	libcamera \
	libexif \
	libpng \
	tiff

LIBCAMERA_APPS_CONF_OPTS = \
	-Denable_opencv=false \
	-Denable_tflite=false

ifeq ($(BR2_PACKAGE_LIBDRM),y)
LIBCAMERA_APPS_DEPENDENCIES += libdrm
LIBCAMERA_APPS_CONF_OPTS += -Denable_drm=true
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_drm=false
endif

ifeq ($(BR2_PACKAGE_FFMPEG)$(BR2_PACKAGE_LIBDRM),yy)
LIBCAMERA_APPS_DEPENDENCIES += ffmpeg libdrm
LIBCAMERA_APPS_CONF_OPTS += -Denable_libav=true
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_libav=false
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBCAMERA_APPS_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_LIBEPOXY),libepoxy) \
	$(if $(BR2_PACKAGE_XLIB_LIBX11),xlib_libX11)
LIBCAMERA_APPS_CONF_OPTS += -Denable_egl=true
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_egl=false
endif

ifeq ($(BR2_PACKAGE_QT5),y)
LIBCAMERA_APPS_DEPENDENCIES += qt5base
LIBCAMERA_APPS_CONF_OPTS += -Denable_qt=true
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_qt=false
endif

$(eval $(meson-package))
