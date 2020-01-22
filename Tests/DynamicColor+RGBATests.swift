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
@testable import DynamicColor

class DynamicColorRGBATests: XCTestCase {
  func testInit() {
    let customInitColor = DynamicColor(r: 58.65, g: 117.3, b: 81.6)
    let customColor     = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    XCTAssertEqual(customInitColor.toHex(), customColor.toHex())
  }

  func testToRGBAComponents() {
    let rgbaColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)
    let rgba1 = rgbaColor.toRGBAComponents()
    XCTAssertEqual(rgba1.r, 0.23)
    XCTAssertEqual(rgba1.g, 0.46)
    XCTAssertEqual(rgba1.b, 0.32)
    XCTAssertEqual(rgba1.a, 1.00)

    let grayscaleColor = DynamicColor(white: 0.42, alpha: 1)
    let rgba2 = grayscaleColor.toRGBAComponents()
    XCTAssertEqual(rgba2.r, 0.42, accuracy: 0.001)
    XCTAssertEqual(rgba2.g, 0.42, accuracy: 0.001)
    XCTAssertEqual(rgba2.b, 0.42, accuracy: 0.001)
    XCTAssertEqual(rgba2.a, 1.00, accuracy: 0.001)
  }

  func testRedComponent() {
    let customColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let redComponent = customColor.redComponent

    XCTAssert(redComponent == 0.23, "Color red component should be equal to 0.23")
  }

  func testGreenComponent() {
    let customColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let greenComponent = customColor.greenComponent

    XCTAssert(greenComponent == 0.46, "Color green component should be equal to 0.46")
  }

  func testBlueComponent() {
    let customColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    let blueComponent = customColor.blueComponent

    XCTAssert(blueComponent == 0.32, "Color blue component should be equal to 0.32")
  }

  func testAlphaComponent() {
    let customColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 0.8)

    let alphaComponent = customColor.alphaComponent

    XCTAssert(alphaComponent == 0.8, "Color alpha component should be equal to 0.8")
  }

  func testAdjustedAlphaColor() {
    let customColor = DynamicColor(red: 0.23, green: 0.46, blue: 0.32, alpha: 1)

    XCTAssert(customColor.alphaComponent == 1, "Color alpha component should be equal to 1")

    let adjustedAlpha1 = customColor.adjustedAlpha(amount: -0.5)

    XCTAssert(adjustedAlpha1.alphaComponent == 0.5, "Color alpha component should be equal to 0.5")

    let adjustedAlpha2 = adjustedAlpha1.adjustedAlpha(amount: 0.2)

    XCTAssert(adjustedAlpha2.alphaComponent == 0.7, "Color alpha component should be equal to 0.7")

    let adjustedAlpha3 = adjustedAlpha2.adjustedAlpha(amount: -1)

    XCTAssert(adjustedAlpha3.alphaComponent == 0, "Color alpha component should be equal to 0")

    let adjustedAlpha4 = adjustedAlpha3.adjustedAlpha(amount: 23)

    XCTAssert(adjustedAlpha4.alphaComponent == 1, "Color alpha component should be equal to 1")
  }
}
