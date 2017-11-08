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

let TestsAcceptedAccuracy = CGFloat(0.000001)

class DynamicColorHSBTests: XCTestCase {
  func testToHSBComponents() {
    let customColor = DynamicColor(hue: 0.1, saturation: 0.3, brightness: 0.5, alpha: 1)
    let hsb         = customColor.toHSBComponents()

    
    XCTAssertEqual(hsb.h, 0.1, accuracy: TestsAcceptedAccuracy, "Color hue component should be equal to 0.1 (not \(hsb.h))")
    XCTAssertEqual(hsb.s, 0.3, accuracy: TestsAcceptedAccuracy, "Saturation component should be equal to 0.3 (not \(hsb.s))")
    XCTAssertEqual(hsb.b, 0.5, accuracy: TestsAcceptedAccuracy, "Brightness component should be equal to 0.3 (not \(hsb.b))")

    let blackHSB = DynamicColor.black.toHSBComponents()
    
    XCTAssertEqual(blackHSB.h, 0, accuracy: TestsAcceptedAccuracy, "Color hue component should be equal to 0 (not \(blackHSB.h))")
    XCTAssertEqual(blackHSB.s, 0, accuracy: TestsAcceptedAccuracy, "Saturation component should be equal to 0 (not \(blackHSB.s))")
    XCTAssertEqual(blackHSB.b, 0, accuracy: TestsAcceptedAccuracy, "Brightness component should be equal to 0 (not \(blackHSB.b))")

    let whiteHSB = DynamicColor.white.toHSBComponents()
    
    XCTAssertEqual(whiteHSB.h, 0, accuracy: TestsAcceptedAccuracy, "Color hue component should be equal to O (not \(whiteHSB.h))")
    XCTAssertEqual(whiteHSB.s, 0, accuracy: TestsAcceptedAccuracy, "Saturation component should be equal to 0 (not \(blackHSB.s))")
    XCTAssertEqual(whiteHSB.b, 1, accuracy: TestsAcceptedAccuracy, "Brightness component should be equal to 1 (not \(whiteHSB.b))")

  
    let redHSB = DynamicColor.red.toHSBComponents()

    XCTAssert(redHSB.h == 1 || redHSB.h == 0, "Color hue component should be equal to 1 or 0 (not \(redHSB.h))")
    XCTAssert(redHSB.s == 1, "Saturation component should be equal to 1 (not \(redHSB.s))")
    XCTAssert(redHSB.b == 1, "Brightness component should be equal to 1 (not \(redHSB.b))")
  }

  func testHueComponent() {
    let redHue = DynamicColor.red.hueComponent

    XCTAssert(redHue == 1 || redHue == 0, "Color hue component should be equal to 1 or 0 (not \(redHue))")

    let blackHue = DynamicColor(r: 0, g: 0, b: 0).hueComponent

    XCTAssert(blackHue == 0, "Color hue component should be equal to 0 (not \(blackHue))")
  }

  func testSaturationComponent() {
    let redSaturation = DynamicColor.red.saturationComponent

    XCTAssert(redSaturation == 1 || redSaturation == 0, "Color saturation component should be equal to 1 or 0 (not \(redSaturation))")

    let blackSaturation = DynamicColor(r: 0, g: 0, b: 0).saturationComponent

    XCTAssert(blackSaturation == 0, "Color saturation component should be equal to 0 (not \(blackSaturation))")
  }

  func testBrightnessComponent() {
    let redBrightness = DynamicColor.red.brightnessComponent

    XCTAssert(redBrightness == 1 || redBrightness == 0, "Color brightness component should be equal to 1 or 0 (not \(redBrightness))")

    let blackBrightness = DynamicColor(r: 0, g: 0, b: 0).brightnessComponent

    XCTAssert(blackBrightness == 0, "Color brightness component should be equal to 0 (not \(blackBrightness))")
  }
}
