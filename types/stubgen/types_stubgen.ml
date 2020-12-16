let prefix = "statvfs_stub"

let prologue = "#include <sys/types.h>\n#include <sys/statvfs.h>\n"

let () =
  print_endline prologue;
  Cstubs.Types.write_c Format.std_formatter (module Type_bindings.M)
