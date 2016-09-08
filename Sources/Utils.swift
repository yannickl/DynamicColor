/*
 * DynamicColor
 *
 * Copyright 2015-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif

/**
 Clips the values in an interval.

 Given an interval, values outside the interval are clipped to the interval
 edges. For example, if an interval of [0, 1] is specified, values smaller than
 0 become 0, and values larger than 1 become 1.

 - Parameter v: The value to clipped.
 - Parameter minimum: The minimum edge value.
 - Parameter maximum: The maximum edgevalue.
 */
internal func clip<T: Comparable>(_ v: T, _ minimum: T, _ maximum: T) -> T {
  return max(min(v, maximum), minimum)
}

/**
 Returns the absolute value of the modulo operation.

 - Parameter x: The value to compute.
 - Parameter m: The modulo.
 */
internal func moda(_ x: CGFloat, m: CGFloat) -> CGFloat {
  return (x.truncatingRemainder(dividingBy: m) + m).truncatingRemainder(dividingBy: m)
}

/**
 Rounds the given float to a given decimal precision.
 
 - Parameter x: The value to round.
 - Parameter m: The precision. Default to 10000.
 */
internal func roundDecimal(_ x: CGFloat, precision: CGFloat = 10000) -> CGFloat {
  return CGFloat(Int(round(x * precision))) / precision
}
