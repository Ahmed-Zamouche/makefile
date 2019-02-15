PREFIX = /usr/local
DBG = -g

BUILD_DIR ?= build
DESTDIR ?= $(HOME)/opt

SRC_DIR ?= src
BIN_DIR := $(BUILD_DIR)/bin
OBJ_DIR := $(BUILD_DIR)/obj
DEP_DIR := $(BUILD_DIR)/dep


#SRC := $(wildcard $(SRC_DIR)/*.c)
SRC :=$(shell find $(SRC_DIR) -name "*.c")
HDR :=$(shell find $(SRC_DIR) -name "*.h")
OBJ := $(addprefix $(OBJ_DIR)/, $(SRC:$(SRC_DIR)/%.c=%.o))
DEP := $(addprefix $(DEP_DIR)/, $(SRC:$(SRC_DIR)/%.c=%.d))

TARGET := a.out

INC := -I$(SRC_DIR) \
-I$(DESTDIR)$(PREFIX)/include \


CFLAGS := -Wall -std=c99 -O2 $(DBG) -Werror $(INC)

LDFLAGS := -L$(DESTDIR)$(PREFIX)/lib -lfoo -lm

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CC) -o $(BIN_DIR)/$@ $^ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(DEP_DIR)/%.d
	@mkdir -p  $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $(@:$(OBJ_DIR)/%.o=$(SRC_DIR)/%.c)

-include $(DEP)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
$(DEP_DIR)/%.d: $(SRC_DIR)/%.c
	@mkdir -p  $(dir $@)
	$(CC) $(CFLAGS) $< -MM -MT $(@:$(DEP_DIR)/%.d=$(OBJ_DIR)/%.o) > $@

.PHONY: clang-format
clang-format:
	clang-format -i $(SRC) $(HDR)

.PHONY: cleanobj
cleanobj:
	rm -f $(OBJ)

.PHONY: cleandep
cleandep:
	rm -f $(DEP)

.PHONY: clean
clean: cleanobj cleandep

.PHONY: install
install: $(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp $(BIN_DIR)/$< $(DESTDIR)$(PREFIX)/bin/$(TARGET)

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/$(TARGET)
