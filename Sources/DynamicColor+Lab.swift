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

// MARK: CIE L*a*b* Color Space

public extension DynamicColor {
  // MARK: - Getting the L*a*b* Components

  /**
   Returns the Lab (lightness, red-green axis, yellow-blue axis) components. It is based on the CIE XYZ color space with an observer at 2° and a D65 illuminant.

   Notes that L values are between 0 to 100.0, a values are between -128 to 127.0 and b values are between -128 to 127.0.

   - returns: The XYZ components as a tuple (X, Y, Z).
   */
  public final func toLabComponents() -> (L: CGFloat, a: CGFloat, b: CGFloat) {
    let normalized = { (c: CGFloat) -> CGFloat in
      c > 0.008856 ? pow(c, 1.0 / 3) : 7.787 * c + 16.0 / 116
    }

    let xyz         = toXYZComponents()
    let normalizedX = normalized(xyz.X / 95.05)
    let normalizedY = normalized(xyz.Y / 100)
    let normalizedZ = normalized(xyz.Z / 108.9)

    let L = CGFloat(Int((116 * normalizedY - 16) * 1000)) / 1000
    let a = CGFloat(Int((500 * (normalizedX - normalizedY)) * 1000)) / 1000
    let b = CGFloat(Int((200 * (normalizedY - normalizedZ)) * 1000)) / 1000
print("(\(normalizedX), \(normalizedY), \(normalizedZ)) => (\(L), \(a), \(b)) => \((1/3)*pow((29.0/6.0), 2.0)))")
    return (L: L, a: a, b: b)
  }
}
