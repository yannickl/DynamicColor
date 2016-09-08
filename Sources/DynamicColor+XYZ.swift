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
   Initializes and returns a color object using CIE XYZ color space component values with an observer at 2° and a D65 illuminant.
   
   Notes that values out of range are clipped.

   - parameter X: The mix of cone response curves, specified as a value from 0 to 95.05.
   - parameter Y: The luminance, specified as a value from 0 to 100.0.
   - parameter Z: The quasi-equal to blue stimulation, specified as a value from 0 to 108.9.
   - parameter alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Default to 1.0.
   */
  public convenience init(X: CGFloat, Y: CGFloat, Z: CGFloat, alpha: CGFloat = 1) {
    let clippedX = clip(X, 0, 95.05) / 100
    let clippedY = clip(Y, 0, 100) / 100
    let clippedZ = clip(Z, 0, 108.9) / 100

    let toRGB = { (c: CGFloat) -> CGFloat in
      let rgb = c > 0.0031308 ? 1.055 * pow(c, 1 / 2.4) - 0.055 : c * 12.92

      return abs(roundDecimal(rgb, precision: 1000))
    }

    let red   = toRGB(clippedX * 3.2406 + clippedY * -1.5372 + clippedZ * -0.4986)
    let green = toRGB(clippedX * -0.9689 + clippedY * 1.8758 + clippedZ * 0.0415)
    let blue  = toRGB(clippedX * 0.0557 + clippedY * -0.2040 + clippedZ * 1.0570)

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  // MARK: - Getting the XYZ Components

  /**
   Returns the XYZ (mix of cone response curves, luminance, quasi-equal to blue stimulation) components with an observer at 2° and a D65 illuminant.

   Notes that X values are between 0 to 95.05, Y values are between 0 to 100.0 and Z values are between 0 to 108.9.

   - returns: The XYZ components as a tuple (X, Y, Z).
   */
  public final func toXYZComponents() -> (X: CGFloat, Y: CGFloat, Z: CGFloat) {
    let toSRGB = { (c: CGFloat) -> CGFloat in
      c > 0.04045 ? pow((c + 0.055) / 1.055, 2.4) : c / 12.92
    }

    let rgba  = toRGBAComponents()
    let red   = toSRGB(rgba.r)
    let green = toSRGB(rgba.g)
    let blue  = toSRGB(rgba.b)

    let X = roundDecimal((red * 0.4124 + green * 0.3576 + blue * 0.1805) * 100, precision: 1000)
    let Y = roundDecimal((red * 0.2126 + green * 0.7152 + blue * 0.0722) * 100, precision: 1000)
    let Z = roundDecimal((red * 0.0193 + green * 0.1192 + blue * 0.9505) * 100, precision: 1000)

    return (X: X, Y: Y, Z: Z)
  }
}
