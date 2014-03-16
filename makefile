
OS=$(shell uname -s)
ARCH=$(shell uname -m)

ifeq ($(ARCH), armv6l)
CC = gcc
else
CC = clang
endif

###
###  Dirs & Files
###

SRCDIR = src
BLDDIR = bld
BTJ_BIN  = serial-test-client
ALLTARGETS = serial-test-client

SRC_FILES  = main.c
SRC_FILES += serial.c

ifndef V
  QUIET_CC   = @echo ' CC   ' $<;
  QUIET_LINK = @echo ' LINK ' $@;
  QUIET_TEST = >/dev/null 2>&1
endif

BTJ_SRC  := $(patsubst %,$(SRCDIR)/%,$(SRC_FILES))
BTJ_SRC  := $(sort $(BTJ_SRC))
BTJ_OBJ  := $(patsubst $(SRCDIR)/%.c,$(BLDDIR)/%.o,$(BTJ_SRC))
BTJ_DEPS := $(patsubst $(SRCDIR)/%.c,$(BLDDIR)/%.d,$(BTJ_SRC))

$(BLDDIR)/%.o: $(SRCDIR)/%.c
	$(MKBLDDIR)
	$(QUIET_CC)$(CC) $(CFLAGS) -c $< -o $@

serial-test-client: $(BTJ_OBJ)
	$(QUIET_LINK)$(CC) $(LDOPTS) -o $(BTJ_BIN) $(BTJ_OBJ) $(LIBS)

# do not move the following line:
-include $(BTC_DEPS)

###
###  Common
###

all: $(ALLTARGETS)

clean:
	rm -f $(ALLTARGETS) *~ gmon*
	rm -rf $(BLDDIR)

