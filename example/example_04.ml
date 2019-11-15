open Owl_symbolic
open Op
open Type

(* open Owl_symbolic_types *)

let _ =
  let flt_val = Some [| 1.; 2.; 3.; 4.; 5.; 6. |] in
  let t = Type.make_tensor ~flt_val SDT_Float [| 2; 3 |] in
  let x = variable ~init:t "X" in
  let y = sin x in
  let g = SymGraph.make_graph [| y |] "sym_graph" in
  let z = ONNX_Engine.of_symbolic g in
  ONNX_Engine.serialise z "test.onnx"
