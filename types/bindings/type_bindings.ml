module M (F : Ctypes.TYPE) = struct
  type 'a typ = 'a Ctypes.structure F.typ

  type ('a, 'b) field = ('b, 'a Ctypes.structure) F.field

  module Statvfs = struct
    type t

    let t : t typ = F.structure "statvfs"

    (** File system block size *)
    let f_bsize = F.(field t "f_bsize" uint)

    (** Fragment size *)
    let f_frsize = F.(field t "f_frsize" uint)

    (** Size of fs in f_frsize units *)
    let f_blocks = F.(field t "f_blocks" uint)

    (** Number of free blocks *)
    let f_bfree = F.(field t "f_bfree" uint)

    (** Number of free blocks for unprivileged user *)
    let f_bavail = F.(field t "f_bavail" uint)

    (** Number of inodes *)
    let f_files = F.(field t "f_files" uint)

    (** Number of free inodes *)
    let f_ffree = F.(field t "f_ffree" uint)

    (** Number of free inodes for unprivileged user *)
    let f_favail = F.(field t "f_favail" uint)

    (** Filesystem ID *)
    let f_fsid = F.(field t "f_fsid" uint)

    (** Mount flags *)
    let f_flag = F.(field t "f_flag" uint)

    (** Maximum filename length *)
    let f_namemax = F.(field t "f_namemax" uint)

    let () = F.seal t
  end
end
