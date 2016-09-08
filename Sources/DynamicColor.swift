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

#if os(iOS) || os(tvOS) || os(watchOS)
  /**
   Extension to manipulate colours easily.

   It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
   */
  public typealias DynamicColor = UIColor
#elseif os(OSX)
  /**
   Extension to manipulate colours easily.

   It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
   */
  public typealias DynamicColor = NSColor
#endif

public extension DynamicColor {
  // MARK: - Manipulating Hexa-decimal Values and Strings

  /**
   Creates a color from an hex string (e.g. "#3498db").

   If the given hex string is invalid the initialiser will create a black color.

   - parameter hexString: A hexa-decimal color string representation.
   */
  public convenience init(hexString: String) {
    let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner   = Scanner(string: hexString)

    if (hexString.hasPrefix("#")) {
      scanner.scanLocation = 1
    }

    var color: UInt32 = 0

    if scanner.scanHexInt32(&color) {
      self.init(hex: color)
    }
    else {
      self.init(hex: 0x000000)
    }
  }

  /**
   Creates a color from an hex integer (e.g. 0x3498db).

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
    func roundToHex(_ x: CGFloat) -> UInt32 {
      return UInt32(round(1000 * x) / 1000 * 255)
    }

    let rgba       = toRGBAComponents()
    let colorToInt = roundToHex(rgba.r) << 16 | roundToHex(rgba.g) << 8 | roundToHex(rgba.b)

    return colorToInt
  }

  // MARK: - Identifying and Comparing Colors

  /**
   Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal string.

   - parameter hexString: A hexa-decimal color number representation to be compared to the receiver.
   - returns: true if the receiver and the string are equals, otherwise false.
   */
  public func isEqual(toHexString hexString: String) -> Bool {
    return self.toHexString() == hexString
  }

  /**
   Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal integer.

   - parameter hex: A UInt32 that represents the hexa-decimal color.
   - returns: true if the receiver and the integer are equals, otherwise false.
   */
  public func isEqual(toHex hex: UInt32) -> Bool {
    return self.toHex() == hex
  }

  // MARK: - Querying Colors

  /**
   Determines if the color object is dark or light.

   It is useful when you need to know whether you should display the text in black or white.

   - returns: A boolean value to know whether the color is light. If true the color is light, dark otherwise.
   */
  func isLight() -> Bool {
    let components = toRGBAComponents()
    let brightness = ((components.r * 299) + (components.g * 587) + (components.b * 114)) / 1000
    
    return brightness >= 0.5
  }
}
