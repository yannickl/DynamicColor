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

// MARK: HSB Color Space

extension DynamicColor {
  // MARK: - Getting the HSB Components

  /**
   Returns the HSB (hue, saturation, brightness) components.

   - returns: The HSB components as a tuple (h, s, b).
   */
  public final func toHSBComponents() -> (h: CGFloat, s: CGFloat, b: CGFloat) {
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0

    #if os(iOS) || os(tvOS) || os(watchOS)
      getHue(&h, saturation: &s, brightness: &b, alpha: nil)

      return (h: h, s: s, b: b)
    #elseif os(OSX)
      if isEqual(DynamicColor.black) {
        return (0, 0, 0)
      }
      else if isEqual(DynamicColor.white) {
        return (0, 0, 1)
      }

      getHue(&h, saturation: &s, brightness: &b, alpha: nil)

      return (h: h, s: s, b: b)
    #endif
  }

  #if os(iOS) || os(tvOS) || os(watchOS)
  /**
   The hue component as CGFloat between 0.0 to 1.0.
   */
  public final var hueComponent: CGFloat {
  return toHSBComponents().h
  }

  /**
   The saturation component as CGFloat between 0.0 to 1.0.
   */
  public final var saturationComponent: CGFloat {
  return toHSBComponents().s
  }

  /**
   The brightness component as CGFloat between 0.0 to 1.0.
   */
  public final var brightnessComponent: CGFloat {
  return toHSBComponents().b
  }
  #endif
}
