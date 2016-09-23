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

class DynamicColorArrayTests: XCTestCase {
  func testGradientProperty() {
    let colors: [DynamicColor] = []

    XCTAssertNotNil(colors.gradient)
  }
  
  func testColors() {
    let colors = [#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)].gradient.colorPalette(amount: 5)

    XCTAssert(colors[0].isEqual(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), "Should be red")
    XCTAssert(colors[1].isEqual(DynamicColor(red: 0.5, green: 0.5, blue: 0, alpha: 1)), "Should be kaki")
    XCTAssert(colors[2].isEqual(#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)), "Should be green")
    XCTAssert(colors[3].isEqual(DynamicColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)), "Should be purple")
    XCTAssert(colors[4].isEqual(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)), "Should be blue")
  }

  func testColorAt() {
    let emptyColors = Array<DynamicColor>().gradient

    XCTAssert(emptyColors.pickColorAt(scale: 0.25).isEqual(toHex: 0x00000), "Should be black")

    let oneColor = [#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)].gradient

    XCTAssert(oneColor.pickColorAt(scale: 0.75).isEqual(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), "Should be red")

    let primaryColors = [#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)].gradient

    let red = primaryColors.pickColorAt(scale: 0)
    XCTAssert(red.isEqual(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), "Should be red")

    let clippedRed = primaryColors.pickColorAt(scale: -7.9)
    XCTAssert(clippedRed.isEqual(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), "Should be red")

    let blue = primaryColors.pickColorAt(scale: 1)
    XCTAssert(blue.isEqual(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)), "Should be blue")

    let clippedBlue = primaryColors.pickColorAt(scale: 34)
    XCTAssert(clippedBlue.isEqual(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)), "Should be blue")

    let kaki = primaryColors.pickColorAt(scale: 0.25)
    XCTAssert(kaki.toRGBAComponents() == (r: 0.5, g: 0.5, b: 0, a: 1), "Should be kaki (not \(kaki))")

    let green = primaryColors.pickColorAt(scale: 0.65)
    XCTAssert(green.toRGBAComponents().r == 0, "Should be green (not \(green.toRGBAComponents()))")
    XCTAssert(green.toRGBAComponents().g == 0.7, "Should be green (not \(green.toRGBAComponents()))")
    XCTAssert(round(green.toRGBAComponents().b * 10) == 3, "Should be green (not \(green.toRGBAComponents().b))")
    XCTAssert(green.toRGBAComponents().a == 1, "Should be green (not \(green.toRGBAComponents()))")
  }
}
