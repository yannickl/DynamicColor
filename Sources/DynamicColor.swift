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
  Extension to manipulate colours easily.

  It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
*/
#if os(iOS) || os(tvOS) || os(watchOS)
  public typealias DynamicColor = UIColor
#elseif os(OSX)
  public typealias DynamicColor = NSColor
#endif

public extension DynamicColor {
  // MARK: - Manipulating Hexa-decimal Values and Strings

  /**
  Creates a color from an hex string.

  - parameter hexString: A hexa-decimal color string representation.
  */
  public convenience init(hexString: String) {
    let hexString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let scanner   = NSScanner(string: hexString)

    if (hexString.hasPrefix("#")) {
      scanner.scanLocation = 1
    }

    var color: UInt32 = 0

    if scanner.scanHexInt(&color) {
      self.init(hex: color)
    }
    else {
      self.init(hex: 0x000000)
    }
  }

  /**
  Creates a color from an hex integer.

  - parameter hex: A hexa-decimal UInt32 that represents a color.
  */
  public convenience init(hex: UInt32) {
    let mask = 0x000000FF

    let r = Int(hex >> 16) & mask
    let g = Int(hex >> 8) & mask
    let b = Int(hex) & mask

    let red   = CGFloat(r) / 255
    let green = CGFloat(g) / 255
    let blue  = CGFloat(b) / 255

    self.init(red:red, green:green, blue:blue, alpha:1)
  }

  /**
  Returns the color representation as hexadecimal string.

  - returns: A string similar to this pattern "#f4003b".
  */
  public final func toHexString() -> String {
    return String(format:"#%06x", toHex())
  }

  /**
  Returns the color representation as an integer.

  - returns: A UInt32 that represents the hexa-decimal color.
  */
  public final func toHex() -> UInt32 {
    let rgba       = toRGBAComponents()
    let colorToInt = (UInt32)(rgba.r * 255) << 16 | (UInt32)(rgba.g * 255) << 8 | (UInt32)(rgba.b * 255)

    return colorToInt
  }

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

  // MARK: - Identifying and Comparing Colors

  /**
  Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal string.

  - parameter hexString: A hexa-decimal color number representation to be compared to the receiver.
  - returns: true if the receiver and the string are equals, otherwise false.
  */
  public func isEqualToHexString(hexString: String) -> Bool {
    return self.toHexString() == hexString
  }

  /**
  Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal integer.

  - parameter hex: A UInt32 that represents the hexa-decimal color.
  - returns: true if the receiver and the integer are equals, otherwise false.
  */
  public func isEqualToHex(hex: UInt32) -> Bool {
    return self.toHex() == hex
  }

  // MARK: - Deriving Colors

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
    let normalizedAmount = clip(amount, 0, 1)

    return HSL(color: self).lighten(normalizedAmount).toDynamicColor()
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
    let normalizedAmount = clip(amount, 0, 1)

    return HSL(color: self).darken(normalizedAmount).toDynamicColor()
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
    let normalizedAmount = clip(amount, 0, 1)

    return HSL(color: self).saturate(normalizedAmount).toDynamicColor()
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
    let normalizedAmount = clip(amount, 0, 1)
    
    return HSL(color: self).desaturate(normalizedAmount).toDynamicColor()
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
  Creates and return a color object where the red, green, and blue values are inverted, while the opacity is left alone.

  - returns: An inverse (negative) of the original color.
  */
  public final func invertColor() -> DynamicColor {
    let rgba = toRGBAComponents()

    return DynamicColor(red: 1 - rgba.r, green: 1 - rgba.g, blue: 1 - rgba.b, alpha: rgba.a)
  }

  // MARK: - Querying Colors 

  /**
  Determines if the color object is dark or light.

  It is useful when you need to know whether you should display the text in black or white.

  - returns: A boolean value to know whether the color is light. If true the color is light, dark otherwise.
  */
  func isLightColor() -> Bool {
    let components = toRGBAComponents()
    let brightness = ((components.r * 299) + (components.g * 587) + (components.b * 114)) / 1000

    return brightness >= 0.5
  }

  // MARK: - Mixing Colors

  /**
  Mixes the given color object with the receiver.
  
  Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage. The opacity of the colors object is also considered when weighting the components.

  - parameter color: A color object to mix with the receiver.
  - parameter weight: The weight specifies the amount of the given color object (between 0 and 1). The default value is 0.5, which means that half the given color and half the receiver color object should be used. 0.25 means that a quarter of the given color object and three quarters of the receiver color object should be used.
  - returns: A color object corresponding to the two colors object mixed together.
  */
  public final func mixWithColor(color: DynamicColor, weight: CGFloat = 0.5) -> DynamicColor {
    let normalizedWeight = clip(weight, 0, 1)

    let c1 = toRGBAComponents()
    let c2 = color.toRGBAComponents()

    let w = 2 * normalizedWeight - 1

    let a  = c1.a - c2.a
    let w2 = (((w * a == -1) ? w : (w + a) / (1 + w * a)) + 1) / 2
    let w1 = 1 - w2

    let red   = w1 * c1.r + w2 * c2.r
    let green = w1 * c1.g + w2 * c2.g
    let blue  = w1 * c1.b + w2 * c2.b
    let alpha = c1.a * normalizedWeight + c2.a * (1 - normalizedWeight)

    return DynamicColor(red: red, green: green, blue: blue, alpha: alpha)
  }

  /**
  Creates and returns a color object corresponding to the mix of the receiver and an amount of white color, which increases lightness.

  - parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
  - returns: A lighter DynamicColor.
  */
  public final func tintColor(amount amount: CGFloat = 0.2) -> DynamicColor {
    return mixWithColor(DynamicColor.whiteColor(), weight: amount)
  }

  /**
  Creates and returns a color object corresponding to the mix of the receiver and an amount of black color, which reduces lightness.

  - parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
  - returns: A darker DynamicColor.
  */
  public final func shadeColor(amount amount: CGFloat = 0.2) -> DynamicColor {
    return mixWithColor(DynamicColor(red:0, green:0, blue: 0, alpha:1), weight: amount)
  }
}
