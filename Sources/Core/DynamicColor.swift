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
  convenience init(hexString: String) {
    let hexString                 = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner                   = Scanner(string: hexString)
    scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

    var color: UInt64 = 0

    if scanner.scanHexInt64(&color) {
      self.init(hex: color, useAlpha: hexString.count > 7)
    }
    else {
      self.init(hex: 0x000000)
    }
  }

  /**
   Creates a color from an hex integer (e.g. 0x3498db).

   - parameter hex: A hexa-decimal UInt64 that represents a color.
   - parameter alphaChannel: If true the given hex-decimal UInt64 includes the alpha channel (e.g. 0xFF0000FF).
   */
  convenience init(hex: UInt64, useAlpha alphaChannel: Bool = false) {
    let mask      = UInt64(0xFF)
    let cappedHex = !alphaChannel && hex > 0xffffff ? 0xffffff : hex

    let r = cappedHex >> (alphaChannel ? 24 : 16) & mask
    let g = cappedHex >> (alphaChannel ? 16 : 8) & mask
    let b = cappedHex >> (alphaChannel ? 8 : 0) & mask
    let a = alphaChannel ? cappedHex & mask : 255

    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0
    let alpha = CGFloat(a) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  /**
   Returns the color representation as hexadecimal string.

   - returns: A string similar to this pattern "#f4003b".
   */
  final func toHexString() -> String {
    return String(format: "#%06x", toHex())
  }

  /**
   Returns the color representation as an integer (without the alpha channel).

   - returns: A UInt32 that represents the hexa-decimal color.
   */
  final func toHex() -> UInt32 {
    let rgba = toRGBAComponents()
    
    return roundToHex(rgba.r) << 16 | roundToHex(rgba.g) << 8 | roundToHex(rgba.b)
  }
  
  /**
   Returns the RGBA color representation.
   
   - returns: A UInt32 that represents the color as an RGBA value.
   */
  func toRGBA() -> UInt32 {
    let rgba = toRGBAComponents()
    
    return roundToHex(rgba.r) << 24 | roundToHex(rgba.g) << 16 | roundToHex(rgba.b) << 8 | roundToHex(rgba.a)
  }
  
  /**
   Returns the AGBR color representation.
   
   - returns: A UInt32 that represents the color as an AGBR value.
   */
  func toAGBR() -> UInt32 {
    let rgba = toRGBAComponents()
    
    return roundToHex(rgba.a) << 24 | roundToHex(rgba.b) << 16 | roundToHex(rgba.g) << 8 | roundToHex(rgba.r)
  }

  // MARK: - Identifying and Comparing Colors

  /**
   Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal string.

   - parameter hexString: A hexa-decimal color number representation to be compared to the receiver.
   - returns: true if the receiver and the string are equals, otherwise false.
   */
  func isEqual(toHexString hexString: String) -> Bool {
    return self.toHexString() == hexString
  }

  /**
   Returns a boolean value that indicates whether the receiver is equal to the given hexa-decimal integer.

   - parameter hex: A UInt32 that represents the hexa-decimal color.
   - returns: true if the receiver and the integer are equals, otherwise false.
   */
  func isEqual(toHex hex: UInt32) -> Bool {
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
    let brightness = ((components.r * 299.0) + (components.g * 587.0) + (components.b * 114.0)) / 1000.0

    return brightness >= 0.5
  }

  /**
   A float value representing the luminance of the current color. May vary from 0 to 1.0.
   
   We use the formula described by W3C in WCAG 2.0. You can read more here: https://www.w3.org/TR/WCAG20/#relativeluminancedef.
  */
  var luminance: CGFloat {
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
  func contrastRatio(with otherColor: DynamicColor) -> CGFloat {
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
  func isContrasting(with otherColor: DynamicColor, inContext context: ContrastDisplayContext = .standard) -> Bool {
    return self.contrastRatio(with: otherColor) > context.minimumContrastRatio
  }
}
