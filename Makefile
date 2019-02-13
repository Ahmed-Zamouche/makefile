TOP ?= .

BUILD_DIR ?= $(TOP)/build


BIN_DIR ?= $(BUILD_DIR)/bin
OBJ_DIR ?= $(BUILD_DIR)/obj
DEP_DIR ?= $(BUILD_DIR)/dep



SRC = $(wildcard *.c)
OBJ = $(addprefix $(OBJ_DIR)/, $(SRC:.c=.o))
DEP = $(addprefix $(DEP_DIR)/, $(SRC:.c=.d)) # one dependency file for each source

TARGET:= a.out

INC := -I$(TOP) \
-I$(TOP)/foo/build/include

CFLAGS := -Wall -std=c99 -O3 -Werror $(INC)

LDFLAGS := -L$(TOP)/foo/build/lib -lfoo -lm

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJ)
	mkdir -p $(BIN_DIR)
	$(CC) -o $(BIN_DIR)/$@ $^ $(LDFLAGS)


$(OBJ_DIR)/%.o: %.c
	mkdir -p  $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $<

-include $(DEP)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
# (see man cpp for details on the -MM and -MT options)
$(DEP_DIR)/%.d: %.c
	mkdir -p  $(dir $@)
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

