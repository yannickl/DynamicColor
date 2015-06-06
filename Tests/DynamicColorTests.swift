//
//  DynamicColorTests.swift
//  DynamicColorTests
//
//  Created by Yannick LORIOT on 01/06/15.
//  Copyright (c) 2015 Yannick LORIOT. All rights reserved.
//

import UIKit
import XCTest

class DynamicColorTests: XCTestCase {
  func testColorFromHexString() {
    let redStandard = UIColor.redColor()
    let redHex      = UIColor(hexString: "#ff0000")

    XCTAssert(redStandard.isEqual(redHex), "Color should be equals")

    let customStandard = UIColor(red: 171 / 255, green: 63 / 255, blue: 74 / 255, alpha: 1)
    let customHex      = UIColor(hexString: "ab3F4a")

    XCTAssert(customStandard.isEqual(customHex), "Color should be equals")

    let wrongStandard = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let wrongHex      = UIColor(hexString: "#T5RD2Z")

    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    XCTAssert(wrongStandard.isEqual(wrongHex), "Color should be equals")
  }

  func testToHexString() {
    let red    = UIColor.redColor()
    let blue   = UIColor.blueColor()
    let green  = UIColor.greenColor()
    let yellow = UIColor.yellowColor()
    let black  = UIColor.blackColor()
    let custom = UIColor(hex: 0x769a2b)

    XCTAssert(red.isEqualToHexString("#ff0000"), "Color string should equal to #ff0000")
    XCTAssert(blue.isEqualToHexString("#0000ff"), "Color string should equal to #0000ff")
    XCTAssert(green.isEqualToHexString("#00ff00"), "Color string should equal to #00ff00")
    XCTAssert(yellow.isEqualToHexString("#ffff00"), "Color string should equal to #ffff00")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should equal to #000000")
    XCTAssert(custom.isEqualToHexString("#769a2b"), "Color string should equal to #769a2b")
  }

  func testAdjustHueColor() {
    let custom1  = UIColor(hex: 0x881111).adjustedHueColor(45 / 360)
    let custom2 = UIColor(hex: 0xc0392b).adjustedHueColor(90 / 360)
    let custom3 = UIColor(hex: 0xc0392b).adjustedHueColor(-60 / 360)
    let same    = UIColor(hex: 0xc0392b).adjustedHueColor(360 / 360)

    XCTAssert(custom1.isEqualToHexString("#886a10"), "Color string should equal to #886a10")
    XCTAssert(custom2.isEqualToHexString("#67c02b"), "Color string should equal to #67c02b")
    XCTAssert(custom3.isEqualToHexString("#c02bb1"), "Color string should equal to #c02bb1")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should equal to #c0392b")
  }

  func testComplementColor() {
    let complement  = UIColor(hex: 0xc0392b).complementColor()
    let adjustedHue = UIColor(hex: 0xc0392b).adjustedHueColor(180 / 360)

    XCTAssert(complement.isEqual(adjustedHue), "Colors should be the same")
  }

  func testLighterColor() {
    let red   = UIColor.redColor().lighterColor()
    let white = UIColor.whiteColor().lighterColor()
    let black = UIColor.blackColor().lighterColor()
    let gray  = black.lighterColor()

    XCTAssert(red.isEqualToHexString("#ff6565"), "Color string should equal to #ff6565")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should equal to #ffffff")
    XCTAssert(black.isEqualToHexString("#333333"), "Color string should equal to #333333")
    XCTAssert(gray.isEqualToHexString("#666666"), "Color string should equal to #666666")
  }

  func testLightenColor() {
    let whiteFromBlack = UIColor.blackColor().lightenColor(1)
    let same           = UIColor(hex: 0xc0392b).lightenColor(0)
    let maxi           = UIColor(hex: 0xc0392b).lightenColor(1)

    XCTAssert(whiteFromBlack.isEqualToHexString("#ffffff"), "Color should be equals")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should equal to #c0392b")
    XCTAssert(maxi.isEqualToHexString("#ffffff"), "Color string should equal to #ffffff")
  }

