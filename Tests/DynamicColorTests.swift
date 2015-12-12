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
import XCTest

class DynamicColorTests: XCTTestCaseTemplate {
  func testColorFromHexString() {
    let redStandard = UIColor.redColor()
    let redHex      = UIColor(hexString: "#ff0000")

    XCTAssert(redStandard.isEqual(redHex), "Color should be equals")

    let customStandard = UIColor(red: 171 / 255, green: 63 / 255, blue: 74 / 255, alpha: 1)
    let customHex      = UIColor(hexString: "ab3F4a")

    XCTAssert(customStandard.isEqual(customHex), "Color should be equals")

    let wrongStandard = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let wrongHex      = UIColor(hexString: "#T5RD2Z")

    XCTAssert(wrongStandard.isEqual(wrongHex), "Color should be equals")
  }

  func testToHexString() {
    let red    = UIColor.redColor()
    let blue   = UIColor.blueColor()
    let green  = UIColor.greenColor()
    let yellow = UIColor.yellowColor()
    let black  = UIColor.blackColor()
    let custom = UIColor(hex: 0x769a2b)

    XCTAssert(red.toHexString() == "#ff0000", "Color string should be equal to #ff0000")
    XCTAssert(blue.toHexString() == "#0000ff", "Color string should be equal to #0000ff")
    XCTAssert(green.toHexString() == "#00ff00", "Color string should be equal to #00ff00")
    XCTAssert(yellow.toHexString() == "#ffff00", "Color string should be equal to #ffff00")
    XCTAssert(black.toHexString() == "#000000", "Color string should be equal to #000000")
    XCTAssert(custom.toHexString() == "#769a2b", "Color string should be equal to #769a2b")
  }

  func testToHex() {
    let red    = UIColor.redColor()
    let blue   = UIColor.blueColor()
    let green  = UIColor.greenColor()
    let yellow = UIColor.yellowColor()
    let black  = UIColor.blackColor()
    let custom = UIColor(hex: 0x769a2b)

    XCTAssert(red.toHex() == 0xff0000, "Color string should be equal to 0xff0000")
    XCTAssert(blue.toHex() == 0x0000ff, "Color string should be equal to 0x0000ff")
    XCTAssert(green.toHex() == 0x00ff00, "Color string should be equal to 0x00ff00")
    XCTAssert(yellow.toHex() == 0xffff00, "Color string should be equal to 0xffff00")
    XCTAssert(black.toHex() == 0x000000, "Color string should be equal to 0x000000")
    XCTAssert(custom.toHex() == 0x769a2b, "Color string should be equal to 0x769a2b")
  }

  func testIsEqualToHexString() {
    let red    = UIColor.redColor()
    let blue   = UIColor.blueColor()
    let green  = UIColor.greenColor()
    let yellow = UIColor.yellowColor()
    let black  = UIColor.blackColor()
    let custom = UIColor(hex: 0x769a2b)

    XCTAssert(red.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(blue.isEqualToHexString("#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(green.isEqualToHexString("#00ff00"), "Color string should be equal to #00ff00")
    XCTAssert(yellow.isEqualToHexString("#ffff00"), "Color string should be equal to #ffff00")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000")
    XCTAssert(custom.isEqualToHexString("#769a2b"), "Color string should be equal to #769a2b")
  }

  func testIsEqualToHex() {
    let red    = UIColor.redColor()
    let blue   = UIColor.blueColor()
    let green  = UIColor.greenColor()
    let yellow = UIColor.yellowColor()
    let black  = UIColor.blackColor()
    let custom = UIColor(hex: 0x769a2b)

    XCTAssert(red.isEqualToHex(0xff0000), "Color string should be equal to 0xff0000")
    XCTAssert(blue.isEqualToHex(0x0000ff), "Color string should be equal to 0x0000ff")
    XCTAssert(green.isEqualToHex(0x00ff00), "Color string should be equal to 0x00ff00")
    XCTAssert(yellow.isEqualToHex(0xffff00), "Color string should be equal to 0xffff00")
    XCTAssert(black.isEqualToHex(0x000000), "Color string should be equal to 0x000000")
    XCTAssert(custom.isEqualToHex(0x769a2b), "Color string should be equal to 0x769a2b")
  }

  func testToRGBAComponents() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let rgba = customColor.toRGBAComponents()
    XCTAssert(rgba.r == 0.23, "Color red component should be equal to 0.23")
    XCTAssert(rgba.g == 0.46, "Color green component should be equal to 0.46")
    XCTAssert(rgba.b == 0.32, "Color blue component should be equal to 0.32")
    XCTAssert(rgba.a == 1, "Color alpha component should be equal to 1")
  }

  func testRedComponent() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let redComponent = customColor.redComponent

    XCTAssert(redComponent == 0.23, "Color red component should be equal to 0.23")
  }

  func testGreenComponent() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let greenComponent = customColor.greenComponent

    XCTAssert(greenComponent == 0.46, "Color green component should be equal to 0.46")
  }

