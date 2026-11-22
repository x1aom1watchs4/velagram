include $(APPDIR)/Make.defs

ifeq ($(CONFIG_NESAOS_HOME),y)
PROGNAME = nesaos_home
PRIORITY = $(CONFIG_NESAOS_HOME_PRIORITY)
STACKSIZE = $(CONFIG_NESAOS_HOME_STACKSIZE)
MODULE = $(CONFIG_NESAOS_HOME)
MAINSRC = nesaos_home_main.c
endif

include $(APPDIR)/Application.mk
