(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** And, Or, Xor, Not, Greater, Less, Equal, BitShift  *)

open Owl_symbolic_types

module And = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "And"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Or = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Or"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Xor = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Xor"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Not = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Not"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Greater = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Greater"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Less = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Less"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

module Equal = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Equal"

  let create ?name x_name y_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| x_name; y_name |] in
    { name; input; attrs; out_shape = [| None |] }
end

(* TODO: move to proper op classification *)
module EqualTo = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "EqualTo"

  let create ?name lhs_name rhs_name =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let input = [| lhs_name; rhs_name |] in
    { name; input; attrs; out_shape = [| None |] }
end