  func testBlueComponent() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let blueComponent = customColor.blueComponent

    XCTAssert(blueComponent == 0.32, "Color blue component should be equal to 0.32")
  }

  func testAlphaComponent() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let alphaComponent = customColor.alphaComponent

    XCTAssert(alphaComponent == 1, "Color alpha component should be equal to 1")
  }

  func testAdjustedAlphaColor() {
    let customColor = UIColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    XCTAssert(customColor.alphaComponent == 1, "Color alpha component should be equal to 1")

    let adjustedAlpha1 = customColor.adjustedAlphaColor(-0.5)

    XCTAssert(adjustedAlpha1.alphaComponent == 0.5, "Color alpha component should be equal to 0.5")

    let adjustedAlpha2 = adjustedAlpha1.adjustedAlphaColor(0.2)

    XCTAssert(adjustedAlpha2.alphaComponent == 0.7, "Color alpha component should be equal to 0.7")

    let adjustedAlpha3 = adjustedAlpha2.adjustedAlphaColor(-1)

    XCTAssert(adjustedAlpha3.alphaComponent == 0, "Color alpha component should be equal to 0")

    let adjustedAlpha4 = adjustedAlpha3.adjustedAlphaColor(23)

    XCTAssert(adjustedAlpha4.alphaComponent == 1, "Color alpha component should be equal to 1")
  }

  func testInitWithHSLAComponents() {
    let black1 = UIColor(hue: 0, saturation: 0, lightness: 0)
    let black2 = UIColor(hue: 1, saturation: 1, lightness: 0)
    let white1 = UIColor(hue: 0, saturation: 0, lightness: 1)
    let white2 = UIColor(hue: 1, saturation: 1, lightness: 1)

    let red   = UIColor(hue: 0, saturation: 1, lightness: 0.5)
    let green = UIColor(hue: 120 / 360, saturation: 1, lightness: 0.5)
    let blue  = UIColor(hue: 240 / 360, saturation: 1, lightness: 0.5)

    let custom = UIColor(hue: 6 / 360, saturation: 0.781, lightness: 0.571)
    let alpha  = UIColor(hue: 6 / 360, saturation: 0.781, lightness: 0.571, alpha: 0.5)

    XCTAssert(black1.toHex() == 0, "Color should be black")
    XCTAssert(black2.toHex() == 0, "Color should be black")
    XCTAssert(white1.toHex() == 0xffffff, "Color should be white")
    XCTAssert(white2.toHex() == 0xffffff, "Color should be white")

    XCTAssert(red.isEqual(UIColor.redColor()), "Color should be red")
    XCTAssert(green.isEqual(UIColor.greenColor()), "Color should be green")
    XCTAssert(blue.isEqual(UIColor.blueColor()), "Color should be blue")

    XCTAssert(custom.isEqualToHexString("#e74d3c"), "Color should be equal to #e74d3c")
    XCTAssert(alpha.isEqualToHexString("#e74d3c"), "Color should be equal to #e74d3c")
    XCTAssert(alpha.alphaComponent == 0.5, "Color alpha channel should be equal to 0.5")
  }

  func testToHSLAComponents() {
    let customColor = UIColor(hue: 6 / 360, saturation: 0.781, lightness: 0.571)
    let hsla        = customColor.toHSLAComponents()

    XCTAssert(round(hsla.h * 1000) == round(6.0 / 360 * 1000), "Color hue component should be equal to 6 / 360")
    XCTAssert(round(hsla.s * 1000) == round(0.781 * 1000), "Color saturation component should be equal to 0.781")
    XCTAssert(hsla.l == 0.571, "Color lightness component should be equal to 0.571")
    XCTAssert(hsla.a == 1, "Color alpha component should be equal to 1")
  }

  func testAdjustHueColor() {
    let custom1 = UIColor(hex: 0x881111).adjustedHueColor(45 / 360)
    let custom2 = UIColor(hex: 0xc0392b).adjustedHueColor(90 / 360)
    let custom3 = UIColor(hex: 0xc0392b).adjustedHueColor(-60 / 360)
    let same1   = UIColor(hex: 0xc0392b).adjustedHueColor(0)
    let same2   = UIColor(hex: 0xc0392b).adjustedHueColor(360 / 360)

    XCTAssert(custom1.isEqualToHexString("#886a11"), "Color string should be equal to #886a11 (not \(custom1.toHexString()))")
    XCTAssert(custom2.isEqualToHexString("#67c02b"), "Color string should be equal to #67c02b (not \(custom2.toHexString()))")
    XCTAssert(custom3.isEqualToHexString("#c02bb2"), "Color string should be equal to #c02bb2 (not \(custom3.toHexString()))")
    XCTAssert(same1.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same1.toHexString()))")
    XCTAssert(same2.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same2.toHexString()))")
  }

  func testComplementColor() {
    let complement  = UIColor(hex: 0xc0392b).complementColor()
    let adjustedHue = UIColor(hex: 0xc0392b).adjustedHueColor(180 / 360)

    XCTAssert(complement.isEqual(adjustedHue), "Colors should be the same")
  }

  func testLighterColor() {
    let red    = UIColor.redColor().lighterColor()
    let green  = UIColor.greenColor().lighterColor()
    let blue   = UIColor.blueColor().lighterColor()
    let violet = UIColor(red: 1, green: 0, blue: 1, alpha: 1).lighterColor()
    let white  = UIColor.whiteColor().lighterColor()
    let black  = UIColor.blackColor().lighterColor()
    let gray   = black.lighterColor()

    XCTAssert(red.isEqual(UIColor(hex: 0xff6666)), "Color string should be equal to #6666ff (not \(red.toHexString()))")
    XCTAssert(green.isEqual(UIColor(hex: 0x66ff66)), "Color string should be equal to #66ff66 (not \(green.toHexString()))")
    XCTAssert(blue.isEqual(UIColor(hex: 0x6666ff)), "Color string should be equal to #6666ff (not \(blue.toHexString()))")
    XCTAssert(violet.isEqual(UIColor(hex: 0xff66ff)), "Color string should be equal to #ff66ff (not \(violet.toHexString()))")
    XCTAssert(white.isEqual(UIColor(hex: 0xffffff)), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqual(UIColor(hex: 0x333333)), "Color string should be equal to #333333 (not \(black.toHexString()))")
    XCTAssert(gray.isEqual(UIColor(hex: 0x666666)), "Color string should be equal to #666666 (not \(gray.toHexString()))")
  }

  func testLightenColor() {
    let whiteFromBlack = UIColor.blackColor().lightenColor(1)
    let same           = UIColor(hex: 0xc0392b).lightenColor(0)
    let maxi           = UIColor(hex: 0xc0392b).lightenColor(1)

    XCTAssert(whiteFromBlack.isEqualToHexString("#ffffff"), "Color should be equals (not \(whiteFromBlack.toHexString()))")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(maxi.toHexString()))")
  }

  func testDarkerColor() {
    let red   = UIColor.redColor().darkerColor()
    let white = UIColor.whiteColor().darkerColor()
    let gray  = white.darkerColor()
    let black = UIColor.blackColor().darkerColor()

    XCTAssert(red.isEqualToHexString("#990000"), "Color string should be equal to #990000 (not \(red.toHexString()))")
    XCTAssert(white.isEqualToHexString("#cccccc"), "Color string should be equal to #cccccc (not \(white.toHexString()))")
    XCTAssert(gray.isEqualToHexString("#999999"), "Color string should be equal to #999999 (not \(gray.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
  }

  func testDarkenColor() {
    let blackFromWhite = UIColor.whiteColor().darkenColor(1)
    let same           = UIColor(hex: 0xc0392b).darkenColor(0)
    let maxi           = UIColor(hex: 0xc0392b).darkenColor(1)

    XCTAssert(blackFromWhite.isEqualToHexString("#000000"), "Colors should be the same (not \(blackFromWhite.toHexString()))")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(maxi.toHexString()))")
  }

  func testSaturatedColor() {
    let primary = UIColor.redColor().saturatedColor()
    let white   = UIColor.whiteColor().saturatedColor()
    let black   = UIColor.blackColor().saturatedColor()
    let custom  = UIColor(hex: 0xc0392b).saturatedColor()


    XCTAssert(primary.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000 (not \(primary.toHexString()))")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqualToHexString("#d72513"), "Color string should be equal to #d72513 (not \(custom.toHexString()))")
  }

  func testSaturateColor() {
    let same = UIColor(hex: 0xc0392b).saturateColor(0)
    let maxi = UIColor(hex: 0xc0392b).saturateColor(1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#eb1600"), "Color string should be equal to #eb1600 (not \(maxi.toHexString()))")
  }

  func testDesaturatedColor() {
    let primary = UIColor.redColor().desaturatedColor()
    let white   = UIColor.whiteColor().desaturatedColor()
    let black   = UIColor.blackColor().desaturatedColor()
    let custom  = UIColor(hex: 0xc0392b).desaturatedColor()

    XCTAssert(primary.isEqualToHexString("#e51919"), "Color string should be equal to #e51919 (not \(primary.toHexString()))")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff (not \(white.toHexString()))")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000 (not \(black.toHexString()))")
    XCTAssert(custom.isEqualToHexString("#a84c42"), "Color string should be equal to #a84c42 (not \(custom.toHexString()))")
  }

  func testDesaturateColor() {
    let same = UIColor(hex: 0xc0392b).desaturateColor(0)
    let maxi = UIColor(hex: 0xc0392b).desaturateColor(1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should be equal to #c0392b (not \(same.toHexString()))")
    XCTAssert(maxi.isEqualToHexString("#757575"), "Color string should be equal to #757575 (not \(maxi.toHexString()))")
  }

  func testGrayscaleColor() {
    let grayscale   = UIColor(hex: 0xc0392b).grayscaledColor()
    let desaturated = UIColor(hex: 0xc0392b).desaturateColor(1)

    XCTAssert(grayscale.isEqual(desaturated), "Colors should be the same")
  }

  func testInvertColor() {
    let invert   = UIColor(hex: 0xff0000).invertColor()
    let original = invert.invertColor()

    XCTAssert(invert.isEqualToHexString("#00ffff"), "Color string should be equal to #00ffff")
    XCTAssert(original.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
  }

  func testIsLightColor() {
    let l1 = UIColor.whiteColor()
    let l2 = UIColor.greenColor()
    let d1 = UIColor.blackColor()
    let d2 = UIColor.redColor()
    let d3 = UIColor.blueColor()

    XCTAssert(l1.isLightColor(), "White should be light")
    XCTAssert(l2.isLightColor(), "Green should be light")
    XCTAssertFalse(d1.isLightColor(), "Black should be dark")
    XCTAssertFalse(d2.isLightColor(), "Red should be dark")
    XCTAssertFalse(d3.isLightColor(), "Blue should be dark")
  }

  func testMixColors() {
    let red  = UIColor.redColor()
    let blue = UIColor.blueColor()

    var midMix = red.mixWithColor(blue)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should be equal to #7f007f")

    midMix = blue.mixWithColor(red)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should be equal to #7f007f")

    let noMix         = red.mixWithColor(blue, weight: 0)
    let noMixOverflow = red.mixWithColor(blue, weight: -20)

    XCTAssert(noMix.isEqualToHexString("#ff0000"), "Color string should be equal to #ff0000")
    XCTAssert(noMix.isEqual(noMixOverflow), "Colors should be the same")

    let fullMix         = red.mixWithColor(blue, weight: 1)
    let fullMixOverflow = red.mixWithColor(blue, weight: 24)

    XCTAssert(fullMix.isEqualToHexString("#0000ff"), "Color string should be equal to #0000ff")
    XCTAssert(fullMix.isEqual(fullMixOverflow), "Colors should be the same")
  }

  func testTintColor() {
    let tint = UIColor(hex: 0xc0392b).tintColor()

    XCTAssert(tint.isEqualToHexString("#cc6055"), "Color string should be equal to #cc6055")

    let white = UIColor(hex: 0xc0392b).tintColor(amount: 1)

    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff")

    let alwaysWhite = UIColor.whiteColor().tintColor()

    XCTAssert(alwaysWhite.isEqualToHexString("#ffffff"), "Color string should be equal to #ffffff")
  }

  func testShadeColor() {
    let shade = UIColor(hex: 0xc0392b).shadeColor()

    XCTAssert(shade.isEqualToHexString("#992d22"), "Color string should be equal to #992d22")

    let black = UIColor(hex: 0xc0392b).shadeColor(amount: 1)

    XCTAssert(black.isEqualToHexString("#000000"), "Color string should be equal to #000000")
    
    let alwaysBlack = UIColor.blackColor().shadeColor()
    
    XCTAssert(alwaysBlack.isEqualToHexString("#000000"), "Color string should be equal to #000000")
  }
}
