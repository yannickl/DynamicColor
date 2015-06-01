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

internal struct HSL {
  var h: CGFloat = 0.0
  var s: CGFloat = 0.0
  var l: CGFloat = 0.0
  var a: CGFloat = 1.0

  init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
    h = hue
    s = saturation
    l = lightness
    a = alpha
  }

  init(color: UIColor) {
    var hue: CGFloat        = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat      = 0

    if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      h = hue
      s = saturation * brightness
      l = (2 - saturation) * brightness

      s /= (l <= 1) ? l : 2 - l
      l /= 2
    }
  }

  func toUIColor() -> UIColor {
    var lightness  = l * 2
    var saturation = (lightness <= 1) ? lightness : 2 - lightness
    var brightness = (lightness + saturation) / 2

    saturation = (2 * saturation) / (lightness + saturation)

    return UIColor(hue: h, saturation: saturation, brightness: brightness, alpha: a)
  }

  func lighten(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: s, lightness: max(amount, l + amount), alpha: a)
  }

  func darken(amount: CGFloat) -> HSL {
    return HSL(hue: h, saturation: s, lightness: min(100 - amount, l - amount), alpha: a)
  }
}
