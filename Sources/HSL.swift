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

- parameter v: The value to clipped.
- parameter minimum: The minimum edge value.
- parameter maximum: The maximum edgevalue.
*/
internal func clip<T: Comparable>(v: T, _ minimum: T, _ maximum: T) -> T {
  return max(min(v, maximum), minimum)
}

/**
Returns the absolute value of the modulo operation.

- parameter x: The value value to compute.
- parameter m: The modulo.
*/
internal func moda(x: Double, m: Double) -> Double {
  return (x % m + m) % m
}

/// Hue-saturation-lightness structure to make the color manipulation easier.
internal struct HSL {
  /// Hue value between 0.0 and 1.0 (0.0 = 0 degree, 1.0 = 360 degree).
  var h: Double = 0
  /// Saturation value between 0.0 and 1.0.
  var s: Double = 0
  /// Lightness value between 0.0 and 1.0.
  var l: Double = 0
  /// Alpha value between 0.0 and 1.0.
  var a: Double = 1

  // MARK: - Initializing HSL Colors

  /**
  Initializes and creates a HSL color from the hue, saturation, lightness and alpha components.

  - parameter h: The hue component of the color object, specified as a value between 0.0 and 1.0 (0.0 for 0 degree, 1.0 for 360 degree).
  - parameter s: The saturation component of the color object, specified as a value between 0.0 and 1.0.
  - parameter l: The lightness component of the color object, specified as a value between 0.0 and 1.0.
  - parameter a: The opacity component of the color object, specified as a value between 0.0 and 1.0.
  */
  init(hue: Double, saturation: Double, lightness: Double, alpha: Double = 1) {
    h = hue
    s = clip(saturation, 0, 1)
    l = clip(lightness, 0, 1)
    a = clip(alpha, 0, 1)
  }

  /**
  Initializes and creates a HSL (hue, saturation, lightness) color from a DynamicColor object.
  
  - parameter color: A DynamicColor object.
  */
  init(color: DynamicColor) {
    let rgbaFloat = color.toRGBAComponents()
    let rgba      = (r: Double(rgbaFloat.r), g: Double(rgbaFloat.g), b: Double(rgbaFloat.b), a: Double(rgbaFloat.a))

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
    let lightness  = clip(l, 0, 1)
    let saturation = clip(s, 0, 1)
    let hue        = moda(h, m: 1)
    
    var m2: Double = 0

    if lightness <= 0.5 {
      m2 = lightness * (saturation + 1)
    }
    else {
      m2 = (lightness + saturation) - (lightness * saturation)
    }

    let m1 = (lightness * 2) - m2

    let r = hueToRGB(m1, m2: m2, h: hue + 1 / 3)
    let g = hueToRGB(m1, m2: m2, h: hue)
    let b = hueToRGB(m1, m2: m2, h: hue - 1 / 3)

    return DynamicColor(red: r, green: g, blue: b, alpha: CGFloat(a))
  }

  /// Hue to RGB helper function
  private func hueToRGB(m1: Double, m2: Double, h: Double) -> CGFloat {
    let hue = moda(h, m: 1)

    if hue * 6 < 1 {
      return CGFloat(m1 + (m2 - m1) * hue * 6)
    }
    else if hue * 2 < 1 {
      return CGFloat(m2)
    }
    else if hue * 3 < 1.9999 {
      return CGFloat(m1 + (m2 - m1) * (2 / 3 - hue) * 6)
    }

    return CGFloat(m1)
  }

  // MARK: - Deriving the Color

  /**
  Returns a color with the hue rotated along the color wheel by the given amount.

  - parameter amount: A double representing the number of degrees as ratio (usually -1.0 for -360deg and 1.0 for 360deg).
  - returns: A HSL color with the hue changed.
  */
  func adjustHue(amount: Double) -> HSL {
    return HSL(hue: h + amount, saturation: s, lightness: l, alpha: a)
  }

  /**
  Returns a color with the lightness increased by the given amount.

  - parameter amount: Double between 0.0 and 1.0.
  - returns: A lighter HSL color.
  */
  func lighten(amount: Double) -> HSL {
    return HSL(hue: h, saturation: s, lightness: l + amount, alpha: a)
  }

  /**
  Returns a color with the lightness decreased by the given amount.

  - parameter amount: Double between 0.0 and 1.0.
  - returns: A darker HSL color.
  */
  func darken(amount: Double) -> HSL {
    return HSL(hue: h, saturation: s, lightness: l - amount, alpha: a)
  }

  /**
  Returns a color with the saturation increased by the given amount.

  - parameter amount: Double between 0.0 and 1.0.
  - returns: A HSL color more saturated.
  */
  func saturate(amount: Double) -> HSL {
    return HSL(hue: h, saturation: s + amount, lightness: l, alpha: a)
  }

  /**
  Returns a color with the saturation decreased by the given amount.

  - parameter amount: Double between 0.0 and 1.0.
  - returns: A HSL color less saturated.
  */
  func desaturate(amount: Double) -> HSL {
    return HSL(hue: h, saturation: s - amount, lightness: l, alpha: a)
  }
}
