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
    
  /**
   A float value representing the luminance of the current color. May vary from 0 to 1.0.
   
   We use the formula described by W3C in WCAG 2.0. You can read more here: https://www.w3.org/TR/WCAG20/#relativeluminancedef
  */
  var luminance: CGFloat {
    get {
      let components = toRGBAComponents()
      let componentsArray =   [components.r, components.g, components.b].map { (val) -> CGFloat in
        if val <= 0.03928 {
          return val/12.92
        } else {
          return pow((val+0.055)/1.055, 2.4)
        }
      }
      return (0.2126 * componentsArray[0]) + (0.7152 * componentsArray[1]) + (0.0722 * componentsArray[2])
    }
  }

    
  /**
     Returns a float value representing the contrast ratio between 2 colors. 
     
     We use the formula described by W3C in WCAG 2.0. You can read more here: https://www.w3.org/TR/WCAG20-TECHS/G18.html
     NB: the contrast ratio is a relative value. So the contrast between Color1 and Color2 is exactly the same between Color2 and Color1.
     
     - returns: A CGFloat representing contrast value
     */
  func contrastRatio(with otherColor:DynamicColor ) -> CGFloat {
    let selfLuminance = self.luminance
    let otherLuminance = otherColor.luminance
    let l1 = max(selfLuminance, otherLuminance)
    let l2 = min(selfLuminance, otherLuminance)
        
    return (l1+0.05)/(l2+0.05)
  }
  
  /**
   Used to describe the context of display of 2 colors.
   Based on WCAG: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast-contrast
  */
  enum ContrastDisplayContext {
    /**
      A standard text in a normal context
     */
    case Standard
    /** 
     A large text in a normal context.
     You can look here for the definition of "large text":
      https://www.w3.org/TR/2008/REC-WCAG20-20081211/#larger-scaledef
     */
    case StandardLargeText
    /**
     A standard text in an enhanced context.
     Enhanced means that you want to be accessible (and AAA compliant in WCAG)
     */
    case Enhanced
    /**
     A large text in an enhanced context.
     Enhanced means that you want to be accessible (and AAA compliant in WCAG)
     You can look here for the definition of "large text":
     https://www.w3.org/TR/2008/REC-WCAG20-20081211/#larger-scaledef
     */
    case EnhancedLargeText
    
    var minimumContrastRatio: CGFloat {
      switch self {
      case .Standard:
        return 4.5
      case .StandardLargeText:
        return 3
      case .Enhanced:
        return 7
      case .EnhancedLargeText:
        return 4.5
      }
    }
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
  func isContrasting(whith otherColor:DynamicColor, inContext context:ContrastDisplayContext = .Standard ) -> Bool {
    return self.contrastRatio(with: otherColor) > context.minimumContrastRatio
  }
}
