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

// MARK: Deriving Colors

public extension DynamicColor {
  /**
   Creates and returns a color object with the hue rotated along the color wheel by the given amount.

   - parameter amount: A double representing the number of degrees as ratio (usually -1.0 for -360 degree and 1.0 for 360 degree).
   - returns: A DynamicColor object with the hue changed.
   */
  public final func adjustedHueColor(amount: Double) -> DynamicColor {
    return HSL(color: self).adjustHue(amount).toDynamicColor()
  }

  /**
   Creates and returns the complement of the color object.

   This is identical to adjustedHueColor(0.5).

   - returns: The complement DynamicColor.
   - seealso: adjustedHueColor:
   */
  public final func complementColor() -> DynamicColor {
    return adjustedHueColor(0.5)
  }

  /**
   Creates and returns a lighter color object.

   - returns: An DynamicColor lightened with an amount of 0.2.
   - seealso: lightenColor:
   */
  public final func lighterColor() -> DynamicColor {
    return lightenColor(0.2)
  }

  /**
   Creates and returns a color object with the lightness increased by the given amount.

   - parameter amount: Double between 0.0 and 1.0.
   - returns: A lighter DynamicColor.
   */
  public final func lightenColor(amount: Double) -> DynamicColor {
    return HSL(color: self).lighten(amount).toDynamicColor()
  }

  /**
   Creates and returns a darker color object.

   - returns: A DynamicColor darkened with an amount of 0.2.
   - seealso: darkenColor:
   */
  public final func darkerColor() -> DynamicColor {
    return darkenColor(0.2)
  }

  /**
   Creates and returns a color object with the lightness decreased by the given amount.

   - parameter amount: Float between 0.0 and 1.0.
   - returns: A darker DynamicColor.
   */
  public final func darkenColor(amount: Double) -> DynamicColor {
    return HSL(color: self).darken(amount).toDynamicColor()
  }

  /**
   Creates and returns a color object with the saturation increased by the given amount.

   - returns: A DynamicColor more saturated with an amount of 0.2.
   - seealso: saturateColor:
   */
  public final func saturatedColor() -> DynamicColor {
    return saturateColor(0.2)
  }

  /**
   Creates and returns a color object with the saturation increased by the given amount.

   - parameter amount: Double between 0.0 and 1.0.

   - returns: A DynamicColor more saturated.
   */
  public final func saturateColor(amount: Double) -> DynamicColor {
    return HSL(color: self).saturate(amount).toDynamicColor()
  }

  /**
   Creates and returns a color object with the saturation decreased by the given amount.

   - returns: A DynamicColor less saturated with an amount of 0.2.
   - seealso: desaturateColor:
   */
  public final func desaturatedColor() -> DynamicColor {
    return desaturateColor(0.2)
  }

  /**
   Creates and returns a color object with the saturation decreased by the given amount.

   - parameter amount: Double between 0.0 and 1.0.
   - returns: A DynamicColor less saturated.
   */
  public final func desaturateColor(amount: Double) -> DynamicColor {
    return HSL(color: self).desaturate(amount).toDynamicColor()
  }

  /**
   Creates and returns a color object converted to grayscale.

   This is identical to desaturateColor(1).

   - returns: A grayscale DynamicColor.
   - seealso: desaturateColor:
   */
  public final func grayscaledColor() -> DynamicColor {
    return desaturateColor(1)
  }

  /**
   Creates and return a color object where the red, green, and blue values are inverted, while the alpha channel is left alone.

   - returns: An inverse (negative) of the original color.
   */
  public final func invertColor() -> DynamicColor {
    let rgba = toRGBAComponents()

    let invertedRed   = 1 - rgba.r
    let invertedGreen = 1 - rgba.g
    let invertedBlue  = 1 - rgba.b

    return DynamicColor(red: invertedRed, green: invertedGreen, blue: invertedBlue, alpha: rgba.a)
  }
}
