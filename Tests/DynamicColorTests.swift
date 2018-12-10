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

import XCTest

class DynamicColorTests: XCTestCase {
  func testColorFromHexString() {
    let redStandard = DynamicColor(red: 1, green: 0, blue: 0, alpha: 1)
    let redHex      = DynamicColor(hexString: "#ff0000")

    XCTAssert(redStandard.isEqual(redHex), "Color should be equals")

    let customStandard = DynamicColor(red: 171 / 255, green: 63 / 255, blue: 74 / 255, alpha: 1)
    let customHex      = DynamicColor(hexString: "aB3F4a")

    XCTAssert(customStandard.isEqual(customHex), "Color should be equals")

    let wrongStandard = DynamicColor(red: 0, green: 0, blue: 0, alpha: 1)
    let wrongHex      = DynamicColor(hexString: "#T5RD2Z")

    XCTAssert(wrongStandard.isEqual(wrongHex), "Color should be equals")

    let redAlphaStandard = DynamicColor(red: 1, green: 0, blue: 0, alpha: 0.8)
    let redAlphaHex      = DynamicColor(hexString: "#FF0000CC")

    XCTAssert(redAlphaStandard.isEqual(redAlphaHex), "Color should be equals")

    let overflowedColor = DynamicColor(hexString: "#FFFFFFFF")
    XCTAssert(overflowedColor.isEqual(toHex: 0xFFFFFF), "Color should be equals")
  }

