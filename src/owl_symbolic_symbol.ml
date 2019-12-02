(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* TODO: The Pi is quite interesting -- 
 * how should we represent these mathematical constant, especially an irrational one? 
 * Perhaps just define a new type and wrap it in tensor? ...
 * Currently I would put it side-by-side with int/float/complex as a stand-alone type
 * But we shall see how it works. 
 * One problem is its type: is it float or double? For now, let the user decide. 
 *)

open Owl_symbolic_types
open Owl_symbolic_ops_math
open Owl_symbolic_ops_reduction
open Owl_symbolic_ops_generator
open Owl_symbolic_ops_tensor
open Owl_symbolic_ops_nn

type t =
  | NOOP
  | Int of Int.t
  | Complex of Complex.t
  | Float of Float.t
  | Tensor of Tensor.t
  | Variable of Variable.t
  | RandomUniform of RandomUniform.t
  | Zero of Zero.t
  | One of One.t
  | NegOne of NegOne.t
  | Pi of Pi.t
  | Sin of Sin.t
  | Cos of Cos.t
  | Sqrt of Sqrt.t
  | Exp of Exp.t
  | Log of Log.t
  | Relu of Relu.t
  | Neg of Neg.t
  | Rational of Rational.t
  | Add of Add.t
  | Sub of Sub.t
  | Mul of Mul.t
  | Div of Div.t
  | Pow of Pow.t
  | MatMul of MatMul.t
  | ReduceSum of ReduceSum.t
  | ReduceMax of ReduceMax.t
  | Reshape of Reshape.t
  | Conv of Conv.t
  | MaxPool of MaxPool.t

(* TODO: GEMM or MatMul? *)

let name = function
  | Int x           -> Int.(x.name)
  | Float x         -> Float.(x.name)
  | Complex x       -> Complex.(x.name)
  | Tensor x        -> Tensor.(x.name)
  | Variable x      -> Variable.(x.name)
  | RandomUniform x -> RandomUniform.(x.name)
  | Zero x          -> Zero.(x.name)
  | One x           -> One.(x.name)
  | NegOne x        -> NegOne.(x.name)
  | Pi x            -> Pi.(x.name)
  | Sin x           -> Sin.(x.name)
  | Cos x           -> Cos.(x.name)
  | Sqrt x          -> Sqrt.(x.name)
  | Exp x           -> Exp.(x.name)
  | Log x           -> Log.(x.name)
  | Relu x          -> Relu.(x.name)
  | Neg x           -> Neg.(x.name)
  | Rational x      -> Rational.(x.name)
  | Add x           -> Add.(x.name)
  | Sub x           -> Sub.(x.name)
  | Mul x           -> Mul.(x.name)
  | Div x           -> Div.(x.name)
  | Pow x           -> Pow.(x.name)
  | MatMul x        -> MatMul.(x.name)
  | ReduceSum x     -> ReduceSum.(x.name)
  | ReduceMax x     -> ReduceMax.(x.name)
  | Reshape x       -> Reshape.(x.name)
  | Conv x          -> Conv.(x.name)
  | MaxPool x       -> MaxPool.(x.name)
  | _               -> failwith "owl_symbolic_symbol.name"


let input = function
  | Int _           -> [||]
  | Float _         -> [||]
  | Complex _       -> [||]
  | Tensor _        -> [||]
  | Variable _      -> [||]
  | RandomUniform _ -> [||]
  | Zero _          -> [||]
  | One _           -> [||]
  | NegOne _        -> [||]
  | Pi _            -> [||]
  | Sin x           -> Sin.(x.input)
  | Cos x           -> Cos.(x.input)
  | Sqrt x          -> Sqrt.(x.input)
  | Exp x           -> Exp.(x.input)
  | Log x           -> Log.(x.input)
  | Neg x           -> Neg.(x.input)
  | Relu x          -> Relu.(x.input)
  | Rational x      -> Rational.(x.input)
  | Add x           -> Add.(x.input)
  | Sub x           -> Sub.(x.input)
  | Mul x           -> Mul.(x.input)
  | Div x           -> Div.(x.input)
  | Pow x           -> Pow.(x.input)
  | MatMul x        -> MatMul.(x.input)
  | Reshape x       -> Reshape.(x.input)
  | ReduceSum x     -> ReduceSum.(x.input)
  | ReduceMax x     -> ReduceMax.(x.input)
  | Conv x          -> Conv.(x.input)
  | MaxPool x       -> MaxPool.(x.input)
  | _               -> failwith "owl_symbolic_symbol.input"


