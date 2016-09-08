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

// MARK: Deriving Colors

public extension DynamicColor {
  /**
   Creates and returns a color object with the hue rotated along the color wheel by the given amount.

   - parameter amount: A float representing the number of degrees as ratio (usually between -360.0 degree and 360.0 degree).
   - returns: A DynamicColor object with the hue changed.
   */
  public final func adjustedHue(amount: CGFloat) -> DynamicColor {
    return HSL(color: self).adjustedHue(amount: amount).toDynamicColor()
  }

  /**
   Creates and returns the complement of the color object.

   This is identical to adjustedHue(180).

   - returns: The complement DynamicColor.
   - seealso: adjustedHueColor:
   */
  public final func complemented() -> DynamicColor {
    return adjustedHue(amount: 180)
  }

  /**
   Creates and returns a color object with the lightness increased by the given amount.

   - parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
   - returns: A lighter DynamicColor.
   */
  public final func lighter(amount: CGFloat = 0.2) -> DynamicColor {
    return HSL(color: self).lighter(amount: amount).toDynamicColor()
  }

  /**
   Creates and returns a color object with the lightness decreased by the given amount.

   - parameter amount: Float between 0.0 and 1.0. Default value is 0.2.
   - returns: A darker DynamicColor.
   */
  public final func darkened(amount: CGFloat = 0.2) -> DynamicColor {
    return HSL(color: self).darkened(amount: amount).toDynamicColor()
  }

  /**
   Creates and returns a color object with the saturation increased by the given amount.

   - parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.

   - returns: A DynamicColor more saturated.
   */
  public final func saturated(amount: CGFloat = 0.2) -> DynamicColor {
    return HSL(color: self).saturated(amount: amount).toDynamicColor()
  }

  /**
   Creates and returns a color object with the saturation decreased by the given amount.

   - parameter amount: CGFloat between 0.0 and 1.0. Default value is 0.2.
   - returns: A DynamicColor less saturated.
   */
  public final func desaturated(amount: CGFloat = 0.2) -> DynamicColor {
    return HSL(color: self).desaturated(amount: amount).toDynamicColor()
  }

  /**
   Creates and returns a color object converted to grayscale.

   This is identical to desaturateColor(1).

   - returns: A grayscale DynamicColor.
   - seealso: desaturateColor:
   */
  public final func grayscaled() -> DynamicColor {
    return desaturated(amount: 1)
  }

  /**
   Creates and return a color object where the red, green, and blue values are inverted, while the alpha channel is left alone.

   - returns: An inverse (negative) of the original color.
   */
  public final func inverted() -> DynamicColor {
    let rgba = toRGBAComponents()

    let invertedRed   = 1 - rgba.r
    let invertedGreen = 1 - rgba.g
    let invertedBlue  = 1 - rgba.b

    return DynamicColor(red: invertedRed, green: invertedGreen, blue: invertedBlue, alpha: rgba.a)
  }
}
