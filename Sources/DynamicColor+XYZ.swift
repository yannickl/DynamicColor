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

// MARK: CIE XYZ Color Space

public extension DynamicColor {
  /**
   Returns the XYZA (mix of cone response curves, luminance, quasi-equal to blue stimulation, alpha) components.

   Notes that values are between 0.0 and 1.0.

   - returns: The XYZA components as a tuple (X, Y, Z, A).
   */
  public final func toXYZAComponents() -> (X: CGFloat, Y: CGFloat, Z: CGFloat, A: CGFloat) {
    /*
     Converts RGB to sRGB.
     We're going to use the Reverse Transformation Equation.
     http://en.wikipedia.org/wiki/SRGB
     */
    let sRGB = { (c: CGFloat) -> CGFloat in
      c > 0.04045 ? pow((c + 0.055) / (1 + 0.055), 2.40) : c / 12.92
    }

    let rgba  = toRGBAComponents()
    let red   = sRGB(rgba.r)
    let green = sRGB(rgba.g)
    let blue  = sRGB(rgba.b)

    /*
     Converts to XYZ values
     Using a matrix multiplication of the linear values
     http://upload.wikimedia.org/math/4/3/3/433376fc18cccd887758beffb7e7c625.png
     */
    let X = Int((red * 0.4124 + green * 0.3576 + blue * 0.1805) * 100000)
    let Y = Int((red * 0.2126 + green * 0.7152 + blue * 0.0722) * 100000)
    let Z = Int((red * 0.0193 + green * 0.1192 + blue * 0.9505) * 100000)

    return (X: CGFloat(X) / 1000, Y: CGFloat(Y) / 1000, Z: CGFloat(Z) / 1000, A: rgba.a)
  }
}
