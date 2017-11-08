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

  /**
   Extension to manipulate colours easily.

   It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
   */
  public typealias DynamicColor = UIColor
#elseif os(OSX)
  import AppKit

  /**
   Extension to manipulate colours easily.

   It allows you to work hexadecimal strings and value, HSV and RGB components, derivating colours, and many more...
   */
  public typealias DynamicColor = NSColor
#endif

public extension DynamicColor {
  // MARK: - Manipulating Hexa-decimal Values and Strings

  /**
   Creates a color from an hex string (e.g. "#3498db"). The RGBA string are also supported (e.g. "#3498dbff").

   If the given hex string is invalid the initialiser will create a black color.

   - parameter hexString: A hexa-decimal color string representation.
   */
  public convenience init(hexString: String) {
    let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner   = Scanner(string: hexString)

    if hexString.hasPrefix("#") {
      scanner.scanLocation = 1
    }

    var color: UInt32 = 0

    if scanner.scanHexInt32(&color) {
      self.init(hex: color, useAlpha: hexString.count > 7)
    }
    else {
      self.init(hex: 0x000000)
    }
  }

  /**
   Creates a color from an hex integer (e.g. 0x3498db).

   - parameter hex: A hexa-decimal UInt32 that represents a color.
   - parameter alphaChannel: If true the given hex-decimal UInt32 includes the alpha channel (e.g. 0xFF0000FF).
   */
  public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
    let mask = 0xFF

    let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
    let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
    let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
    let a = alphaChannel ? Int(hex) & mask : 255

    let red   = CGFloat(r) / 255
    let green = CGFloat(g) / 255
    let blue  = CGFloat(b) / 255
    let alpha = CGFloat(a) / 255

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /**
   Returns the color representation as hexadecimal string.

   - returns: A string similar to this pattern "#f4003b".
   */
  public final func toHexString() -> String {
    return String(format: "#%06x", toHex())
  }

  /**
   Returns the color representation as an integer.

   - returns: A UInt32 that represents the hexa-decimal color.
   */
  public final func toHex() -> UInt32 {
    func roundToHex(_ x: CGFloat) -> UInt32 {
      let rounded: CGFloat = round(x * 255)

      return UInt32(rounded)
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
  public func isLight() -> Bool {
    let components = toRGBAComponents()
    let brightness = ((components.r * 299) + (components.g * 587) + (components.b * 114)) / 1000

    return brightness >= 0.5
  }

  /**
   A float value representing the luminance of the current color. May vary from 0 to 1.0.
   
   We use the formula described by W3C in WCAG 2.0. You can read more here: https://www.w3.org/TR/WCAG20/#relativeluminancedef.
  */
  public var luminance: CGFloat {
    let components = toRGBAComponents()

    let componentsArray = [components.r, components.g, components.b].map { (val) -> CGFloat in
      guard val <= 0.03928 else { return pow((val + 0.055) / 1.055, 2.4) }

      return val / 12.92
    }

    return (0.2126 * componentsArray[0]) + (0.7152 * componentsArray[1]) + (0.0722 * componentsArray[2])
  }

  /**
     Returns a float value representing the contrast ratio between 2 colors. 
     
     We use the formula described by W3C in WCAG 2.0. You can read more here: https://www.w3.org/TR/WCAG20-TECHS/G18.html
     NB: the contrast ratio is a relative value. So the contrast between Color1 and Color2 is exactly the same between Color2 and Color1.
     
     - returns: A CGFloat representing contrast value.
     */
  public func contrastRatio(with otherColor: DynamicColor) -> CGFloat {
    let otherLuminance = otherColor.luminance

    let l1 = max(luminance, otherLuminance)
    let l2 = min(luminance, otherLuminance)

    return (l1 + 0.05) / (l2 + 0.05)
  }

  /**
   Indicates if two colors are contrasting, regarding W3C's WCAG 2.0 recommendations.
   
   You can read it here: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast-contrast
   
   The acceptable contrast ratio depends on the context of display. Most of the time, the default context (.Standard) is enough.
   
   You can look at ContrastDisplayContext for more options.
   
   - parameter otherColor: The other color to compare with.
   - parameter context: An optional context to determine the minimum acceptable contrast ratio. Default value is .Standard.
   
   - returns: true is the contrast ratio between 2 colors exceed the minimum acceptable ratio.
   */
  public func isContrasting(with otherColor: DynamicColor, inContext context: ContrastDisplayContext = .standard) -> Bool {
    return self.contrastRatio(with: otherColor) > context.minimumContrastRatio
  }
}
