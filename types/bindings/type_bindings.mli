module M (F : Ctypes.TYPE) : sig
  type 'a typ = 'a Ctypes.structure F.typ

  type ('a, 'b) field = ('b, 'a Ctypes.structure) F.field

  module Statvfs : sig
    type t

    val t : t typ

    val f_bsize : (t, Unsigned.uint) field
    (** File system block size *)

    val f_frsize : (t, Unsigned.uint) field
    (** Fragment size *)

    val f_blocks : (t, Unsigned.uint) field
    (** Size of fs in f_frsize units *)

    val f_bfree : (t, Unsigned.uint) field
    (** Number of free blocks *)

    val f_bavail : (t, Unsigned.uint) field
    (** Number of free blocks for unprivileged user *)

    val f_files : (t, Unsigned.uint) field
    (** Number of inodes *)

    val f_ffree : (t, Unsigned.uint) field
    (** Number of free inodes *)

    val f_favail : (t, Unsigned.uint) field
    (** Number of free inodes for unprivileged user *)

    val f_fsid : (t, Unsigned.uint) field
    (** Filesystem ID *)

    val f_flag : (t, Unsigned.uint) field
    (** Mount flags *)

    val f_namemax : (t, Unsigned.uint) field
    (** Maximum filename length *)
  end
end
