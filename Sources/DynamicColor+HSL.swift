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

// MARK: HSL Color Space

extension DynamicColor {
  /**
   Initializes and returns a color object using the specified opacity and HSL component values.

   - parameter hue: The hue component of the color object, specified as a value from 0.0 to 360.0 degree.
   - parameter saturation: The saturation component of the color object, specified as a value from 0.0 to 1.0.
   - parameter lightness: The lightness component of the color object, specified as a value from 0.0 to 1.0.
   - parameter alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Default to 1.0.
   */
  public convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {
    let color      = HSL(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha).toDynamicColor()
    let components = color.toRGBAComponents()

    self.init(red: components.r, green: components.g, blue: components.b, alpha: components.a)
  }

  // MARK: - Getting the HSL Components

  /**
   Returns the HSL (hue, saturation, lightness) components.

   Notes that the hue value is between 0.0 and 360.0 degree.

   - returns: The HSL components as a tuple (h, s, l).
   */
  public final func toHSLComponents() -> (h: CGFloat, s: CGFloat, l: CGFloat) {
    let hsl = HSL(color: self)

    return (hsl.h * 360, hsl.s, hsl.l)
  }
}
