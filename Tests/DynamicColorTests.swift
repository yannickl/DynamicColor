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

    XCTAssert(red.toHexString() == "#ff0000", "Color string should equal to #ff0000")
    XCTAssert(blue.toHexString() == "#0000ff", "Color string should equal to #0000ff")
    XCTAssert(green.toHexString() == "#00ff00", "Color string should equal to #00ff00")
    XCTAssert(yellow.toHexString() == "#ffff00", "Color string should equal to #ffff00")
    XCTAssert(black.toHexString() == "#000000", "Color string should equal to #000000")
    XCTAssert(custom.toHexString() == "#769a2b", "Color string should equal to #769a2b")
  }
}
