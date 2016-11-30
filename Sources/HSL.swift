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

/// Hue-saturation-lightness structure to make the color manipulation easier.
internal struct HSL {
  /// Hue value between 0.0 and 1.0 (0.0 = 0 degree, 1.0 = 360 degree).
  var h: CGFloat = 0
  /// Saturation value between 0.0 and 1.0.
  var s: CGFloat = 0
  /// Lightness value between 0.0 and 1.0.
  var l: CGFloat = 0
  /// Alpha value between 0.0 and 1.0.
  var a: CGFloat = 1

  // MARK: - Initializing HSL Colors

  /**
  Initializes and creates a HSL color from the hue, saturation, lightness and alpha components.

  - parameter h: The hue component of the color object, specified as a value between 0.0 and 360.0 degree.
  - parameter s: The saturation component of the color object, specified as a value between 0.0 and 1.0.
  - parameter l: The lightness component of the color object, specified as a value between 0.0 and 1.0.
  - parameter a: The opacity component of the color object, specified as a value between 0.0 and 1.0.
  */
  init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {
    h = hue.truncatingRemainder(dividingBy: 360) / 360
    s = clip(saturation, 0, 1)
    l = clip(lightness, 0, 1)
    a = clip(alpha, 0, 1)
  }

  /**
  Initializes and creates a HSL (hue, saturation, lightness) color from a DynamicColor object.
  
  - parameter color: A DynamicColor object.
  */
  init(color: DynamicColor) {
    let rgba = color.toRGBAComponents()

    let maximum   = max(rgba.r, max(rgba.g, rgba.b))
    let mininimum = min(rgba.r, min(rgba.g, rgba.b))

    let delta = maximum - mininimum

    h = 0
    s = 0
    l = (maximum + mininimum) / 2

    if delta != 0 {
      if l < 0.5 {
        s = delta / (maximum + mininimum)
      }
      else {
        s = delta / (2 - maximum - mininimum)
      }

      if rgba.r == maximum {
        h = (rgba.g - rgba.b) / delta + (rgba.g < rgba.b ? 6 : 0)
      }
      else if rgba.g == maximum {
        h = (rgba.b - rgba.r) / delta + 2
      }
      else if rgba.b == maximum {
        h = (rgba.r - rgba.g) / delta + 4
      }
    }

    h /= 6
    a = rgba.a
  }

  // MARK: - Transforming HSL Color

  /**
  Returns the DynamicColor representation from the current HSV color.
  
  - returns: A DynamicColor object corresponding to the current HSV color.
  */
  func toDynamicColor() -> DynamicColor {
    let m2 = l <= 0.5 ? l * (s + 1) : (l + s) - (l * s)
    let m1 = (l * 2) - m2

    let r = hueToRGB(m1: m1, m2: m2, h: h + 1 / 3)
    let g = hueToRGB(m1: m1, m2: m2, h: h)
    let b = hueToRGB(m1: m1, m2: m2, h: h - 1 / 3)

    return DynamicColor(red: r, green: g, blue: b, alpha: CGFloat(a))
  }

  /// Hue to RGB helper function
  private func hueToRGB(m1: CGFloat, m2: CGFloat, h: CGFloat) -> CGFloat {
    let hue = moda(h, m: 1)

    if hue * 6 < 1 {
      return m1 + (m2 - m1) * hue * 6
    }
    else if hue * 2 < 1 {
      return CGFloat(m2)
    }
    else if hue * 3 < 1.9999 {
      return m1 + (m2 - m1) * (2 / 3 - hue) * 6
    }

    return CGFloat(m1)
  }

  // MARK: - Deriving the Color

  /**
  Returns a color with the hue rotated along the color wheel by the given amount.

  - parameter amount: A float representing the number of degrees as ratio (usually between -360.0 degree and 360.0 degree).
  - returns: A HSL color with the hue changed.
  */
  func adjustedHue(amount: CGFloat) -> HSL {
    return HSL(hue: h * 360 + amount, saturation: s, lightness: l, alpha: a)
  }

  /**
  Returns a color with the lightness increased by the given amount.

  - parameter amount: CGFloat between 0.0 and 1.0.
  - returns: A lighter HSL color.
  */
  func lighter(amount: CGFloat) -> HSL {
    return HSL(hue: h * 360, saturation: s, lightness: l + amount, alpha: a)
  }

  /**
  Returns a color with the lightness decreased by the given amount.

  - parameter amount: CGFloat between 0.0 and 1.0.
  - returns: A darker HSL color.
  */
  func darkened(amount: CGFloat) -> HSL {
    return lighter(amount: amount * -1)
  }

  /**
  Returns a color with the saturation increased by the given amount.

  - parameter amount: CGFloat between 0.0 and 1.0.
  - returns: A HSL color more saturated.
  */
  func saturated(amount: CGFloat) -> HSL {
    return HSL(hue: h * 360, saturation: s + amount, lightness: l, alpha: a)
  }

  /**
  Returns a color with the saturation decreased by the given amount.

  - parameter amount: CGFloat between 0.0 and 1.0.
  - returns: A HSL color less saturated.
  */
  func desaturated(amount: CGFloat) -> HSL {
    return saturated(amount: amount * -1)
  }
}
