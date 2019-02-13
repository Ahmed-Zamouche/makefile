#include "foo_file1.h"

#include "foo_file2.h"

#include <stdio.h>

void foo_file1_bar(void) {
  printf("%s()\n", __func__);
  foo_file2_bar();
}
