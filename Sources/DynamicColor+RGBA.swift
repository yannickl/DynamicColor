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

// MARK: RGBA

public extension DynamicColor {
  // MARK: - Getting the RGBA Components

  /**
   Returns the RGBA (red, green, blue, alpha) components.

   - returns: The RGBA components as a tuple (r, g, b, a).
   */
  public final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    #if os(iOS) || os(tvOS) || os(watchOS)
      getRed(&r, green: &g, blue: &b, alpha: &a)

      return (r, g, b, a)
    #elseif os(OSX)
      if isEqual(DynamicColor.blackColor()) {
        return (0, 0, 0, 0)
      }
      else if isEqual(DynamicColor.whiteColor()) {
        return (1, 1, 1, 1)
      }
      else {
        getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
      }
    #endif
  }

  #if os(iOS) || os(tvOS) || os(watchOS)
  /**
   The red component as CGFloat between 0.0 to 1.0.
   */
  public final var redComponent: CGFloat {
    get {
      return toRGBAComponents().r
    }
  }

  /**
   The green component as CGFloat between 0.0 to 1.0.
   */
  public final var greenComponent: CGFloat {
    get {
      return toRGBAComponents().g
    }
  }

  /**
   The blue component as CGFloat between 0.0 to 1.0.
   */
  public final var blueComponent: CGFloat {
    get {
      return toRGBAComponents().b
    }
  }

  /**
   The alpha component as CGFloat between 0.0 to 1.0.
   */
  public final var alphaComponent: CGFloat {
    get {
      return toRGBAComponents().a
    }
  }
  #endif

  // MARK: - Setting the RGBA Components

  /**
   Creates and returns a color object with the alpha increased by the given amount.

   - parameter amount: CGFloat between 0.0 and 1.0.
   - returns: A color object with its alpha channel modified.
   */
  public final func adjustedAlphaColor(amount: CGFloat) -> DynamicColor {
    let components      = toRGBAComponents()
    let normalizedAlpha = clip(components.a + amount, 0, 1)

    return DynamicColor(red: components.r, green: components.g, blue: components.b, alpha: normalizedAlpha)
  }

  // MARK: - Working with HSL Components

  /**
   Initializes and returns a color object using the specified opacity and HSL component values.

   - parameter hue: The hue component of the color object, specified as a value from 0.0 to 1.0 (0.0 for 0 degree and 1.0 for 360 degree).
   - parameter saturation: The saturation component of the color object, specified as a value from 0.0 to 1.0.
   - parameter lightness: The lightness component of the color object, specified as a value from 0.0 to 1.0.
   - parameter alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0.
   */
  public convenience init(hue: Double, saturation: Double, lightness: Double, alpha: Double = 1) {
    let color      = HSL(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha).toDynamicColor()
    let components = color.toRGBAComponents()

    self.init(red: components.r, green: components.g, blue: components.b, alpha: components.a)
  }

  /**
   Returns the HSLA (hue, saturation, lightness, alpha) components.

   Notes that the hue value is between 0.0 and 1.0 (0.0 for 0 degree and 1.0 for 360 degree).

   - returns: The HSLA components as a tuple (h, s, l, a).
   */
  public final func toHSLAComponents() -> (h: CGFloat, s: CGFloat, l: CGFloat, a: CGFloat) {
    let hsl = HSL(color: self)

    return (CGFloat(hsl.h), CGFloat(hsl.s), CGFloat(hsl.l), CGFloat(hsl.a))
  }
}