let op_type = function
  | Int _           -> Int.op_type
  | Float _         -> Float.op_type
  | Complex _       -> Complex.op_type
  | Tensor _        -> Tensor.op_type
  | Variable _      -> Variable.op_type
  | RandomUniform _ -> RandomUniform.op_type
  | Zero _          -> Zero.op_type
  | One _           -> One.op_type
  | NegOne _        -> NegOne.op_type
  | Pi _            -> Pi.op_type
  | Sin _           -> Sin.op_type
  | Cos _           -> Cos.op_type
  | Sqrt _          -> Sqrt.op_type
  | Exp _           -> Exp.op_type
  | Log _           -> Log.op_type
  | Rational _      -> Rational.op_type
  | Neg _           -> Neg.op_type
  | Relu _          -> Relu.op_type
  | Add _           -> Add.op_type
  | Sub _           -> Sub.op_type
  | Mul _           -> Mul.op_type
  | Div _           -> Div.op_type
  | Pow _           -> Pow.op_type
  | MatMul _        -> MatMul.op_type
  | Reshape _       -> Reshape.op_type
  | ReduceSum _     -> ReduceSum.op_type
  | ReduceMax _     -> ReduceMax.op_type
  | Conv _          -> Conv.op_type
  | MaxPool _       -> MaxPool.op_type
  | _               -> failwith "owl_symbolic_symbol.op_type"


let sym_attrs = function
  | Int x           -> Int.(x.attrs)
  | Float x         -> Float.(x.attrs)
  | Complex x       -> Complex.(x.attrs)
  | Tensor x        -> Tensor.(x.attrs)
  | Variable x      -> Variable.(x.attrs)
  | RandomUniform x -> RandomUniform.(x.attrs)
  | Zero x          -> Zero.(x.attrs)
  | One x           -> One.(x.attrs)
  | NegOne x        -> NegOne.(x.attrs)
  | Pi x            -> Pi.(x.attrs)
  | Sin x           -> Sin.(x.attrs)
  | Cos x           -> Cos.(x.attrs)
  | Sqrt x          -> Sqrt.(x.attrs)
  | Exp x           -> Exp.(x.attrs)
  | Log x           -> Log.(x.attrs)
  | Rational x      -> Rational.(x.attrs)
  | Neg x           -> Neg.(x.attrs)
  | Relu x          -> Relu.(x.attrs)
  | Add x           -> Add.(x.attrs)
  | Sub x           -> Sub.(x.attrs)
  | Mul x           -> Mul.(x.attrs)
  | Div x           -> Div.(x.attrs)
  | Pow x           -> Pow.(x.attrs)
  | MatMul x        -> MatMul.(x.attrs)
  | Reshape x       -> Reshape.(x.attrs)
  | ReduceSum x     -> ReduceSum.(x.attrs)
  | ReduceMax x     -> ReduceMax.(x.attrs)
  | Conv x          -> Conv.(x.attrs)
  | MaxPool x       -> MaxPool.(x.attrs)
  | _               -> failwith "owl_symbolic_symbol.sym_attrs: unsupported symbol."


let shape = function
  | Tensor x        ->
    let (t : tensor) = Tensor.(x.value) in
    t.shape
  | Variable x      -> Variable.(x.shape)
  | RandomUniform x -> RandomUniform.(x.shape)
  | _               -> [||]


