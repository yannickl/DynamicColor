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

class DynamicColorXYZTests: XCTTestCaseTemplate {
  func testInitWithXYZComponents() {
    let whiteColor = DynamicColor(X: 95.05, Y: 100, Z: 108.9).toRGBAComponents()
    XCTAssert(whiteColor.r == 1, "Red component should be equal to 1 (not \(whiteColor.r))")
    XCTAssert(whiteColor.g == 1, "Green component should be equal to 1 (not \(whiteColor.g))")
    XCTAssert(whiteColor.b == 1, "Blue component should be equal to 1 (not \(whiteColor.b))")

    let blackColor = DynamicColor(X: 0, Y: 0, Z: 0).toRGBAComponents()
    XCTAssert(blackColor.r == 0, "Red component should be equal to 0 (not \(blackColor.r))")
    XCTAssert(blackColor.g == 0, "Green component should be equal to 0 (not \(blackColor.g))")
    XCTAssert(blackColor.b == 0, "Blue component should be equal to 0 (not \(blackColor.b))")
  }

  func testToHSLComponents() {
    let whiteXYZA = DynamicColor.white().toXYZComponents()
    XCTAssert(whiteXYZA.X == 95.05, "X component should be equal to 95.05 (not \(whiteXYZA.X))")
    XCTAssert(whiteXYZA.Y == 100, "Y component should be equal to 100 (not \(whiteXYZA.Y))")
    XCTAssert(whiteXYZA.Z == 108.9, "Z component should be equal to 108.9 (not \(whiteXYZA.Z))")

    let blackXYZA = DynamicColor.black().toXYZComponents()
    XCTAssert(blackXYZA.X == 0, "X component should be equal to 0 (not \(blackXYZA.X))")
    XCTAssert(blackXYZA.Y == 0, "Y component should be equal to 0 (not \(blackXYZA.Y))")
    XCTAssert(blackXYZA.Z == 0, "Z component should be equal to 0 (not \(blackXYZA.Z))")

    let blueXYZA = DynamicColor.blue().toXYZComponents()
    XCTAssert(blueXYZA.X == 18.05, "X component should be equal to 18.05 (not \(blueXYZA.X))")
    XCTAssert(blueXYZA.Y == 7.22, "Y component should be equal to 7.22 (not \(blueXYZA.Y))")
    XCTAssert(blueXYZA.Z == 95.05, "Z component should be equal to 95.05 (not \(blueXYZA.Z))")

    let customXYZA = DynamicColor(red: 0.69804, green: 0.74118, blue: 0.20392, alpha: 1).toXYZComponents()
    XCTAssert(customXYZA.X == 37.177, "X component should be equal to 37.177 (not \(customXYZA.X))")
    XCTAssert(customXYZA.Y == 46.108, "Y component should be equal to 46.108 (not \(customXYZA.Y))")
    XCTAssert(customXYZA.Z == 10.189, "Z component should be equal to 10.189 (not \(customXYZA.Z))")
  }
}
