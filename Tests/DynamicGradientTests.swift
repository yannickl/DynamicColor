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
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    
    func testLinearImage() {
        let rainbow = [.red, .green, .blue, .red].gradient
        
        let linearRainbowImage = rainbow.linearImage(withSize: CGSize(width:100, height:100), startPoint: CGPoint.zero, endPoint: CGPoint(x: 1.0, y: 1.0), inColorSpace:.hsl)
        
        XCTAssertNotNil(linearRainbowImage, "Rainbow should produce an linear image")
        
        let linearData = UIImagePNGRepresentation(linearRainbowImage!)
        XCTAssertNotNil(linearData, "Linear image should produce PNG datas")
        //try? linearData?.write(to: URL(fileURLWithPath: "/tmp/linearRainbowImage.png"))
        
        let bundle = Bundle(for: type(of: self))
        guard let refLinearUrl = bundle.url(forResource: "linearRainbowImage.png", withExtension: "ref"),
            let refLinearData = try? Data(contentsOf: refLinearUrl) else {
                XCTFail("Ref linear image should exists")
                return
        }
        
        XCTAssert(linearData! == refLinearData, "Linear image should be similar to reference")
    }
    
    
    func testAngularImage() {
        let rainbow = [.red, .green, .blue, .red].gradient
        
        let angularRainbowImage = rainbow.angularImage(withSize: CGSize(width:100, height:100), radius: 50, startAngle: 0, endAngle: 0, clockwise: true, inColorSpace:.hsl)

        XCTAssertNotNil(angularRainbowImage, "Rainbow should produce an angular image")
        
        let angularData = UIImagePNGRepresentation(angularRainbowImage!)
        XCTAssertNotNil(angularData, "Angular image should produce PNG datas")
        //try? angularData?.write(to: URL(fileURLWithPath: "/tmp/angularRainbowImage.png"))
        
        let bundle = Bundle(for: type(of: self))
        guard let refAngularUrl = bundle.url(forResource: "angularRainbowImage.png", withExtension: "ref"),
            let refAngularData = try? Data(contentsOf: refAngularUrl) else {
                XCTFail("Ref angular image should exists")
                return
        }
        
        XCTAssert(angularData! == refAngularData, "Angular image should be similar to reference")
    }
    
    
    
    #endif
}
