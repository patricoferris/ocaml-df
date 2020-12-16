module T = Df_types.Df

module M (F : Ctypes.FOREIGN) = struct
  let foreign = F.foreign

  module C = struct
    include Ctypes

    let ( @-> ) = F.( @-> )

    let returning = F.returning
  end

  let statvfs =
    foreign "statvfs" C.(string @-> ptr T.Statvfs.t @-> returning void)

  let fstatvfs =
    foreign "fstatvfs" C.(int @-> ptr T.Statvfs.t @-> returning void)
end
