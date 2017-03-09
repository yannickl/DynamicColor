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

class DynamicGradientTests: XCTestCase {
  func testColorPalette() {
    XCTAssertEqual(DynamicGradient(colors: []).colorPalette(amount: 0).count, 0)
    XCTAssertEqual(DynamicGradient(colors: []).colorPalette(amount: 99).count, 0)
    XCTAssertEqual(DynamicGradient(colors: [.red, .green, .blue]).colorPalette(amount: 0).count, 0)
    XCTAssertEqual(DynamicGradient(colors: [.red]).colorPalette(amount: 10).count, 10)
    XCTAssertEqual(DynamicGradient(colors: [.red]).colorPalette(amount: 10), (0 ..< 10).map({ _ in return .red }))
  }

  func testPickColorAtScale() {
    let yellow = [.red, .yellow, .green].gradient.pickColorAt(scale: 0.5)

    XCTAssert(yellow.toHex() == 0xffff00, "Color should be yellow (not \(yellow.toHexString()))")

    let red = [.red, .yellow, .green].gradient.pickColorAt(scale: 0)

    XCTAssert(red.toHex() == 0xff0000, "Color should be red (not \(red.toHexString()))")

    let green = [.red, .yellow, .green].gradient.pickColorAt(scale: 1)

    XCTAssert(green.toHex() == 0x00ff00, "Color should be green (not \(green.toHexString()))")

    let darkYellow = [.red, .green].gradient.pickColorAt(scale: 0.5)

    XCTAssert(darkYellow.toHex() == 0x808000, "Color should be a dark yellow (not \(darkYellow.toHexString()))")
  }
}
