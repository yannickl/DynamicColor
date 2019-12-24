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

import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension Color {
  // MARK: - Manipulating Hexa-decimal Values and Strings

  /**
   Creates a color from an hex string (e.g. "#3498db"). The RGBA string are also supported (e.g. "#3498dbff").

   If the given hex string is invalid the initialiser will create a black color.

   - parameter hexString: A hexa-decimal color string representation.
   */
  init(hexString: String) {
    let hexString                 = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner                   = Scanner(string: hexString)
    scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

    var color: UInt64 = 0

    if scanner.scanHexInt64(&color) {
      self.init(hex: color, useOpacity: hexString.count > 7)
    }
    else {
      self.init(hex: 0x000000)
    }
  }

  /**
   Creates a color from an hex integer (e.g. 0x3498db).

   - parameter hex: A hexa-decimal UInt64 that represents a color.
   - parameter opacityChannel: If true the given hex-decimal UInt64 includes the opacity channel (e.g. 0xFF0000FF).
   */
  init(hex: UInt64, useOpacity opacityChannel: Bool = false) {
    let mask      = UInt64(0xFF)
    let cappedHex = !opacityChannel && hex > 0xffffff ? 0xffffff : hex

    let r = cappedHex >> (opacityChannel ? 24 : 16) & mask
    let g = cappedHex >> (opacityChannel ? 16 : 8) & mask
    let b = cappedHex >> (opacityChannel ? 8 : 0) & mask
    let o = opacityChannel ? cappedHex & mask : 255

    let red     = Double(r) / 255.0
    let green   = Double(g) / 255.0
    let blue    = Double(b) / 255.0
    let opacity = Double(o) / 255.0

    self.init(red: red, green: green, blue: blue, opacity: opacity)
  }
}
