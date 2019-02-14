BUILD_DIR ?= build
SRC_DIR ?= src

LIB_DIR := $(BUILD_DIR)/lib
OBJ_DIR := $(BUILD_DIR)/obj
DEP_DIR := $(BUILD_DIR)/dep

SRC := $(wildcard $(SRC_DIR)/*.c)
OBJ := $(addprefix $(OBJ_DIR)/, $(SRC:$(SRC_DIR)/%.c=%.o))
DEP := $(addprefix $(DEP_DIR)/, $(SRC:$(SRC_DIR)/%.c=%.d))

TARGET := foo

INC := -I$(SRC_DIR) \
-I$(SRC_DIR)/export_inc \

CFLAGS ?= -Wall -std=c99 -O3 -Werror $(INC)

LDFLAGS ?= -lm

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJ)
	@mkdir -p $(LIB_DIR)
	$(AR) rcs  $(LIB_DIR)/lib$@.a $^
	cp -r $(SRC_DIR)/export_inc $(BUILD_DIR)/include

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
	clang-format -i $(SRC) $(wildcard *.h)

.PHONY: cleanobj
cleanobj:
	rm -f $(OBJ)

.PHONY: cleandep
cleandep:
	rm -f $(DEP)

.PHONY: clean
clean: cleanobj cleandep
