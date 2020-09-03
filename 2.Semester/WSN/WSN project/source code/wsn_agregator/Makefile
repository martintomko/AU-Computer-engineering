CONTIKI = ../..
CONTIKI_PROJECT = border-router
all: $(CONTIKI_PROJECT)

all: networking

# The BR is either native or embedded, and in the latter case must support SLIP
PLATFORMS_EXCLUDE = nrf52dk z1

# Include RPL BR module
include $(CONTIKI)/Makefile.dir-variables
MODULES += $(CONTIKI_NG_SERVICES_DIR)/rpl-border-router
#MODULES_REL += webserver
# Include webserver module
# Include optional target-specific module
include $(CONTIKI)/Makefile.identify-target
MODULES_REL += $(TARGET)


CONTIKI_WITH_RIME = 1
include $(CONTIKI)/Makefile.include

