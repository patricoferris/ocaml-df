open Df.Basic

let () = Format.printf "Capacity for /: %f%%\n" (capacity ~round:true ~path:"/")
