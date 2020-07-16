/*
 * Copyright 2019 Lucas Satabin
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
package runtime
package trace

/** Tracers must implement this interface. */
abstract class Tracer {

  /** Filters whether the given event type should be traced in the
    * current [[StackFrame]] context.
    * By default, traces all events. Override to implement custom filtering
    * logic.
    */
  def filter(tpe: EventType, args: List[String], frame: StackFrame): Boolean =
    true

  /** Actually perform the tracing of the event.
    * Filtering has already be done before this method is called,
    * so it does not need to check whether the event is worth tracing.
    */
  def traceEvent(tpe: EventType, args: List[String]): Unit

  private[runtime] final def trace(tpe: EventType, args: List[String], frame: StackFrame): Unit = {
    try {
      frame.functionName match {
        case Some(fname) => System.err.println(fname)
        case None        =>
      }
    } catch { case _: Throwable =>}
  }

}
