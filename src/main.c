#include "main.h"

#include "file1.h"

#include "foo/foo_main.h"

int main(int argc, char **argv) {
  file1_foo();
  (void)foo_main(argc, argv);
  return 0;
}