  func testToHexString() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.toHexString() == "#ff0000", "Color string should be equal to #ff0000")
    XCTAssert(blue.toHexString() == "#0000ff", "Color string should be equal to #0000ff")
    XCTAssert(green.toHexString() == "#00ff00", "Color string should be equal to #00ff00")
    XCTAssert(yellow.toHexString() == "#ffff00", "Color string should be equal to #ffff00")
    XCTAssert(black.toHexString() == "#000000", "Color string should be equal to #000000")
    XCTAssert(custom.toHexString() == "#769a2b", "Color string should be equal to #769a2b (not \(custom.toHexString()))")
  }

  func testToHex() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.toHex() == 0xff0000, "Color string should be equal to 0xff0000")
    XCTAssert(blue.toHex() == 0x0000ff, "Color string should be equal to 0x0000ff")
    XCTAssert(green.toHex() == 0x00ff00, "Color string should be equal to 0x00ff00")
    XCTAssert(yellow.toHex() == 0xffff00, "Color string should be equal to 0xffff00")
    XCTAssert(black.toHex() == 0x000000, "Color string should be equal to 0x000000")
    XCTAssert(custom.toHex() == 0x769a2b, "Color string should be equal to 0x769a2b")
  }

  func testToHexWithAlpha() {
    let custom = DynamicColor(hex: 0x769a2b80, useAlpha: true)

    XCTAssert(custom.toHex() == 0x769a2b, "Color string should be equal to 0x769a2b")
    XCTAssertEqual(custom.alphaComponent, 0.5, accuracy: 0.01, "Alpha component should be equal to 0.5 (not \(custom.alphaComponent))")
  }

  func testHexPrecision() {
    let allHexes: CountableRange<UInt32> = 0 ..< 0xFFFFFF
    let impreciseConversions = allHexes.filter { hex in
      DynamicColor(hex: hex).toHex() != hex
    }

    XCTAssert(impreciseConversions.count == 0, "Imprecise hex convertions on \(impreciseConversions.count > 50 ? " more than 50 entries (\(impreciseConversions.count) entries exactly)" : ": \(impreciseConversions)")")
  }

  func testOverflowedColor() {
    let positiveColor = DynamicColor(hex: 0xffffffff)
    let alphaColor = DynamicColor(hex: 0xffffffff)

    XCTAssert(positiveColor.toHex() == 0xffffff, "Color string should be equal to 0xffffff")
    XCTAssert(alphaColor.toHex() == 0xffffff, "Color string should be equal to 0xffffff")
    XCTAssertEqual(alphaColor.alphaComponent, 1, accuracy: 0.01, "Alpha component should be equal to 0.5 (not \(alphaColor.alphaComponent))")
  }

  func testIsEqualToHexString() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(blue.isEqual(toHexString: "#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(green.isEqual(toHexString: "#00ff00"), "Color string should be equal to #00ff00")
    XCTAssert(yellow.isEqual(toHexString: "#ffff00"), "Color string should be equal to #ffff00")
    XCTAssert(black.isEqual(toHexString: "#000000"), "Color string should be equal to #000000")
    XCTAssert(custom.isEqual(toHexString: "#769a2b"), "Color string should be equal to #769a2b")
  }

  func testIsEqualToHex() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.isEqual(toHex: 0xff0000), "Color string should be equal to 0xff0000")
    XCTAssert(blue.isEqual(toHex: 0x0000ff), "Color string should be equal to 0x0000ff")
    XCTAssert(green.isEqual(toHex: 0x00ff00), "Color string should be equal to 0x00ff00")
    XCTAssert(yellow.isEqual(toHex: 0xffff00), "Color string should be equal to 0xffff00")
    XCTAssert(black.isEqual(toHex: 0x000000), "Color string should be equal to 0x000000")
    XCTAssert(custom.isEqual(toHex: 0x769a2b), "Color string should be equal to 0x769a2b")
  }

  func testAdjustHueColor() {
    let custom1 = DynamicColor(hex: 0x881111).adjustedHue(amount: 45)
    let custom2 = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 90)
    let custom3 = DynamicColor(hex: 0xc0392b).adjustedHue(amount: -60)
    let same1   = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 0)
    let same2   = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 360)

    XCTAssert(custom1.isEqual(toHexString: "#886a11"), "Should be equal to #886a11 (not \(custom1.toHexString()))")
    XCTAssert(custom2.isEqual(toHexString: "#68c02b"), "Should be equal to #68c02b (not \(custom2.toHexString()))")
    XCTAssert(custom3.isEqual(toHexString: "#c02bb2"), "Should be equal to #c02bb2 (not \(custom3.toHexString()))")
    XCTAssert(same1.isEqual(toHexString: "#c0392b"), "Should be equal to #c0392b (not \(same1.toHexString()))")
    XCTAssert(same2.isEqual(toHexString: "#c0392b"), "Should be equal to #c0392b (not \(same2.toHexString()))")
  }

  func testComplementColor() {
    let complement  = DynamicColor(hex: 0xc0392b).complemented()
    let adjustedHue = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 180)

    XCTAssert(complement.isEqual(adjustedHue), "Colors should be the same")
  }

  func testLighterColor() {
    let red    = DynamicColor.red.lighter()
    let green  = DynamicColor.green.lighter()
    let blue   = DynamicColor.blue.lighter()
    let violet = DynamicColor(red: 1, green: 0, blue: 1, alpha: 1).lighter()
    let white  = DynamicColor.white.lighter()
    let black  = DynamicColor(red: 0, green: 0, blue: 0, alpha: 1).lighter()
    let gray   = black.lighter()

    XCTAssert(red.isEqual(toHex: 0xff6666), "Should be equal to #ff6666 (not \(red.toHexString()))")
    XCTAssert(green.isEqual(toHex: 0x66ff66), "Should be equal to #66ff66 (not \(green.toHexString()))")
    XCTAssert(blue.isEqual(toHex: 0x6666ff), "Should be equal to #6666ff (not \(blue.toHexString()))")
    XCTAssert(violet.isEqual(toHex: 0xff66ff), "Should be equal to #ff66ff (not \(violet.toHexString()))")
    XCTAssert(white.isEqual(toHex: 0xffffff), "Should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqual(toHex: 0x333333), "Should be equal to #333333 (not \(black.toHexString()))")
    XCTAssert(gray.isEqual(DynamicColor(hex: 0x666666)), "Should be equal to #666666 (not \(gray.toHexString()))")
  }

  func testLightenColor() {
    let whiteFromBlack = DynamicColor.black.lighter(amount: 1)
    let same           = DynamicColor(hex: 0xc0392b).lighter(amount: 0)
    let maxi           = DynamicColor(hex: 0xc0392b).lighter(amount: 1)

    XCTAssert(whiteFromBlack.isEqual(toHexString: "#ffffff"), "Color should be equals (not \(whiteFromBlack.toHexString()))")
    XCTAssert(same.isEqual(toHexString: "#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqual(toHexString: "#ffffff"), "Color string should be equal to #ffffff (not \(maxi.toHexString()))")
  }

  func testDarkerColor() {
    let red   = DynamicColor.red.darkened()
    let white = DynamicColor.white.darkened()
    let gray  = white.darkened()
    let black = DynamicColor.black.darkened()

    XCTAssert(red.isEqual(toHexString: "#990000"), "Color string should be equal to #990000 (not \(red.toHexString()))")
    XCTAssert(white.isEqual(toHexString: "#cccccc"), "Color string should be equal to #cccccc (not \(white.toHexString()))")
    XCTAssert(gray.isEqual(toHexString: "#999999"), "Color string should be equal to #999999 (not \(gray.toHexString()))")
    XCTAssert(black.isEqual(toHexString: "#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
  }

  func testDarkenColor() {
    let blackFromWhite = DynamicColor.white.darkened(amount: 1)
    let same           = DynamicColor(hex: 0xc0392b).darkened(amount: 0)
    let maxi           = DynamicColor(hex: 0xc0392b).darkened(amount: 1)

    XCTAssert(blackFromWhite.isEqual(toHexString: "#000000"), "Colors should be the same (not \(blackFromWhite.toHexString()))")
    XCTAssert(same.isEqual(toHexString: "#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqual(toHexString: "#000000"), "Color string should be equal to #000000 (not \(maxi.toHexString()))")
  }

  func testSaturatedColor() {
    let primary = DynamicColor.red.saturated()
    let white   = DynamicColor.white.saturated()
    let black   = DynamicColor.black.saturated()
    let custom  = DynamicColor(hex: 0xc0392b).saturated()


    XCTAssert(primary.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000 (not \(primary.toHexString()))")
    XCTAssert(white.isEqual(toHexString: "#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqual(toHexString: "#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqual(toHexString: "#d82614"), "Color string should be equal to #d82614 (not \(custom.toHexString()))")
  }

  func testSaturateColor() {
    let same = DynamicColor(hex: 0xc0392b).saturated(amount: 0)
    let maxi = DynamicColor(hex: 0xc0392b).saturated(amount: 1)

    XCTAssert(same.isEqual(toHexString: "#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqual(toHexString: "#eb1600"), "Color string should be equal to #eb1600 (not \(maxi.toHexString()))")
  }

  func testDesaturatedColor() {
    let primary = DynamicColor.red.desaturated()
    let white   = DynamicColor.white.desaturated()
    let black   = DynamicColor.black.desaturated()
    let custom  = DynamicColor(hex: 0xc0392b).desaturated()

    XCTAssert(primary.isEqual(toHexString: "#e61919"), "Color string should be equal to #e61919 (not \(primary.toHexString()))")
    XCTAssert(white.isEqual(toHexString: "#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqual(toHexString: "#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqual(toHexString: "#a94c43"), "Color string should be equal to #a94c43 (not \(custom.toHexString()))")
  }

  func testDesaturateColor() {
    let same = DynamicColor(hex: 0xc0392b).desaturated(amount: 0)
    let maxi = DynamicColor(hex: 0xc0392b).desaturated(amount: 1)

    XCTAssert(same.isEqual(toHexString: "#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqual(toHexString: "#767676"), "Color string should be equal to #767676 (not \(maxi.toHexString()))")
  }

  func testGrayscaleColor() {
    let grayscale   = DynamicColor(hex: 0xc0392b).grayscaled()
    let desaturated = DynamicColor(hex: 0xc0392b).desaturated(amount: 1)

    XCTAssert(grayscale.isEqual(desaturated), "Colors should be the same")
  }

  func testInvertColor() {
    let inverted = DynamicColor(hex: 0xff0000).inverted()
    let original = inverted.inverted()

    XCTAssert(inverted.isEqual(toHexString: "#00ffff"), "Color string should be equal to #00ffff")
    XCTAssert(original.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
  }

  func testIsLightColor() {
    let l1 = DynamicColor.white
    let l2 = DynamicColor.green
    let d1 = DynamicColor.black
    let d2 = DynamicColor.red
    let d3 = DynamicColor.blue

    XCTAssert(l1.isLight(), "White should be light")
    XCTAssert(l2.isLight(), "Green should be light")
    XCTAssertFalse(d1.isLight(), "Black should be dark")
    XCTAssertFalse(d2.isLight(), "Red should be dark")
    XCTAssertFalse(d3.isLight(), "Blue should be dark")
  }

  func testMixRGBColors() {
    let red   = DynamicColor.red
    let blue  = DynamicColor.blue
    let green = DynamicColor.green

    var midMix = red.mixed(withColor: blue)

    XCTAssert(midMix.isEqual(toHexString: "#800080"), "Color string should be equal to #800080 (not \(midMix.toHexString()))")

    midMix = blue.mixed(withColor: red)

    XCTAssert(midMix.isEqual(toHexString: "#800080"), "Color string should be equal to #800080 (not \(midMix.toHexString())")

    let sameMix = green.mixed(withColor: green)

    XCTAssert(sameMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #00ff00")

    let noMix         = red.mixed(withColor: blue, weight: 0)
    let noMixOverflow = red.mixed(withColor: blue, weight: -20)

    XCTAssert(noMix.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixed(withColor: blue, weight: 1)
    let fullMixOverflow = red.mixed(withColor: blue, weight: 24)

    XCTAssert(fullMix.isEqual(toHexString: "#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testMixLabColors() {
    let red   = DynamicColor.red
    let blue  = DynamicColor.blue
    let green = DynamicColor.green

    var midMix = red.mixed(withColor: blue, inColorSpace: .lab)

    XCTAssert(midMix.isEqual(toHexString: "#c93b88"), "Color string should be equal to #c93b88 (not \(midMix.toHexString()))")

    midMix = blue.mixed(withColor: red, inColorSpace: .lab)

    XCTAssert(midMix.isEqual(toHexString: "#c93b88"), "Color string should be equal to #c93b88 (not \(midMix.toHexString()))")

    let sameMix = green.mixed(withColor: green, inColorSpace: .lab)

    XCTAssert(sameMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #00ff00")

    let noMix         = red.mixed(withColor: blue, weight: 0, inColorSpace: .lab)
    let noMixOverflow = red.mixed(withColor: blue, weight: -20, inColorSpace: .lab)

    XCTAssert(noMix.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixed(withColor: blue, weight: 1, inColorSpace: .lab)
    let fullMixOverflow = red.mixed(withColor: blue, weight: 24, inColorSpace: .lab)

    XCTAssert(fullMix.isEqual(toHexString: "#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testMixHSLColors() {
    let red   = DynamicColor.red
    let blue  = DynamicColor.blue
    let green = DynamicColor.green

    var midMix = red.mixed(withColor: blue, inColorSpace: .hsl)
    XCTAssert(midMix.isEqual(toHexString: "#ff00ff"), "Color string should be equal to #ff00ff (not \(midMix.toHexString()))")

    midMix = blue.mixed(withColor: red, inColorSpace: .hsl)
    XCTAssert(midMix.isEqual(toHexString: "#ff00ff"), "Color string should be equal to #ff00ff")

    let sameMix = green.mixed(withColor: green, inColorSpace: .hsl)

    XCTAssert(sameMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #00ff00")

    let noMix         = red.mixed(withColor: blue, weight: 0, inColorSpace: .hsl)
    let noMixOverflow = red.mixed(withColor: blue, weight: -20, inColorSpace: .hsl)

    XCTAssert(noMix.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixed(withColor: blue, weight: 1, inColorSpace: .hsl)
    let fullMixOverflow = red.mixed(withColor: blue, weight: 24, inColorSpace: .hsl)

    XCTAssert(fullMix.isEqual(toHexString: "#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testMixHSBColors() {
    let red   = DynamicColor.red
    let blue  = DynamicColor.blue
    let green = DynamicColor.green

    var midMix = red.mixed(withColor: blue, inColorSpace: .hsb)

    XCTAssert(midMix.isEqual(toHexString: "#ff00ff") || midMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #ff00ff or #00ff00 (not \(midMix.toHexString()))")

    midMix = blue.mixed(withColor: red, inColorSpace: .hsb)

    XCTAssert(midMix.isEqual(toHexString: "#ff00ff") || midMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #ff00ff or #00ff00")

    let sameMix = green.mixed(withColor: green, inColorSpace: .hsb)

    XCTAssert(sameMix.isEqual(toHexString: "#00ff00"), "Color string should be equal to #00ff00")

    let noMix         = red.mixed(withColor: blue, weight: 0, inColorSpace: .hsb)
    let noMixOverflow = red.mixed(withColor: blue, weight: -20, inColorSpace: .hsb)

    XCTAssert(noMix.isEqual(toHexString: "#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixed(withColor: blue, weight: 1, inColorSpace: .hsb)
    let fullMixOverflow = red.mixed(withColor: blue, weight: 24, inColorSpace: .hsb)

    XCTAssert(fullMix.isEqual(toHexString: "#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testTintColor() {
    let tint = DynamicColor(hex: 0xc0392b).tinted()

    XCTAssert(tint.isEqual(toHexString: "#cd6155"), "Color string should be equal to #cd6155 (not \(tint.toHexString())")

    let white = DynamicColor(hex: 0xc0392b).tinted(amount: 1)

    XCTAssert(white.isEqual(toHexString: "#ffffff"), "Color string should be equal to #ffffff")

    let alwaysWhite = DynamicColor.white.tinted()

    XCTAssert(alwaysWhite.isEqual(toHexString: "#ffffff"), "Color string should be equal to #ffffff")
  }

  func testShadeColor() {
    let shade = DynamicColor(hex: 0xc0392b).shaded()

    XCTAssert(shade.isEqual(toHexString: "#9a2e22"), "Color string should be equal to #9a2e22 (not \(shade.toHexString())")

    let black = DynamicColor(hex: 0xc0392b).shaded(amount: 1)

    XCTAssert(black.isEqual(toHexString: "#000000"), "Color string should be equal to #000000")
    
    let alwaysBlack = DynamicColor.black.shaded()
    
    XCTAssert(alwaysBlack.isEqual(toHexString: "#000000"), "Color string should be equal to #000000")
  }

  func testLuminance()  {
    let blackLuminance = DynamicColor.black.luminance
    XCTAssertEqual(blackLuminance, 0, "Luminance for black color should be 0")

    let whiteLuminance = DynamicColor.white.luminance
    XCTAssertEqual(whiteLuminance, 1, "Luminance for white color should be 1")

    XCTAssertEqual(DynamicColor(hexString: "#F18F2E").luminance, 0.38542950354028, accuracy: 0.000001)

    XCTAssertEqual(DynamicColor(hexString: "#FFFF00").luminance, 0.9278, accuracy: 0.000001)

    XCTAssertEqual(DynamicColor(hexString: "#ffb0ef").luminance, 0.58542663140357, accuracy: 0.000001)
  }

  func testContrastRatio()  {

    XCTAssertEqual(DynamicColor.black.contrastRatio(with: .white), 21, "Contrast between black and white should be 21")
    XCTAssertEqual(DynamicColor.white.contrastRatio(with: .black), 21, "Contrast between white and black should be 21")

    let color1 = DynamicColor(hexString: "F18F2E")
    let color2 = DynamicColor(hexString: "FFFF00")
    let color3 = DynamicColor(hexString: "ffb0ef")


    XCTAssertEqual(color1.contrastRatio(with: color2), 2.2455988, accuracy: TestsAcceptedAccuracy)
    XCTAssertEqual(color2.contrastRatio(with: color1), 2.2455988, accuracy: TestsAcceptedAccuracy)

    XCTAssertEqual(color3.contrastRatio(with: color2), 1.5388086, accuracy: TestsAcceptedAccuracy)
    XCTAssertEqual(color2.contrastRatio(with: color3), 1.5388086, accuracy: TestsAcceptedAccuracy)

    XCTAssertEqual(color3.contrastRatio(with: color1), 1.4593100, accuracy: TestsAcceptedAccuracy)
    XCTAssertEqual(color1.contrastRatio(with: color3), 1.4593100, accuracy: TestsAcceptedAccuracy)

  }
  
  func testIsContrasting()  {
    XCTAssertFalse(DynamicColor.black.isContrasting(with: .black), "A color cannot contrast with itself")

    XCTAssertTrue(DynamicColor.black.isContrasting(with: .white), "Black and white are always contrasting")
    
    XCTAssertTrue(DynamicColor.black.isContrasting(with: .white, inContext: .standard), "Black and white are always contrasting")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: .white, inContext: .standardLargeText), "Black and white are always contrasting")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: .white, inContext: .enhanced), "Black and white are always contrasting")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: .white, inContext: .enhancedLargeText), "Black and white are always contrasting")

    // Contrast ratio between white and red = 4. So, we should only return true in StandardLargeText
    XCTAssertFalse(DynamicColor.white.isContrasting(with: .red), "White and red are only contrasting in StandardLargeText")
    XCTAssertFalse(DynamicColor.white.isContrasting(with: .red, inContext: .standard), "White and red are only contrasting in StandardLargeText")
    XCTAssertTrue(DynamicColor.white.isContrasting(with: .red, inContext: .standardLargeText), "White and red are only contrasting in StandardLargeText")
    XCTAssertFalse(DynamicColor.white.isContrasting(with: .red, inContext: .enhanced), "White and red are only contrasting in StandardLargeText")
    XCTAssertFalse(DynamicColor.white.isContrasting(with: .red, inContext: .enhancedLargeText), "White and red are only contrasting in StandardLargeText")
    
    
    let pink =  DynamicColor(hexString: "FF00FF")
    // Contrast ration between FF00FF and black = 6.7, . So, we should only return false in Enhanced
    XCTAssertTrue(DynamicColor.black.isContrasting(with: pink), "Black and pink are always contrasting except in Enhanced")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: pink, inContext: .standard), "Black and pink are always contrasting except in Enhanced")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: pink, inContext: .standardLargeText), "Black and pink are always contrasting except in Enhanced")
    XCTAssertFalse(DynamicColor.black.isContrasting(with: pink, inContext: .enhanced), "Black and pink are always contrasting except in Enhanced")
    XCTAssertTrue(DynamicColor.black.isContrasting(with: pink, inContext: .enhancedLargeText), "Black and pink are always contrasting except in Enhanced")
  }
}
