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

class DynamicColorTests: XCTTestCaseTemplate {
  func testColorFromHexString() {
    let redStandard = DynamicColor(red: 1, green: 0, blue: 0, alpha: 1)
    let redHex      = DynamicColor(hexString: "#ff0000")

    XCTAssert(redStandard.isEqual(redHex), "Color should be equals")

    let customStandard = DynamicColor(red: 171 / 255, green: 63 / 255, blue: 74 / 255, alpha: 1)
    let customHex      = DynamicColor(hexString: "ab3F4a")

    XCTAssert(customStandard.isEqual(customHex), "Color should be equals")

    let wrongStandard = DynamicColor(red: 0, green: 0, blue: 0, alpha: 1)
    let wrongHex      = DynamicColor(hexString: "#T5RD2Z")

    XCTAssert(wrongStandard.isEqual(wrongHex), "Color should be equals")
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
    XCTAssert(custom.toHexString() == "#769a2b", "Color string should be equal to #769a2b")
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

  func testIsEqualToHexString() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(blue.isEqualToHexString("#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(green.isEqualToHexString("#00ff00"), "Color string should be equal to #00ff00")
    XCTAssert(yellow.isEqualToHexString("#ffff00"), "Color string should be equal to #ffff00")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000")
    XCTAssert(custom.isEqualToHexString("#769a2b"), "Color string should be equal to #769a2b")
  }

  func testIsEqualToHex() {
    let red    = DynamicColor.red
    let blue   = DynamicColor.blue
    let green  = DynamicColor.green
    let yellow = DynamicColor.yellow
    let black  = DynamicColor.black
    let custom = DynamicColor(hex: 0x769a2b)

    XCTAssert(red.isEqualToHex(0xff0000), "Color string should be equal to 0xff0000")
    XCTAssert(blue.isEqualToHex(0x0000ff), "Color string should be equal to 0x0000ff")
    XCTAssert(green.isEqualToHex(0x00ff00), "Color string should be equal to 0x00ff00")
    XCTAssert(yellow.isEqualToHex(0xffff00), "Color string should be equal to 0xffff00")
    XCTAssert(black.isEqualToHex(0x000000), "Color string should be equal to 0x000000")
    XCTAssert(custom.isEqualToHex(0x769a2b), "Color string should be equal to 0x769a2b")
  }

  func testAdjustHueColor() {
    let custom1 = DynamicColor(hex: 0x881111).adjustedHue(amount: 45)
    let custom2 = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 90)
    let custom3 = DynamicColor(hex: 0xc0392b).adjustedHue(amount: -60)
    let same1   = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 0)
    let same2   = DynamicColor(hex: 0xc0392b).adjustedHue(amount: 360)

    XCTAssert(custom1.isEqualToHexString("#886a11"), "Should be equal to #886a11 (not \(custom1.toHexString()))")
    XCTAssert(custom2.isEqualToHexString("#67c02b"), "Should be equal to #67c02b (not \(custom2.toHexString()))")
    XCTAssert(custom3.isEqualToHexString("#c02bb2"), "Should be equal to #c02bb2 (not \(custom3.toHexString()))")
    XCTAssert(same1.isEqualToHexString("#c0392b"), "Should be equal to #c0392b (not \(same1.toHexString()))")
    XCTAssert(same2.isEqualToHexString("#c0392b"), "Should be equal to #c0392b (not \(same2.toHexString()))")
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

    XCTAssert(red.isEqualToHex(0xff6666), "Should be equal to #ff6666 (not \(red.toHexString()))")
    XCTAssert(green.isEqualToHex(0x66ff66), "Should be equal to #66ff66 (not \(green.toHexString()))")
    XCTAssert(blue.isEqualToHex(0x6666ff), "Should be equal to #6666ff (not \(blue.toHexString()))")
    XCTAssert(violet.isEqualToHex(0xff66ff), "Should be equal to #ff66ff (not \(violet.toHexString()))")
    XCTAssert(white.isEqualToHex(0xffffff), "Should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqualToHex(0x333333), "Should be equal to #333333 (not \(black.toHexString()))")
    XCTAssert(gray.isEqual(DynamicColor(hex: 0x666666)), "Should be equal to #666666 (not \(gray.toHexString()))")
  }

  func testLightenColor() {
    let whiteFromBlack = DynamicColor.black.lighter(amount: 1)
    let same           = DynamicColor(hex: 0xc0392b).lighter(amount: 0)
    let maxi           = DynamicColor(hex: 0xc0392b).lighter(amount: 1)

    XCTAssert(whiteFromBlack.isEqualToHexString("#ffffff"), "Color should be equals (not \(whiteFromBlack.toHexString()))")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(maxi.toHexString()))")
  }

