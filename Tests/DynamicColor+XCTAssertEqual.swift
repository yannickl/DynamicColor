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

func XCTAssertEqual(_ expression1: @autoclosure () throws -> DynamicColor, _ expression2: @autoclosure () throws -> DynamicColor, accuracy: CGFloat, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {

    let message = message()

    do {
        let (color1, color2) = (try expression1(), try expression2())

        let (r1, g1, b1, a1) = color1.toRGBAComponents()
        let (r2, g2, b2, a2) = color2.toRGBAComponents()

        XCTAssertEqual(r1, r2, accuracy: accuracy, message, file: file, line: line)
        XCTAssertEqual(g1, g2, accuracy: accuracy, message, file: file, line: line)
        XCTAssertEqual(b1, b2, accuracy: accuracy, message, file: file, line: line)
        XCTAssertEqual(a1, a2, accuracy: accuracy, message, file: file, line: line)
    } catch let error {
        XCTFail("\(error)", file: file, line: line)
    }
}