  func testDarkerColor() {
    let red   = UIColor.redColor().darkerColor()
    let white = UIColor.whiteColor().darkerColor()
    let gray  = white.darkerColor()
    let black = UIColor.blackColor().darkerColor()

    XCTAssert(red.isEqualToHexString("#990000"), "Color string should equal to #990000")
    XCTAssert(white.isEqualToHexString("#cccccc"), "Color string should equal to #cccccc")
    XCTAssert(gray.isEqualToHexString("#999999"), "Color string should equal to #999999")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should equal to #000000")
  }

  func testDarkenColor() {
    let blackFromWhite = UIColor.whiteColor().darkenColor(1)
    let same           = UIColor(hex: 0xc0392b).darkenColor(0)
    let maxi           = UIColor(hex: 0xc0392b).darkenColor(1)

    XCTAssert(blackFromWhite.isEqualToHexString("#000000"), "Color should be equals")
    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should equal to #c0392b")
    XCTAssert(maxi.isEqualToHexString("#000000"), "Color string should equal to #000000")
  }

  func testSaturatedColor() {
    let primary = UIColor.redColor().saturatedColor()
    let white   = UIColor.whiteColor().saturatedColor()
    let black   = UIColor.blackColor().saturatedColor()
    let custom  = UIColor(hex: 0xc0392b).saturatedColor()


    XCTAssert(primary.isEqualToHexString("#ff0000"), "Color string should equal to #ff0000")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should equal to #ffffff")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should equal to #000000")
    XCTAssert(custom.isEqualToHexString("#d72513"), "Color string should equal to #d72513")
  }

  func testSaturateColor() {
    let same = UIColor(hex: 0xc0392b).saturateColor(0)
    let maxi = UIColor(hex: 0xc0392b).saturateColor(1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should equal to #c0392b")
    XCTAssert(maxi.isEqualToHexString("#eb1600"), "Color string should equal to #eb1600")
  }

  func testDesaturatedColor() {
    let primary = UIColor.redColor().desaturatedColor()
    let white   = UIColor.whiteColor().desaturatedColor()
    let black   = UIColor.blackColor().desaturatedColor()
    let custom  = UIColor(hex: 0xc0392b).desaturatedColor()

    XCTAssert(primary.isEqualToHexString("#e51919"), "Color string should equal to #e51919")
    XCTAssert(white.isEqualToHexString("#ffffff"), "Color string should equal to #ffffff")
    XCTAssert(black.isEqualToHexString("#000000"), "Color string should equal to #000000")
    XCTAssert(custom.isEqualToHexString("#a84c42"), "Color string should equal to #a84c42")
  }

  func testDesaturateColor() {
    let same = UIColor(hex: 0xc0392b).desaturateColor(0)
    let maxi = UIColor(hex: 0xc0392b).desaturateColor(1)

    XCTAssert(same.isEqualToHexString("#c0392b"), "Color string should equal to #c0392b")
    XCTAssert(maxi.isEqualToHexString("#757575"), "Color string should equal to #757575")
  }

  func testGrayscaleColor() {
    let grayscale   = UIColor(hex: 0xc0392b).grayscaledColor()
    let desaturated = UIColor(hex: 0xc0392b).desaturateColor(1)

    XCTAssert(grayscale.isEqual(desaturated), "Colors should be the same")
  }

  func testInvertColor() {
    let invert   = UIColor(hex: 0xff0000).invertColor()
    let original = invert.invertColor()

    XCTAssert(invert.isEqualToHexString("#00ffff"), "Color string should equal to #00ffff")
    XCTAssert(original.isEqualToHexString("#ff0000"), "Color string should equal to #ff0000")
  }

  func testMixColors() {
    let red  = UIColor.redColor()
    let blue = UIColor.blueColor()

    var midMix = red.mixWithColor(blue)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should equal to #7f007f")

    midMix = blue.mixWithColor(red)

    XCTAssert(midMix.isEqualToHexString("#7f007f"), "Color string should equal to #7f007f")

    let noMix = red.mixWithColor(blue, weight: 0)

    XCTAssert(noMix.isEqualToHexString("#ff0000"), "Color string should equal to #ff0000")

    let fullMix = red.mixWithColor(blue, weight: 1)

    XCTAssert(fullMix.isEqualToHexString("#0000ff"), "Color string should equal to #0000ff")
  }
}
