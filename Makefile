#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# Package content copyright (C) 
# 2011-2012 Jan Huwald <jh@sotun.de>


include $(TOPDIR)/rules.mk

PKG_NAME:=v4l2-capture
PKG_VERSION:=20141003
PKG_RELEASE:=1
PKG_REV:=20f4ea4c50a733357fd37a32e657371fd3da9a8e

PKG_SOURCE:=$(PKG_NAME)-$(PKG_REV).tar.gz
PKG_MD5SUM:=always-use-git
PKG_SOURCE_URL:=git://github.com/enko/Capture.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=git

PKG_BUILD_DEPENDS:=+nacl

include $(INCLUDE_DIR)/package.mk

define Package/v4l2-capture
  SECTION:=base
  CATEGORY:=Network
  SUBMENU:=Freifunk Advanced
  DEFAULT:=n
  TITLE:=v4l2 frame capture
  MAINTAINER:=Tim Schumacher <tim@datenknoten.me>
  URL:=https://github.com/enko/Capture
  DEPENDS:=@V4L2
endef

define Package/v4l2-capture/description
	Captures raw frames from a v4l2 device and output it to 
	stdout or a file.
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) `pkg-config --cflags --libs libv4l2` $(PKG_BUILD_DIR)/capture.c -o $(PKG_BUILD_DIR)/capture
endef

define Package/v4l2-capture/install
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/capture $(1)/usr/bin/
endef

$(eval $(call BuildPackage,v43-capture))
