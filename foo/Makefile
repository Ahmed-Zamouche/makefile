TOP ?= .

BUILD_DIR ?= $(TOP)/build


LIB_DIR ?= $(BUILD_DIR)/lib
OBJ_DIR ?= $(BUILD_DIR)/obj
DEP_DIR ?= $(BUILD_DIR)/dep

SRC := $(wildcard src/*.c)
OBJ := $(addprefix $(OBJ_DIR)/, $(SRC:.c=.o))
DEP := $(addprefix $(DEP_DIR)/, $(SRC:.c=.d)) # one dependency file for each source

TARGET:= foo

INC := -I$(TOP)/src \
-I$(TOP)/src/export_inc \

CFLAGS ?= -Wall -std=c99 -O3 -Werror $(INC)

LDFLAGS ?= -lm

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJ)
	@mkdir -p $(LIB_DIR)
	$(AR) rcs  $(LIB_DIR)/lib$@.a $^
	cp -r $(TOP)/src/export_inc $(BUILD_DIR)/include

$(OBJ_DIR)/%.o: %.c
	@mkdir -p  $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $<

-include $(DEP)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
# (see man cpp for details on the -MM and -MT options)
$(DEP_DIR)/%.d: %.c
	@mkdir -p  $(dir $@)
	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

.PHONY: clang-format
clang-format:
	clang-format -i $(SRC) $(wildcard *.h)

.PHONY: clean
clean:
	rm -f $(OBJ)

.PHONY: cleandep
cleandep:
	rm -f $(DEP)