  func testDarkerColor() {
    let red   = DynamicColor.red.darkened()
    let white = DynamicColor.white.darkened()
    let gray  = white.darkened()
    let black = DynamicColor.black.darkened()

    XCTAssert(red.isEqualToHexString("#990000"), "Color string should be equal to #990000 (not \(red.toHexString()))")
    XCTAssert(white.isEqualToHexString("#cccccc"), "Color string should be equal to #cccccc (not \(white.toHexString()))")
    XCTAssert(gray.isEqualToHexString("#999999"), "Color string should be equal to #999999 (not \(gray.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
  }

  func testDarkenColor() {
    let blackFromWhite = DynamicColor.white.darkened(amount: 1)
    let same           = DynamicColor(hex: 0xc0392b).darkened(amount: 0)
    let maxi           = DynamicColor(hex: 0xc0392b).darkened(amount: 1)

    XCTAssert(blackFromWhite.isEqualToHexString("#000000"), "Colors should be the same (not \(blackFromWhite.toHexString()))")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(maxi.toHexString()))")
  }

  func testSaturatedColor() {
    let primary = DynamicColor.red.saturated()
    let white   = DynamicColor.white.saturated()
    let black   = DynamicColor.black.saturated()
    let custom  = DynamicColor(hex: 0xc0392b).saturated()


    XCTAssert(primary.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000 (not \(primary.toHexString()))")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqualToHexString("#d72513"), "Color string should be equal to #d72513 (not \(custom.toHexString()))")
  }

  func testSaturateColor() {
    let same = DynamicColor(hex: 0xc0392b).saturated(amount: 0)
    let maxi = DynamicColor(hex: 0xc0392b).saturated(amount: 1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#eb1600"), "Color string should be equal to #eb1600 (not \(maxi.toHexString()))")
  }

  func testDesaturatedColor() {
    let primary = DynamicColor.red.desaturated()
    let white   = DynamicColor.white.desaturated()
    let black   = DynamicColor.black.desaturated()
    let custom  = DynamicColor(hex: 0xc0392b).desaturated()

    XCTAssert(primary.isEqualToHexString("#e51919"), "Color string should be equal to #e51919 (not \(primary.toHexString()))")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqualToHexString("#a84c42"), "Color string should be equal to #a84c42 (not \(custom.toHexString()))")
  }

  func testDesaturateColor() {
    let same = DynamicColor(hex: 0xc0392b).desaturated(amount: 0)
    let maxi = DynamicColor(hex: 0xc0392b).desaturated(amount: 1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#757575"), "Color string should be equal to #757575 (not \(maxi.toHexString()))")
  }

  func testGrayscaleColor() {
    let grayscale   = DynamicColor(hex: 0xc0392b).grayscaled()
    let desaturated = DynamicColor(hex: 0xc0392b).desaturated(amount: 1)

    XCTAssert(grayscale.isEqual(desaturated), "Colors should be the same")
  }

  func testInvertColor() {
    let inverted = DynamicColor(hex: 0xff0000).inverted()
    let original = inverted.inverted()

    XCTAssert(inverted.isEqualToHexString("#00ffff"), "Color string should be equal to #00ffff")
    XCTAssert(original.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
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

  func testMixColors() {
    let red  = DynamicColor.red
    let blue = DynamicColor.blue

    var midMix = red.mixed(color: blue)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should be equal to #7f007f")

    midMix = blue.mixed(color: red)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should be equal to #7f007f")

    let noMix         = red.mixed(color: blue, weight: 0)
    let noMixOverflow = red.mixed(color: blue, weight: -20)

    XCTAssert(noMix.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixed(color: blue, weight: 1)
    let fullMixOverflow = red.mixed(color: blue, weight: 24)

    XCTAssert(fullMix.isEqualToHexString("#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testTintColor() {
    let tint = DynamicColor(hex: 0xc0392b).tinted()

    XCTAssert(tint.isEqualToHexString("#cc6055"), "Color string should be equal to #cc6055")

    let white = DynamicColor(hex: 0xc0392b).tinted(amount: 1)

    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff")

    let alwaysWhite = DynamicColor.white.tinted()

    XCTAssert(alwaysWhite.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff")
  }

  func testShadeColor() {
    let shade = DynamicColor(hex: 0xc0392b).shaded()

    XCTAssert(shade.isEqualToHexString("#992d22"), "Color string should be equal to #992d22")

    let black = DynamicColor(hex: 0xc0392b).shaded(amount: 1)

    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000")
    
    let alwaysBlack = DynamicColor.black.shaded()
    
    XCTAssert(alwaysBlack.isEqualToHexString("#000000"), "Color string should be equal to #000000")
  }
}
