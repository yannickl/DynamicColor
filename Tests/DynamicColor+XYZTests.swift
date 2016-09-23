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

class DynamicColorXYZTests: XCTestCase {
  func testInitWithXYZComponents() {
    let whiteColor = DynamicColor(X: 95.05, Y: 100, Z: 108.9).toRGBAComponents()
    XCTAssert(whiteColor.r == 1, "Red component should be equal to 1 (not \(whiteColor.r))")
    XCTAssert(whiteColor.g == 1, "Green component should be equal to 1 (not \(whiteColor.g))")
    XCTAssert(whiteColor.b == 1, "Blue component should be equal to 1 (not \(whiteColor.b))")

    let blackColor = DynamicColor(X: 0, Y: 0, Z: 0).toRGBAComponents()
    XCTAssert(blackColor.r == 0, "Red component should be equal to 0 (not \(blackColor.r))")
    XCTAssert(blackColor.g == 0, "Green component should be equal to 0 (not \(blackColor.g))")
    XCTAssert(blackColor.b == 0, "Blue component should be equal to 0 (not \(blackColor.b))")

    let blueColor = DynamicColor(X: 18.05, Y: 7.22, Z: 95.05).toRGBAComponents()
    XCTAssert(blueColor.r == 0, "Red component should be equal to 0 (not \(blueColor.r))")
    XCTAssert(blueColor.g == 0, "Green component should be equal to 0 (not \(blueColor.g))")
    XCTAssert(blueColor.b == 1, "Blue component should be equal to 1 (not \(blueColor.b))")

    let customColor = DynamicColor(X: 37.177, Y: 46.108, Z: 10.189).toRGBAComponents()
    XCTAssert(customColor.r == 0.698, "Red component should be equal to 0.698 (not \(customColor.r))")
    XCTAssert(customColor.g == 0.741, "Green component should be equal to 0.741 (not \(customColor.g))")
    XCTAssert(customColor.b == 0.204, "Blue component should be equal to 0.204 (not \(customColor.b))")
  }

  func testToHSLComponents() {
    let whiteXYZ = DynamicColor.white.toXYZComponents()
    XCTAssert(whiteXYZ.X == 95.05, "X component should be equal to 95.05 (not \(whiteXYZ.X))")
    XCTAssert(whiteXYZ.Y == 100, "Y component should be equal to 100 (not \(whiteXYZ.Y))")
    XCTAssert(whiteXYZ.Z == 108.9, "Z component should be equal to 108.9 (not \(whiteXYZ.Z))")

    let blackXYZ = DynamicColor.black.toXYZComponents()
    XCTAssert(blackXYZ.X == 0, "X component should be equal to 0 (not \(blackXYZ.X))")
    XCTAssert(blackXYZ.Y == 0, "Y component should be equal to 0 (not \(blackXYZ.Y))")
    XCTAssert(blackXYZ.Z == 0, "Z component should be equal to 0 (not \(blackXYZ.Z))")

    let blueXYZ = DynamicColor.blue.toXYZComponents()
    XCTAssert(blueXYZ.X == 18.05, "X component should be equal to 18.05 (not \(blueXYZ.X))")
    XCTAssert(blueXYZ.Y == 7.22, "Y component should be equal to 7.22 (not \(blueXYZ.Y))")
    XCTAssert(blueXYZ.Z == 95.05, "Z component should be equal to 95.05 (not \(blueXYZ.Z))")

    let customXYZ = DynamicColor(red: 0.69804, green: 0.74118, blue: 0.20392, alpha: 1).toXYZComponents()
    XCTAssert(customXYZ.X == 37.178, "X component should be equal to 37.178 (not \(customXYZ.X))")
    XCTAssert(customXYZ.Y == 46.109, "Y component should be equal to 46.109 (not \(customXYZ.Y))")
    XCTAssert(customXYZ.Z == 10.189, "Z component should be equal to 10.189 (not \(customXYZ.Z))")
  }
}
