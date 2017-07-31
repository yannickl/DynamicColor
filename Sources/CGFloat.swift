//
//  CGFloat.swift
//  DynamicColorExample
//
//  Created by Guillaume BITAUDEAU on 31/07/2017.
//  Copyright © 2017 Yannick LORIOT. All rights reserved.
//

import Foundation


/**
 Convenient extension for working with radiant angles DynamicGradient.
 */
public extension CGFloat {
    /**
     Normalize a angle in radian between [-CGFloat.pi, CGFloat.pi]
     */
    public func normalizeAngle() -> CGFloat {
        let result = self.truncatingRemainder(dividingBy: 2.0 * CGFloat.pi)
        if result < -CGFloat.pi {
            return result + 2.0 * CGFloat.pi
        } else if result > CGFloat.pi {
            return result - 2.0 * CGFloat.pi
        }
        
        return result
    }
}
