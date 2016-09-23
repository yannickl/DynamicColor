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

class DynamicColorLabTests: XCTestCase {
  func testInitWithLabComponents() {
    let whiteColor = DynamicColor(L: 100, a: 0, b: 0).toRGBAComponents()
    XCTAssert(whiteColor.r == 1, "Red component should be equal to 1 (not \(whiteColor.r))")
    XCTAssert(whiteColor.g == 1, "Green component should be equal to 1 (not \(whiteColor.g))")
    XCTAssert(whiteColor.b == 1, "Blue component should be equal to 1 (not \(whiteColor.b))")

    let blackColor = DynamicColor(L: 0, a: 0, b: 0).toRGBAComponents()
    XCTAssert(blackColor.r == 0, "Red component should be equal to 0 (not \(blackColor.r))")
    XCTAssert(blackColor.g == 0, "Green component should be equal to 0 (not \(blackColor.g))")
    XCTAssert(blackColor.b == 0, "Blue component should be equal to 0 (not \(blackColor.b))")

    let redColor = DynamicColor(L: 53.23, a: 80.10, b: 67.22).toRGBAComponents()
    XCTAssert(redColor.r == 1, "Red component should be equal to 1 (not \(redColor.r))")
    XCTAssert(redColor.g == 0, "Green component should be equal to 0 (not \(redColor.g))")
    XCTAssert(redColor.b == 0, "Blue component should be equal to 0 (not \(redColor.b))")

    let yellowColor = DynamicColor(L: 97.138, a: -21.56, b: 94.487).toRGBAComponents()
    XCTAssert(yellowColor.r == 1, "L component should be equal to 1 (not \(yellowColor.r))")
    XCTAssert(yellowColor.g == 1, "a component should be equal to 1 (not \(yellowColor.g))")
    XCTAssert(yellowColor.b == 0, "b component should be equal to 0 (not \(yellowColor.b))")

    let customColor = DynamicColor(L: 50.493, a: -49.333, b: 31.056).toRGBAComponents()
    XCTAssert(customColor.r == 0, "Red component should be equal to 0 (not \(customColor.r))")
    XCTAssert(customColor.g == 0.545, "Green component should be equal to 0.545 (not \(customColor.g))")
    XCTAssert(customColor.b == 0.251, "Blue component should be equal to 0.251 (not \(customColor.b))")
  }

  func testToLabComponents() {
    let whiteLab = DynamicColor.white.toLabComponents()
    XCTAssert(whiteLab.L == 100, "L component should be equal to 100 (not \(whiteLab.L))")
    XCTAssert(whiteLab.a == 0, "a component should be equal to 0 (not \(whiteLab.a))")
    XCTAssert(whiteLab.b == 0, "b component should be equal to 0 (not \(whiteLab.b))")

    let blackLab = DynamicColor.black.toLabComponents()
    XCTAssert(blackLab.L == 0, "L component should be equal to 0 (not \(blackLab.L))")
    XCTAssert(blackLab.a == 0, "a component should be equal to 0 (not \(blackLab.a))")
    XCTAssert(blackLab.b == 0, "b component should be equal to 0 (not \(blackLab.b))")

    let redLab = DynamicColor.red.toLabComponents()
    XCTAssert(redLab.L == 53.233, "L component should be equal to 53.233 (not \(redLab.L))")
    XCTAssert(redLab.a == 80.105, "a component should be equal to 80.105 (not \(redLab.a))")
    XCTAssert(redLab.b == 67.223, "b component should be equal to 67.223 (not \(redLab.b))")

    let yellowLab = DynamicColor.yellow.toLabComponents()
    XCTAssert(yellowLab.L == 97.138, "L component should be equal to 97.138 (not \(yellowLab.L))")
    XCTAssert(yellowLab.a == -21.561, "a component should be equal to -21.561 (not \(yellowLab.a))")
    XCTAssert(yellowLab.b == 94.488, "b component should be equal to 94.488 (not \(yellowLab.b))")

    let maxLab = DynamicColor(hex: 0xFF4500).toLabComponents()
    XCTAssert(maxLab.L == 57.575, "L component should be equal to 57.575 (not \(maxLab.L))")
    XCTAssert(maxLab.a == 67.792, "a component should be equal to 67.792 (not \(maxLab.a))")
    XCTAssert(maxLab.b == 68.977, "b component should be equal to 68.977 (not \(maxLab.b))")

    let minLab = DynamicColor(hex: 0x008B40).toLabComponents()
    XCTAssert(minLab.L == 50.494, "L component should be equal to 50.494 (not \(minLab.L))")
    XCTAssert(minLab.a == -49.334, "a component should be equal to -49.334 (not \(minLab.a))")
    XCTAssert(minLab.b == 31.053, "b component should be equal to 31.053 (not \(minLab.b))")
  }
}
