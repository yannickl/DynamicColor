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

import UIKit

/// Hue-saturation-lightness structure to make the color manipulation easier.
internal struct HSL {
  var h: CGFloat = 0.0
  var s: CGFloat = 0.0
  var l: CGFloat = 0.0
  var a: CGFloat = 1.0

  // MARK: - Initializing HSL Colors

  /**
  Initializes and creates a HSL color from the hue, saturation, lightness and alpha components.

  :param: h The hue component of the color object, specified as a value between 0.0 and 1.0.
  :param: s The saturation component of the color object, specified as a value between 0.0 and 1.0.
  :param: l The lightness component of the color object, specified as a value between 0.0 and 1.0.
  :param: a The opacity component of the color object, specified as a value between 0.0 and 1.0.
  */
  init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
    h = hue
    s = saturation
    l = lightness
    a = alpha
  }

  /**
  Initializes and creates a HSL color from a UIColor.
  
  :param: color A UIColor object
  */
  init(color: UIColor) {
    var red: CGFloat   = 0
    var blue: CGFloat  = 0
    var green: CGFloat = 0
    var alpha: CGFloat = 0

    if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      let maximum   = max(red, max(green, blue))
      let mininimum = min(red, min(green, blue))

      let delta = maximum - mininimum

      h = 0
      s = 0
      l = (maximum + mininimum) / 2

      if delta != 0 {
        if l < 0.5 {
          s = delta / (maximum + mininimum)
        }
        else {
          s = delta / (2.0 - maximum - mininimum)
        }

        if red == maximum {
          h = (green - blue) / delta + (green < blue ? 6 : 0)
        }
        else if green == maximum {
          h = (blue - red) / delta + 2
        }
        else if blue == maximum {
          h = (red - green) / delta + 4
        }
      }

      h /= 6
    }
  }

  // MARK: - Transforming HSL Color

  /**
  Returns the UIColor representation from the current HSV color.
  
  :returns: A UIColor object corresponding to the current HSV color.
  */
  func toUIColor() -> UIColor {
    let lightness  = min(1, max(0, l))
    let saturation = min(1, max(0, s))
    var hue        = h

    while hue < 0 {
      hue += 1
    }

    while hue > 1 {
      hue -= 1
    }

    var m2: CGFloat = 0

    if lightness <= 0.5 {
      m2 = lightness * (saturation + 1)
    }
    else {
      m2 = (lightness + saturation) - (lightness *  saturation)
    }

    var m1: CGFloat = (lightness * 2) - m2

    let r = hueToRgb(m1, m2: m2, h: hue + 1 / 3)
    let g = hueToRgb(m1, m2: m2, h: hue)
    let b = hueToRgb(m1, m2: m2, h: hue - 1 / 3)

    return UIColor(red: r, green: g, blue: b, alpha: a)
  }

  /// Hue to RGB helper function
  private func hueToRgb(m1: CGFloat, m2: CGFloat, h: CGFloat) -> CGFloat {
    var hue = h

    if hue < 0 {
      hue += 1
    }

    if hue > 1 {
      hue -= 1
    }

    if hue * 6 < 1 {
      return m1 + (m2 - m1) * hue * 6
    }

    if hue * 2 < 1 {
      return m2
    }

    if hue * 3 < 2 {
      return m1 + (m2 - m1) * (2 / 3 - hue) * 6
    }

    return m1
  }

  // MARK: - Deriving the Color

  /**
  Returns a color with the hue rotated along the color wheel by the given amount.

  :param: amount A float representing the number of degrees as ratio (usually -1 for -360deg and 1 for 360deg).

  :returns: A HSL color with the hue changed.
  */
  func adjustHue(amount: CGFloat) -> HSL {
    return HSL(hue: h + amount, saturation: s, lightness: l, alpha: a)
  }

  /**
  Returns a color with the lightness increased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A lighter HSL color.
  */
  func lighten(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: s, lightness: max(amount, l + amount), alpha: a)
  }

  /**
  Returns a color with the lightness decreased by the given amount.

  :param: amount Float between 0 and 1.
  
  :returns: A darker HSL color.
  */
  func darken(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: s, lightness: min(1 - amount, l - amount), alpha: a)
  }

  /**
  Returns a color with the saturation increased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A HSL color more saturated.
  */
  func saturate(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: min(1, max(0, s + amount)), lightness: l, alpha: a)
  }

  /**
  Returns a color with the saturation decreased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A HSL color less saturated.
  */
  func desaturate(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: min(1, max(0, s - amount)), lightness: l, alpha: a)
  }
}
