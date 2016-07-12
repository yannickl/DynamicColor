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

class DynamicColorHSLTests: XCTTestCaseTemplate {
  func testInitWithHSLComponents() {
    let black1 = DynamicColor(hue: 0, saturation: 0, lightness: 0)
    let black2 = DynamicColor(hue: 1, saturation: 1, lightness: 0)
    let white1 = DynamicColor(hue: 0, saturation: 0, lightness: 1)
    let white2 = DynamicColor(hue: 1, saturation: 1, lightness: 1)

    let red   = DynamicColor(hue: 0, saturation: 1, lightness: 0.5)
    let green = DynamicColor(hue: 120 / 360, saturation: 1, lightness: 0.5)
    let blue  = DynamicColor(hue: 240 / 360, saturation: 1, lightness: 0.5)

    let custom = DynamicColor(hue: 6 / 360, saturation: 0.781, lightness: 0.571)

    XCTAssert(black1.toHex() == 0, "Color should be black")
    XCTAssert(black2.toHex() == 0, "Color should be black")
    XCTAssert(white1.toHex() == 0xffffff, "Color should be white")
    XCTAssert(white2.toHex() == 0xffffff, "Color should be white")

    XCTAssert(red.isEqualToHexString(DynamicColor.red().toHexString()), "Color should be red")
    XCTAssert(green.isEqualToHexString(DynamicColor.green().toHexString()), "Color should be green")
    XCTAssert(blue.isEqualToHexString(DynamicColor.blue().toHexString()), "Color should be blue")

    XCTAssert(custom.isEqualToHexString("#e74d3c"), "Color should be equal to #e74d3c")
  }

  func testToHSLComponents() {
    let customColor = DynamicColor(hue: 6 / 360, saturation: 0.781, lightness: 0.571)
    let hsl         = customColor.toHSLComponents()

    XCTAssert(round(hsl.h * 1000) == round(6.0 / 360 * 1000), "Color hue component should be equal to 6 / 360")
    XCTAssert(round(hsl.s * 1000) == round(0.781 * 1000), "Color saturation component should be equal to 0.781")
    XCTAssert(hsl.l == 0.571, "Color lightness component should be equal to 0.571")
  }
}
