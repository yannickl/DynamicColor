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

/**
Extension to manipulate colors easily.
*/
public extension UIColor {
  // MARK: - Manipulating HEX Strings

  /**
  Creates a color from an hex string.

  :param: hexString A hexa-decimal color string representation.
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
  Creates a color from an hex int.

  :param: hex A hexa-decimal integer (`UInt32`) that represents a color.
  */
  public convenience init(hex: UInt32) {
    let mask = 0x000000FF

    let r = Int(hex >> 16) & mask
    let g = Int(hex >> 8) & mask
    let b = Int(hex) & mask

    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0

    self.init(red:red, green:green, blue:blue, alpha:1)
  }

  /**
  Returns the color representation as hexadecimal string.

  :returns: A string similar to this pattern "#f4003b"
  */
  public func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    if getRed(&r, green: &g, blue: &b, alpha: &a) {
      let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

      return String(format:"#%06x", rgb)
    }
    else {
      return "#000000"
    }
  }

  // MARK: - Identifying and Comparing Colors

  /**
  Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal string.

  :param: hexString A hexa-decimal color number representation to be compared to the receiver.

  :returns: true if the receiver and the string are equal, otherwise false.
  */
  public func isEqualToHexString(hexString: String) -> Bool {
    return self.toHexString() == hexString
  }

  // MARK: - Deriving Colors

  /**
  Creates and returns a color object with the hue rotated along the color wheel by the given amount.

  :param: amount A float representing the number of degrees as ratio (usually -1 for -360deg and 1 for 360deg).

  :returns: A UIColor object with the hue changed.
  */
  public func adjustedHueColor(amount: CGFloat) -> UIColor {
    return HSL(color: self).adjustHue(amount).toUIColor()
  }

  /**
  Creates and returns the complement of the color object.

  This is identical to adjustedHueColor(0.5).

  :returns: The complement UIColor.
  
  :see: adjustedHueColor:
  */
  public func complementColor() -> UIColor {
    return adjustedHueColor(0.5)
  }

  /**
  Creates and returns a lighter color object.

  :returns: An UIColor lightened with an amount of 0.2.

  :see: lightenColor:
  */
  public func lighterColor() -> UIColor {
    return lightenColor(0.2)
  }

  /**
  Creates and returns a color object with the lightness increased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A lighter UIColor.
  */
  public func lightenColor(amount: CGFloat) -> UIColor {
    let amount = min(1, max(0, amount))

    return HSL(color: self).lighten(amount).toUIColor()
  }

  /**
  Creates and returns a darker color object.

  :returns: A UIColor darkened with an amount of 0.2.

  :see: darkenColor:
  */
  public func darkerColor() -> UIColor {
    return darkenColor(0.2)
  }

  /**
  Creates and returns a color object with the lightness decreased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A darker UIColor.
  */
  public func darkenColor(amount: CGFloat) -> UIColor {
    let amount = min(1, max(0, amount))

    return HSL(color: self).darken(amount).toUIColor()
  }

  /**
  Creates and returns a color object with the saturation increased by the given amount.

  :returns: A UIColor more saturated with an amount of 0.2.

  :see: saturateColor:
  */
  public func saturatedColor() -> UIColor {
    return saturateColor(0.2)
  }

  /**
  Creates and returns a color object with the saturation increased by the given amount.

  :param: amount Float between 0 and 1.

  :returns: A UIColor more saturated.
  */
  public func saturateColor(amount: CGFloat) -> UIColor {
    let amount = min(1, max(0, amount))

    return HSL(color: self).saturate(amount).toUIColor()
  }

  /**
  Creates and returns a color object with the saturation decreased by the given amount.

  :returns: A UIColor less saturated with an amount of 0.2.

  :see: desaturateColor:
  */
  public func desaturatedColor() -> UIColor {
    return desaturateColor(0.2)
  }

  /**
  Creates and returns a color object with the saturation decreased by the given amount.

  :param: amount Float between 0 and 1. The default amount is equal to 0.2.

  :returns: A UIColor less saturated.
  */
  public func desaturateColor(amount: CGFloat) -> UIColor {
    let amount = min(1, max(0, amount))
    
    return HSL(color: self).desaturate(amount).toUIColor()
  }

  /**
  Creates and returns a color object converted to grayscale.
  
  This is identical to desaturateColor(1).
  
  :returns: A grayscale UIColor.

  :see: desaturateColor:
  */
  public func grayscaledColor() -> UIColor {
    return desaturateColor(1)
  }

  /**
  Creates and return a color object where the red, green, and blue values are inverted, while the opacity is left alone.

  :returns: An inverse (negative) of the original color.
  */
  public func invertColor() -> UIColor {
    var red: CGFloat   = 0
    var green: CGFloat = 0
    var blue: CGFloat  = 0
    var alpha: CGFloat = 0

    if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      return UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)
    }

    return self
  }

  // MARK: - Mixing Colors

  /**
  Mixes the given color object with the receiver.
  
  Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage. The opacity of the colors object is also considered when weighting the components.

  :param: color A color object to mix with the receiver.
  :param: weight The weight specifies the amount of the given color object (between 0 and 1). The default value is 0.5, which means that half the given color and half the receiver color object should be used. 0.25 means that a quarter of the given color object and three quarters of the receiver color object should be used.
  
  :returns: A color object corresponding to the two colors object mixed together.
  */
  public func mixWithColor(color: UIColor, weight: CGFloat = 0.5) -> UIColor {
    let weight = min(1, max(0, weight))

    var red1: CGFloat   = 0
    var green1: CGFloat = 0
    var blue1: CGFloat  = 0
    var alpha1: CGFloat = 0

    var red2: CGFloat   = 0
    var green2: CGFloat = 0
    var blue2: CGFloat  = 0
    var alpha2: CGFloat = 0

    if getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
      && color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2) {
        let w = 2 * weight - 1

        let a = alpha1 - alpha2

        let w2 = (((w * a == -1) ? w : (w + a) / (1 + w * a)) + 1) / 2
        let w1 = 1 - w2

        return UIColor(red: (w1 * red1 + w2 * red2), green: (w1 * green1 + w2 * green2), blue: (w1 * blue1 + w2 * blue2), alpha: (alpha1 * weight + alpha2 * (1 - weight)))
    }
    
    return self
  }

  /**
  Creates and returns a color object corresponding to the mix of the receiver and an amount of white color, which increases lightness.

  :param: amount Float between 0 and 1. The default amount is equal to 0.2.

  :returns: A lighter UIColor.
  */
  public func tintColor(amount: CGFloat = 0.2) -> UIColor {
    return mixWithColor(UIColor.whiteColor(), weight: amount)
  }

  /**
  Creates and returns a color object corresponding to the mix of the receiver and an amount of black color, which reduces lightness.

  :param: amount Float between 0 and 1. The default amount is equal to 0.2.

  :returns: A darker UIColor.
  */
  public func shadeColor(amount: CGFloat = 0.2) -> UIColor {
    return mixWithColor(UIColor.blackColor(), weight: amount)
  }
}
