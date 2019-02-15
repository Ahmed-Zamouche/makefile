#include "file2.h"

#include "file3/file3.h"

#include <stdio.h>

void file2_foo(void) {
  printf("%s()\n", __func__);
  file3_foo();
}
