#include "foo_file2.h"

#include "file3/foo_file3.h"

#include <stdio.h>

void foo_file2_bar(void) {
  printf("%s()\n", __func__);
  foo_file3_bar();
}
