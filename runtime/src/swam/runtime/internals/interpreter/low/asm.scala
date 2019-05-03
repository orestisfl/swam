/*
 * Copyright 2018 Lucas Satabin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package swam.runtime.internals.interpreter.low

/** `Asm` is the interpreted language. It closely mirrors the WebAssembly bytecode with
  *  few differences:
  *   - it has typed breaks;
  *   - it has no blocks, loops, or if structures, they are all compiled to breaks;
  *   - it has a parameterized drop operation to drop several elements from the stack at once;
  *   - it has arbitrary (un)conditional jump instructions.
  *
  * This results in a language where labels are pre-compiled, avoiding indirections,
  * and avoiding managing them on the stack.
  * The assembly language is also less safe as it has arbitrary jumps inside a method body.
  * The bytecode compiler is responsible for
  * generating correctly typed assembly code from the bytecode.
  *
  * Breaks are parameterized by the jump addresses, the number of return values and the number
  * of elements to discard from the stack before pushing return values back.
  */
object Asm {

  final val Unreachable = 0x00
  final val Nop = 0x01
  // reserved 0x02-0x03
  final val JumpIf = 0x04
  // reserved 0x05-0x0a
  final val Jump = 0x0b
  final val Br = 0x0c
  final val BrIf = 0x0d
  final val BrTable = 0x0e
  final val Return = 0x0f
  final val Call = 0x10
  final val CallIndirect = 0x11
  // reserved 0x12-0x19
  final val Drop = 0x1a
  final val Select = 0x1b
  // reserved 0x1c-0x1f
  final val LocalGet = 0x20
  final val LocalSet = 0x21
  final val LocalTee = 0x22
  final val GlobalGet = 0x23
  final val GlobalSet = 0x24
  // reserved 0x25-0x27
  final val I32Load = 0x28
  final val I64Load = 0x29
  final val F32Load = 0x2a
  final val F64Load = 0x2b
  final val I32Load8S = 0x2c
  final val I32Load8U = 0x2d
  final val I32Load16S = 0x2e
  final val I32Load16U = 0x2f
  final val I64Load8S = 0x30
  final val I64Load8U = 0x31
  final val I64Load16S = 0x32
  final val I64Load16U = 0x33
  final val I64Load32S = 0x34
  final val I64Load32U = 0x35
  final val I32Store = 0x36
  final val I64Store = 0x37
  final val F32Store = 0x38
  final val F64Store = 0x39
  final val I32Store8 = 0x3a
  final val I32Store16 = 0x3b
  final val I64Store8 = 0x3c
  final val I64Store16 = 0x3d
  final val I64Store32 = 0x3e
  final val MemorySize = 0x3f
  final val MemoryGrow = 0x40
  final val I32Const = 0x41
  final val I64Const = 0x42
  final val F32Const = 0x43
  final val F64Const = 0x44
  final val I32Eqz = 0x45
  final val I32Eq = 0x46
  final val I32Ne = 0x47
  final val I32LtS = 0x48
  final val I32LtU = 0x49
  final val I32GtS = 0x4a
  final val I32GtU = 0x4b
  final val I32LeS = 0x4c
  final val I32LeU = 0x4d
  final val I32GeS = 0x4e
  final val I32GeU = 0x4f
  final val I64Eqz = 0x50
  final val I64Eq = 0x51
  final val I64Ne = 0x52
  final val I64LtS = 0x53
  final val I64LtU = 0x54
  final val I64GtS = 0x55
  final val I64GtU = 0x56
  final val I64LeS = 0x57
  final val I64LeU = 0x58
  final val I64GeS = 0x59
  final val I64GeU = 0x5a
  final val F32Eq = 0x5b
  final val F32Ne = 0x5c
  final val F32Lt = 0x5d
  final val F32Gt = 0x5e
  final val F32Le = 0x5f
  final val F32Ge = 0x60
  final val F64Eq = 0x61
  final val F64Ne = 0x62
  final val F64Lt = 0x63
  final val F64Gt = 0x64
  final val F64Le = 0x65
  final val F64Ge = 0x66
  final val I32Clz = 0x67
  final val I32Ctz = 0x68
  final val I32Popcnt = 0x69
  final val I32Add = 0x6a
  final val I32Sub = 0x6b
  final val I32Mul = 0x6c
  final val I32DivS = 0x6d
  final val I32DivU = 0x6e
  final val I32RemS = 0x6f
  final val I32RemU = 0x70
  final val I32And = 0x71
  final val I32Or = 0x72
  final val I32Xor = 0x73
  final val I32Shl = 0x74
  final val I32ShrS = 0x75
  final val I32ShrU = 0x76
  final val I32Rotl = 0x77
  final val I32Rotr = 0x78
  final val I64Clz = 0x79
  final val I64Ctz = 0x7a
  final val I64Popcnt = 0x7b
  final val I64Add = 0x7c
  final val I64Sub = 0x7d
  final val I64Mul = 0x7e
  final val I64DivS = 0x7f
  final val I64DivU = 0x80
  final val I64RemS = 0x81
  final val I64RemU = 0x82
  final val I64And = 0x83
  final val I64Or = 0x84
  final val I64Xor = 0x85
  final val I64Shl = 0x86
  final val I64ShrS = 0x87
  final val I64ShrU = 0x88
  final val I64Rotl = 0x89
  final val I64Rotr = 0x8a
  final val F32Abs = 0x8b
  final val F32Neg = 0x8c
  final val F32Ceil = 0x8d
  final val F32Floor = 0x8e
  final val F32Trunc = 0x8f
  final val F32Nearest = 0x90
  final val F32Sqrt = 0x91
  final val F32Add = 0x92
  final val F32Sub = 0x93
  final val F32Mul = 0x94
  final val F32Div = 0x95
  final val F32Min = 0x96
  final val F32Max = 0x97
  final val F32Copysign = 0x98
  final val F64Abs = 0x99
  final val F64Neg = 0x9a
  final val F64Ceil = 0x9b
  final val F64Floor = 0x9c
  final val F64Trunc = 0x9d
  final val F64Nearest = 0x9e
  final val F64Sqrt = 0x9f
  final val F64Add = 0xa0
  final val F64Sub = 0xa1
  final val F64Mul = 0xa2
  final val F64Div = 0xa3
  final val F64Min = 0xa4
  final val F64Max = 0xa5
  final val F64Copysign = 0xa6
  final val I32WrapI64 = 0xa7
  final val I32TruncSF32 = 0xa8
  final val I32TruncUF32 = 0xa9
  final val I32TruncSF64 = 0xaa
  final val I32TruncUF64 = 0xab
  final val I64ExtendSI32 = 0xac
  final val I64ExtendUI32 = 0xad
  final val I64TruncSF32 = 0xae
  final val I64TruncUF32 = 0xaf
  final val I64TruncSF64 = 0xb0
  final val I64TruncUF64 = 0xb1
  final val F32ConvertSI32 = 0xb2
  final val F32ConvertUI32 = 0xb3
  final val F32ConvertSI64 = 0xb4
  final val F32ConvertUI64 = 0xb5
  final val F32DemoteF64 = 0xb6
  final val F64ConvertSI32 = 0xb7
  final val F64ConvertUI32 = 0xb8
  final val F64ConvertSI64 = 0xb9
  final val F64ConvertUI64 = 0xba
  final val F64PromoteF32 = 0xbb
  final val I32ReinterpretF32 = 0xbc
  final val I64ReinterpretF64 = 0xbd
  final val F32ReinterpretI32 = 0xbe
  final val F64ReinterpretI64 = 0xbf

}