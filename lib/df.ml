open Ctypes
module Ffi = Df_ffi
module Types = Df_types

module Basic = struct
  type t = {
    f_bsize : int64;
    f_frsize : int64;
    f_blocks : int64;
    f_bfree : int64;
    f_bavail : int64;
    f_files : int64;
    f_ffree : int64;
    f_favail : int64;
    f_fsid : int64;
    f_flag : int64;
    f_namemax : int64;
  }

  let get_bsize ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_bsize

  let get_frsize ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_frsize

  let get_blocks ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_blocks

  let get_bfree ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_bfree

  let get_bavail ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_bavail

  let get_ffiles ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_files

  let get_ffree ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_ffree

  let get_favail ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_favail

  let get_fsid ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_fsid

  let get_flag ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_flag

  let get_namemax ptr = !@ptr |> fun s -> getf s Df_types.Df.Statvfs.f_namemax

  let statvfs ~path =
    let stat = Df_types.Df.Statvfs.t in
    let stat_ptr = allocate_n stat ~count:1 in
    let _ = Df_ffi.Df.statvfs path stat_ptr in
    {
      f_bsize = Unsigned.UInt.to_int64 @@ get_bsize stat_ptr;
      f_frsize = Unsigned.UInt.to_int64 @@ get_frsize stat_ptr;
      f_blocks = Unsigned.UInt.to_int64 @@ get_blocks stat_ptr;
      f_bfree = Unsigned.UInt.to_int64 @@ get_bfree stat_ptr;
      f_bavail = Unsigned.UInt.to_int64 @@ get_bavail stat_ptr;
      f_files = Unsigned.UInt.to_int64 @@ get_ffiles stat_ptr;
      f_ffree = Unsigned.UInt.to_int64 @@ get_ffree stat_ptr;
      f_favail = Unsigned.UInt.to_int64 @@ get_favail stat_ptr;
      f_fsid = Unsigned.UInt.to_int64 @@ get_fsid stat_ptr;
      f_flag = Unsigned.UInt.to_int64 @@ get_flag stat_ptr;
      f_namemax = Unsigned.UInt.to_int64 @@ get_namemax stat_ptr;
    }

  let capacity ?(round = true) ~path =
    let float = Int64.to_float in
    let s = statvfs ~path in
    let total = float s.f_blocks in
    let available = float s.f_bavail in
    let roots = float s.f_bfree in
    let used = total -. roots in
    let non_root = used +. available in
    let f = 100. *. used /. non_root in
    if round then ceil f else f
end
