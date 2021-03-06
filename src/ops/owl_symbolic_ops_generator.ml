(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_symbolic_types

(* TODO: rename file name to input? *)

(** Constant, RandomUniform,  RandomNormal, EyeLike,  RandomUniformLike,
  * RandomNormalLike, Multinomial, ConstantOfShape, Range *)

module Int = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable value : int
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    }

  let op_type = "Int"

  let create ?name ?(dtype = SNT_Int32) value =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; value; out_shape = [| Some [||] |]; dtype }
end

module Float = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable value : float
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    }

  let op_type = "Float"

  let create ?name ?(dtype = SNT_Float) value =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; value; out_shape = [| Some [||] |]; dtype }
end

module Complex = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable real : float
    ; mutable img : float
    ; mutable out_shape : int array option array
    }

  let op_type = "Complex"

  let create ?name real img =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; real; img; out_shape = [| Some [||] |] }
end

module Tensor = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable value : tensor
    ; mutable out_shape : int array option array
    }

  (* in onnx it should be constatnt *)
  let op_type = "Tensor"

  let create ?name value =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; value; out_shape = [| Some value.shape |] }
end

module ConstantOfShape = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable value : tensor
    }

  let op_type = "ConstantOfShape"

  let create ?name ?value xn =
    let attrs = [||] in
    let input = [| xn |] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    let value =
      match value with
      | Some v ->
        assert (Array.length v.shape = 1);
        v
      | None   -> make_tensor ~dtype:SNT_Float ~flt_val:[| 1. |] [| 1 |]
    in
    { name; input; attrs; out_shape = [| None |]; value }
end

module Variable = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable dtype : number_type
    ; mutable shape : int array
    ; mutable out_shape : int array option array
    ; mutable init : tensor option
    }

  let op_type = "Variable"

  let create ?dtype ?shape ?init name =
    let s =
      match init with
      | Some (t : tensor) ->
        if shape <> None
        then Owl_log.warn "Variable %s: shape overridden by initializers" name;
        t.shape
      | None              ->
        (match shape with
        | Some s -> s
        | None   -> [||])
    in
    let d =
      match init with
      | Some (t : tensor) ->
        if shape <> None
        then Owl_log.warn "Variable %s: type overridden by initializers" name;
        t.dtype
      | None              ->
        (match dtype with
        | Some s -> s
        | None   -> SNT_Float)
    in
    let attrs = [||] in
    { name; attrs; dtype = d; shape = s; out_shape = [| Some s |]; init }
end

module RandomUniform = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable dtype : number_type
    ; mutable shape : int array
    ; mutable out_shape : int array option array
    ; mutable high : float
    ; mutable low : float
    ; mutable seed : float option
    }

  let op_type = "RandomUniform"

  let create ?(low = 0.) ?(high = 1.) ?(seed = None) ?(dtype = SNT_Float) ?name shape =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; dtype; shape; out_shape = [| Some shape |]; high; low; seed }
end

module RandomNormal = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable dtype : number_type
    ; mutable shape : int array
    ; mutable out_shape : int array option array
    ; mutable mean : float
    ; mutable stddev : float
    ; mutable seed : float option
    }

  let op_type = "RandomNormal"

  let create ?(mean = 0.) ?(stddev = 1.) ?(seed = None) ?(dtype = SNT_Float) ?name shape =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; dtype; shape; out_shape = [| Some shape |]; mean; stddev; seed }
end

(** Special Numbers *)

module Zero = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Zero"

  let create name attrs = { name; attrs; out_shape = [| Some [||] |] }
end

module One = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "One"

  let create name attrs = { name; attrs; out_shape = [| Some [||] |] }
end

module NegOne = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "NegOne"

  let create name attrs = { name; attrs; out_shape = [| Some [||] |] }
end

module Pi = struct
  type t =
    { mutable name : string
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    }

  let op_type = "Pi"

  let create ?(dtype = SNT_Float) ?name () =
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; attrs; out_shape = [| Some [||] |]; dtype }
end

module EyeLike = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    ; mutable k : int
    }

  let op_type = "EyeLike"

  let create ?name ?(dtype = SNT_Float) ?(k = 0) xn =
    let attrs = [||] in
    let input = [| xn |] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; input; attrs; out_shape = [| None |]; dtype; k }
end

module RandomUniformLike = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    ; mutable high : float
    ; mutable low : float
    ; mutable seed : float option
    }

  let op_type = "RandomUniformLike"

  let create ?name ?(dtype = SNT_Float) ?(high = 1.) ?(low = 0.) ?seed xn =
    let attrs = [||] in
    let input = [| xn |] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; input; attrs; out_shape = [| None |]; dtype; high; low; seed }
end

module RandomNormalLike = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    ; mutable mean : float
    ; mutable stddev : float
    ; mutable seed : float option
    }

  let op_type = "RandomNormalLike"

  let create ?name ?(dtype = SNT_Float) ?(mean = 0.) ?(stddev = 1.) ?seed xn =
    let attrs = [||] in
    let input = [| xn |] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; input; attrs; out_shape = [| None |]; dtype; mean; stddev; seed }
end

module Multinomial = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    ; mutable dtype : number_type
    ; mutable sample_size : int
    ; mutable seed : float option
    }

  let op_type = "Multinomial"

  let create ?name ?(dtype = SNT_Int32) ?(sample_size = 1) ?seed xn =
    let attrs = [||] in
    let input = [| xn |] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; input; attrs; out_shape = [| None |]; dtype; sample_size; seed }
end

module Range = struct
  type t =
    { mutable name : string
    ; mutable input : string array
    ; mutable attrs : (string * attrvalue) array
    ; mutable out_shape : int array option array
    }

  let op_type = "Range"

  let create ?name start limit delta =
    let input = [| start; limit; delta |] in
    let attrs = [||] in
    let name = Owl_symbolic_utils.node_name ?name op_type in
    { name; input; attrs; out_shape = [| None |] }
end
