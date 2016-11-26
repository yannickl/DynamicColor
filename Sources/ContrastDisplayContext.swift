//
//  ContrastDisplayContext.swift
//  DynamicColorExample
//
//  Created by Yannick LORIOT on 26/11/2016.
//  Copyright © 2016 Yannick LORIOT. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif

extension DynamicColor {
  /**
   Used to describe the context of display of 2 colors.

   Based on WCAG: https://www.w3.org/TR/2008/REC-WCAG20-20081211/#visual-audio-contrast-contrast
   */
  public enum ContrastDisplayContext {
    /**
     A standard text in a normal context.
     */
    case standard
    /**
     A large text in a normal context.
     You can look here for the definition of "large text":
     https://www.w3.org/TR/2008/REC-WCAG20-20081211/#larger-scaledef
     */
    case standardLargeText
    /**
     A standard text in an enhanced context.
     Enhanced means that you want to be accessible (and AAA compliant in WCAG)
     */
    case enhanced
    /**
     A large text in an enhanced context.
     Enhanced means that you want to be accessible (and AAA compliant in WCAG)
     You can look here for the definition of "large text":
     https://www.w3.org/TR/2008/REC-WCAG20-20081211/#larger-scaledef
     */
    case enhancedLargeText

    var minimumContrastRatio: CGFloat {
      switch self {
      case .standard:
        return 4.5
      case .standardLargeText:
        return 3
      case .enhanced:
        return 7
      case .enhancedLargeText:
        return 4.5
      }
    }
  }
}
