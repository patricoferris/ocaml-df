(lang dune 2.7)

(name df)

(generate_opam_files true)

(source
 (github patricoferris/ocaml-df))

(authors "pf341@patricoferris.com")

(maintainers "pf341@patricoferris.com")

(package
 (name df)
 (synopsis "Df like capabilities library")
 (depends ctypes ctypes-foreign))
