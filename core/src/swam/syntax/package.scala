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

package swam

/** Instructions in this package are grouped by category as described [[https://webassembly.github.io/spec/core/syntax/instructions.html#numeric-instructions in the specification]].
  *
  * @groupdesc Category Groups instructions by category to be handled uniformly.
  *
  */
package object syntax {

  val EmptyModule = Module(
    Vector.empty[FuncType],
    Vector.empty[Func],
    Vector.empty[TableType],
    Vector.empty[MemType],
    Vector.empty[Global],
    Vector.empty[Elem],
    Vector.empty[Data],
    Option.empty[FuncIdx],
    Vector.empty[Import],
    Vector.empty[Export]
  )

  type Expr = Vector[Inst]

}
