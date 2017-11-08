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

// MARK: Mixing Colors

public extension DynamicColor {
  /**
   Mixes the given color object with the receiver.

   Specifically, takes the average of each of the RGB components, optionally weighted by the given percentage. 

   - Parameter color: A color object to mix with the receiver.
   - Parameter weight: The weight specifies the amount of the given color object (between 0 and 1). 
       The default value is 0.5, which means that half the given color and half the receiver color object should be used. 
       0.25 means that a quarter of the given color object and three quarters of the receiver color object should be used.
   - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
   - Returns: A color object corresponding to the two colors object mixed together.
   */
  public final func mixed(withColor color: DynamicColor, weight: CGFloat = 0.5, inColorSpace colorspace: DynamicColorSpace = .rgb) -> DynamicColor {
    let normalizedWeight = clip(weight, 0, 1)

    switch colorspace {
    case .lab:
      return mixedLab(withColor: color, weight: normalizedWeight)
    case .hsl:
      return mixedHSL(withColor: color, weight: normalizedWeight)
    case .hsb:
      return mixedHSB(withColor: color, weight: normalizedWeight)
    case .rgb:
      return mixedRGB(withColor: color, weight: normalizedWeight)
    }
  }

  /**
   Creates and returns a color object corresponding to the mix of the receiver and an amount of white color, which increases lightness.

   - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
   - Returns: A lighter DynamicColor.
   */
  public final func tinted(amount: CGFloat = 0.2) -> DynamicColor {
    return mixed(withColor: .white, weight: amount)
  }

  /**
   Creates and returns a color object corresponding to the mix of the receiver and an amount of black color, which reduces lightness.

   - Parameter amount: Float between 0.0 and 1.0. The default amount is equal to 0.2.
   - Returns: A darker DynamicColor.
   */
  public final func shaded(amount: CGFloat = 0.2) -> DynamicColor {
    return mixed(withColor: DynamicColor(red: 0, green: 0, blue: 0, alpha: 1), weight: amount)
  }

  // MARK: - Convenient Internal Methods

  func mixedLab(withColor color: DynamicColor, weight: CGFloat) -> DynamicColor {
    let c1 = toLabComponents()
    let c2 = color.toLabComponents()

    let L     = c1.L + weight * (c2.L - c1.L)
    let a     = c1.a + weight * (c2.a - c1.a)
    let b     = c1.b + weight * (c2.b - c1.b)
    let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

    return DynamicColor(L: L, a: a, b: b, alpha: alpha)
  }

  func mixedHSL(withColor color: DynamicColor, weight: CGFloat) -> DynamicColor {
    let c1 = toHSLComponents()
    let c2 = color.toHSLComponents()

    let h     = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
    let s     = c1.s + weight * (c2.s - c1.s)
    let l     = c1.l + weight * (c2.l - c1.l)
    let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

    return DynamicColor(hue: h, saturation: s, lightness: l, alpha: alpha)
  }

  func mixedHSB(withColor color: DynamicColor, weight: CGFloat) -> DynamicColor {
    let c1 = toHSBComponents()
    let c2 = color.toHSBComponents()

    let h     = c1.h + weight * mixedHue(source: c1.h, target: c2.h)
    let s     = c1.s + weight * (c2.s - c1.s)
    let b     = c1.b + weight * (c2.b - c1.b)
    let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

    return DynamicColor(hue: h, saturation: s, brightness: b, alpha: alpha)
  }

  func mixedRGB(withColor color: DynamicColor, weight: CGFloat) -> DynamicColor {
    let c1 = toRGBAComponents()
    let c2 = color.toRGBAComponents()

    let red   = c1.r + weight * (c2.r - c1.r)
    let green = c1.g + weight * (c2.g - c1.g)
    let blue  = c1.b + weight * (c2.b - c1.b)
    let alpha = alphaComponent + weight * (color.alphaComponent - alphaComponent)

    return DynamicColor(red: red, green: green, blue: blue, alpha: alpha)
  }

  func mixedHue(source: CGFloat, target: CGFloat) -> CGFloat {
    if target > source && target - source > 180 {
      return target - source + 360
    }
    else if target < source && source - target > 180 {
      return target + 360 - source
    }

    return target - source
  }
}