let out_shape = function
  | Int x           -> Int.(x.out_shape)
  | Float x         -> Float.(x.out_shape)
  | Complex x       -> Complex.(x.out_shape)
  | Tensor x        -> Tensor.(x.out_shape)
  | Variable x      -> Variable.(x.out_shape)
  | RandomUniform x -> RandomUniform.(x.out_shape)
  | Zero x          -> Zero.(x.out_shape)
  | One x           -> One.(x.out_shape)
  | NegOne x        -> NegOne.(x.out_shape)
  | Pi x            -> Pi.(x.out_shape)
  | Sin x           -> Sin.(x.out_shape)
  | Cos x           -> Cos.(x.out_shape)
  | Sqrt x          -> Sqrt.(x.out_shape)
  | Exp x           -> Exp.(x.out_shape)
  | Log x           -> Log.(x.out_shape)
  | Neg x           -> Neg.(x.out_shape)
  | Relu x          -> Relu.(x.out_shape)
  | Rational x      -> Rational.(x.out_shape)
  | Add x           -> Add.(x.out_shape)
  | Sub x           -> Sub.(x.out_shape)
  | Mul x           -> Mul.(x.out_shape)
  | Div x           -> Div.(x.out_shape)
  | Pow x           -> Pow.(x.out_shape)
  | MatMul x        -> MatMul.(x.out_shape)
  | Reshape x       -> Reshape.(x.out_shape)
  | ReduceSum x     -> ReduceSum.(x.out_shape)
  | ReduceMax x     -> ReduceMax.(x.out_shape)
  | Conv x          -> Conv.(x.out_shape)
  | MaxPool x       -> MaxPool.(x.out_shape)
  | _               -> failwith "out_shape: unsupported op."


let set_out_shape sym shape =
  match sym with
  | Tensor x        -> x.out_shape <- shape
  | Variable x      -> x.out_shape <- shape
  | RandomUniform x -> x.out_shape <- shape
  | Sin x           -> x.out_shape <- shape
  | Cos x           -> x.out_shape <- shape
  | Sqrt x          -> x.out_shape <- shape
  | Exp x           -> x.out_shape <- shape
  | Log x           -> x.out_shape <- shape
  | Neg x           -> x.out_shape <- shape
  | Relu x          -> x.out_shape <- shape
  | Rational x      -> x.out_shape <- shape
  | Add x           -> x.out_shape <- shape
  | Sub x           -> x.out_shape <- shape
  | Mul x           -> x.out_shape <- shape
  | Div x           -> x.out_shape <- shape
  | Pow x           -> x.out_shape <- shape
  | MatMul x        -> x.out_shape <- shape
  | Reshape x       -> x.out_shape <- shape
  | ReduceSum x     -> x.out_shape <- shape
  | ReduceMax x     -> x.out_shape <- shape
  | Conv x          -> x.out_shape <- shape
  | MaxPool x       -> x.out_shape <- shape
  | _               -> failwith "set_out_shape: unsupported op."


let dtype = function
  | Float _         -> SNT_Float
  | Int _           -> SNT_Int32
  | Complex _       -> SNT_Complex32
  | Pi x            -> Pi.(x.dtype)
  | Tensor x        ->
    let (t : tensor) = Tensor.(x.value) in
    t.dtype
  | Variable x      -> Variable.(x.dtype)
  | RandomUniform x -> RandomUniform.(x.dtype)
  | _               -> failwith "owl_symboic_symobl.dtype: not var or constant op"


(** operaations that only apply to certain symbol *)

let axes = function
  | ReduceSum x -> x.axes
  | _           -> failwith "axes: unsupported op."


let float_value = function
  | Float x -> Float.(x.value)
  | _       -> failwith "owl_symbolic_symbol.float_value"


let int_value = function
  | Int x -> Int.(x.value)
  | _     -> failwith "owl_symbolic_symbol.int_value"


let complex_value = function
  | Complex x -> Complex.(x.real), Complex.(x.img)
  | _         -> failwith "owl_symbolic_symbol.int_value"


let tensor_value = function
  | Tensor x -> Tensor.(x.value)
  | _        -> failwith "owl_symbolic_symbol.tensor_value"


let initializer_ = function
  | Variable x -> Variable.(x.init)
  | _          -> failwith "owl_symbolic_symbol.initializer_"
