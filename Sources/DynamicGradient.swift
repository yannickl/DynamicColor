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

/**
 Object representing a gradient object. It allows you to manipulate colors inside different gradients and color spaces.
 */
final public class DynamicGradient {
  let colors: [DynamicColor]

  /**
   Initializes and creates a gradient from a color array.

   - Parameter colors: An array of colors.
   */
  public init(colors: [DynamicColor]) {
    self.colors = colors
  }

  /**
   Returns the color palette of `amount` elements by grabbing equidistant colors.

   - Parameter amount: An amount of colors to return. 2 by default.
   - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
   - Returns: An array of DynamicColor objects with equi-distant space in the gradient.
   */
  public func colorPalette(amount: UInt = 2, inColorSpace colorspace: DynamicColorSpace = .rgb) -> [DynamicColor] {
    guard amount > 0 && colors.count > 0 else {
      return []
    }

    guard colors.count > 1 else {
      return (0 ..< amount).map { _ in colors[0] }
    }

    let increment = 1 / CGFloat(amount - 1)

    return (0 ..< amount).map { pickColorAt(scale: CGFloat($0) * increment, inColorSpace: colorspace) }
  }

  /**
   Picks up and returns the color at the given scale by interpolating the colors.

   For example, given this color array `[red, green, blue]` and a scale of `0.25` you will get a kaki color.

   - Parameter scale: A float value between 0.0 and 1.0.
   - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
   - Returns: A DynamicColor object corresponding to the color at the given scale.
   */
  public func pickColorAt(scale: CGFloat, inColorSpace colorspace: DynamicColorSpace = .rgb) -> DynamicColor {
    guard colors.count > 1 else {
      return colors.first ?? .black
    }

    let clippedScale = clip(scale, 0, 1)
    let positions    = (0 ..< colors.count).map { CGFloat($0) / CGFloat(colors.count - 1) }

    var color: DynamicColor = .black

    for (index, position) in positions.enumerated() {
      guard clippedScale <= position else { continue }

      guard clippedScale != 0 && clippedScale != 1 else {
        return colors[index]
      }

      let previousPosition = positions[index - 1]
      let weight           = (clippedScale - previousPosition) / (position - previousPosition)

      color = colors[index - 1].mixed(withColor: colors[index], weight: weight, inColorSpace: colorspace)

      break
    }

    return color
  }
    
    
    /**
     Return a boolean value which indicates if the current gradient is opaque, which means that all colors of this gradient are opaque.
     
     - returns: true if this gradient is opaque, false otherwise
     */
    public var isOpaque: Bool {
        for color in self.colors {
            if !color.isOpaque {
                return false
            }
        }
        return true
    }
    
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    
    /**
     Create a image using this gradient as a linear gradient.
     
     - parameter size: The size in point of the resulting image. The number of pixel depends of the scale factor of the device’s main screen.
     - parameter startPoint: The start point corresponds to the first stop of the gradient. The point is defined in the unit coordinate space and is then mapped to the image’s bounds rectangle when drawn. Indicates (0.0,0.0) for top left and (1.0,1.0) for bottom right.
     - parameter endPoint: The end point corresponds to the last stop of the gradient. The point is defined in the unit coordinate space and is then mapped to the image’s bounds rectangle when drawn. Indicates (0.0,0.0) for top left and (1.0,1.0) for bottom right.
     - parameter nbSteps: The number of step use to mix color using given colorspace. Use default value to use an automatic number of steps. In colorspace other than rgb, bigger numbers can give more accurate results.
     - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
     - returns: the created UIImage containing the gradient
     */
    public func linearImage(withSize size:CGSize, startPoint:CGPoint, endPoint:CGPoint, numberOfSteps nbSteps:Int = 0, inColorSpace colorspace: DynamicColorSpace = .rgb) -> UIImage? {
        
        let finalNbSteps:Int
        if nbSteps == 0 {
            if colorspace == .rgb {
                //let CAGradientLayer do the job!
                finalNbSteps = colors.count
            } else {
                //arbitrary use the size to compute a not too bad nbSteps
                finalNbSteps = Int(ceil(sqrt(size.width * size.height)))
            }
        } else {
            finalNbSteps = nbSteps
        }
        
        guard finalNbSteps > 1 else {
            return nil
        }
        
        let convertedColors:[CGColor] = (0..<finalNbSteps).map {
            (i) -> CGColor in
            let color = self.pickColorAt(scale: CGFloat (i)/CGFloat (finalNbSteps - 1), inColorSpace: colorspace)
            return color.cgColor
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect (origin: CGPoint.zero, size: size)
        gradientLayer.colors = convertedColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.contentsScale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        gradientLayer.render (in: context)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    /**
     Create a image using this gradient as a angular gradient.
     Draw an arc using radius, startAngle, endAngle and clockwise. The center of the arcs is the center of the image. The arc is filled with "nbSteps" smaller arcs. Each smaller arc have a different interpolating color mix using the given colorspace.
     
     - parameter size: The size in point of the resulting image. The number of pixel depends of the scale factor of the device’s main screen.
     - parameter radius: Specifies the radius of the circle used to define the arc.
     - parameter startAngle: Specifies the starting angle of the arc (measured in radians).
     - parameter endAngle: Specifies the end angle of the arc (measured in radians).
     - parameter nbSteps: The number of step use to mix color using given colorspace. Bigger numbers can give more accurate results.
     - Parameter colorspace: The color space used to mix the colors. By default it uses the RBG color space.
     - returns: the created UIImage containing the gradient
     */
    public func angularImage(withSize size:CGSize, radius:CGFloat, startAngle:CGFloat, endAngle:CGFloat, clockwise:Bool, numberOfSteps nbSteps:Int = 360, inColorSpace colorspace: DynamicColorSpace = .rgb) -> UIImage? {
        
        guard nbSteps > 1 else {
            return nil
        }
        
        let center = CGPoint (x: size.width / 2.0, y: size.height / 2.0)
        
        let convertedColors:[CGColor] = (0..<nbSteps).map {
            (i) -> CGColor in
            let color = self.pickColorAt(scale: CGFloat (i)/CGFloat (nbSteps - 1), inColorSpace: colorspace)
            return color.cgColor
        }
        
        
        let normalizedStart = startAngle.normalizeAngle()
        let normalizedEnd = endAngle.normalizeAngle()
        
        var stepAngle:CGFloat
        if clockwise {
            stepAngle = normalizedEnd - normalizedStart
            if normalizedEnd <= normalizedStart {
                stepAngle = stepAngle + CGFloat.pi * 2.0
            }
        } else {
            stepAngle = normalizedEnd - normalizedStart
            if normalizedEnd >= normalizedStart {
                stepAngle = stepAngle - CGFloat.pi * 2.0
            }
        }
        stepAngle = stepAngle / CGFloat(nbSteps - 1)
        
        
        UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        for i in (1..<nbSteps) {
            let color = convertedColors[i]
            
            let bezierPath = UIBezierPath(arcCenter:center, radius:radius, startAngle:CGFloat(i) * stepAngle + normalizedStart, endAngle:CGFloat(i + 1) * stepAngle + normalizedStart, clockwise:clockwise)
            bezierPath.addLine(to: center)
            bezierPath.close()
            
            context.setFillColor(color)
            context.setStrokeColor(color)
            bezierPath.fill()
            bezierPath.stroke()
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    #endif
}
