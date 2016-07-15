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

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif

import Foundation

public extension Array where Element: DynamicColor {
  /**
   Grab `amount` equi-distant colors from a color scale.
  */
  /*public func colors(amount: UInt = 2) -> [DynamicColor] {
    guard amount > 0 && self.count > 0 else {
      return []
    }

    guard self.count > 1 else {
      return (0 ..< amount).map { _ in self[0] }
    }

    for i in 0 ..< amount {
      p = _pos[i]
      if t <= p
      col = _colors[i]
      break
      if t >= p and i == _pos.length-1
      col = _colors[i]
      break
      if t > p and t < _pos[i+1]
      t = (t-p)/(_pos[i+1]-p)
      col = chroma.interpolate _colors[i], _colors[i+1], t, _mode
      break
    }

    return self
  }*/

  public func colorAt(percent: CGFloat) -> DynamicColor {
    guard self.count > 0 else {
      return .black()
    }

    guard self.count > 1 else {
      return first!
    }

    let clippedPercent = clip(percent, 0, 1)
    let positions      = (0 ..< count).map { CGFloat($0) / CGFloat(count - 1) }

    for (index, position) in positions.enumerated() {
      if clippedPercent <= position {
        guard clippedPercent != 0 && clippedPercent != 1 else {
          return self[index]
        }

        let previousPosition = positions[index - 1]
        let weight           = (clippedPercent - previousPosition) / (position - previousPosition)

        return self[index - 1].mixed(color: self[index], weight: weight)
      }
    }

    return .black()
  }
}
