#include "file1.h"

#include "file2.h"

#include <stdio.h>

void file1_foo(void) {
  printf("%s()\n", __func__);
  file2_foo();
}
