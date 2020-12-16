ocaml-df 
--------

WIP: [df]-like abilities in OCaml for different platforms (sorry, windows coming soon...). 

## Notes on Ctypes 

This library is more of a learning one for me in the ways of writing C interfaces using Ctypes. Below is a distillation of my understanding of how it works (and how it works in this library). Read at your peril, I'm probably wrong about a few things...

The library is split into two main sections: *ffi* and *types*. These are then combined into useful functions inside *lib*. 

### Types 

The *types* directory contains code for generating bindings to the `statvfs` types and in particular the [stavfs struct](https://man7.org/linux/man-pages/man3/statvfs.3.html). There are a few phases that make up a binding-process with Ctypes where various bits of ML and C code are generated.

In `types/bindings/type_bindings.ml` we have the Ctypes declaration of the types we are trying to bind, nothing to surprising their. The `dune` file is also not surprising. Although the fact that it is "functorised" over `Ctypes.TYPES` is somewhat interesting as it offers [modularity over the exact foreign function (or types) implementation](https://www.cl.cam.ac.uk/~jdy22/papers/a-modular-foreign-function-interface.pdf). 

In `types/stubgen/types_stubgen` we have a little executable which is going to generate some C which in turn will generate some OCaml. Having a look at the `dune` file makes this clear -- we make the `bindings_stubs_gen.c` file using our executable before then compiling that `C` code to generate a new executable. 

Finally in `types/lib` we use that executable to generating our `Bindings_stubs.ml` module which we can pass to the our `Type_bindings` functor to generate our final bindings for our types. 

### FFI 

The FFI directory is *very similiar* to the types library except here we are generating bindings to the functions we're going to call making use of the types we have already described. 

The main difference is that now we also include the stubs in our library: 

```
(library
 (name df_ffi)
 (public_name df.ffi)
 (foreign_stubs
  (language c)
  (names stubs))
 (libraries df.bindings ctypes.stubs ctypes ctypes.foreign))
```

Where the stubs are generated with: 

```
(rule
 (targets stubs.c)
 (deps
  (:stubgen ../stubgen/ffi_stubgen.exe))
 (action
  (with-stdout-to
   %{targets}
   (run %{stubgen} -c))))
```

Notice that `ffi_stubgen.ml` can produce both OCaml and C code, this idea is shamelessly ripped from [ocaml-yaml](https://github.com/avsm/ocaml-yaml/blob/master/ffi/stubgen/ffi_stubgen.ml).