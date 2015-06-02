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
Extension to manipulate the color easily.
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

  :param: hexString A hexa-decimal color number representation.
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
  
  :params: hexString A hexa-decimal color number representation to be compared to the receiver.
  
  :returns: true if the receiver and the string are equal, otherwise false.
  */
  public func isEqualToHexString(hexString: String) -> Bool {
    return self.toHexString() == hexString
  }

  // MARK: - Deriving Colors

  /**
  Creates and returns a lighter color from the current one.

  :returns: An UIColor lightened with an amount of 0,2.

  :see: lightenColor:
  */
  public func lighterColor() -> UIColor {
    return lightenColor(0.2)
  }

  /**
  Creates and return a color with the lightness increased by the amount value.

  :params: amount Float between 0 and 1.
  
  :returns: A lighter UIColor.
  */
  public func lightenColor(amount: CGFloat) -> UIColor {
    var amount = min(1, max(0, amount))

    return HSL(color: self).lighten(amount).toUIColor()
  }

  /**
  Creates and returns a darker color from the current one.

  :returns: An UIColor darkened with an amount of 0,2.

  :see: darkenColor:
  */
  public func darkerColor() -> UIColor {
    return darkenColor(0.2)
  }

  /**
  Creates and return a color with the lightness decreased by the amount value.

  :returns: A darker UIColor.

  :params: amount Float between 0 and 1.
  */
  public func darkenColor(amount: CGFloat) -> UIColor {
    var amount = min(1, max(0, amount))
    
    return HSL(color: self).darken(amount).toUIColor()
  }
}