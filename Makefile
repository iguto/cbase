#
# prefs
#
TARGET=main
CFLAGS=-Wall -g -MMD -MP
VPATH=include/
# dir prefs
SRC_DIR=src
OBJDIR:=tmp
INCLUDE_DIR:=include/
# variables
SRCFILES:=$(wildcard $(SRC_DIR)/*.c)
OBJFILES:=$(patsubst %.c,%.o,$(SRCFILES))
DEPENDS=$(OBJFILES:.o=.d)
INCLUDE=-I $(INCLUDE_DIR)

.PHONY: all clean_depends

all: $(TARGET)

$(TARGET): $(OBJFILES)
	$(CC) $(CFLAGS) -o $@ $(OBJFILES)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o:%.c
	$(CC) $(CFLAGS) $(INCLUDE) -c -o $@ $<

clean_depends:
	$(RM) $(DEPENDS)

clean: clean_depends
	$(RM) $(OBJFILES) $(DEPENDS)

-include $(DEPENDS)
