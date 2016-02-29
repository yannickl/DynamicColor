# Change log

## [Version 2.4.0](https://github.com/yannickl/DynamicColor/releases/tag/2.4.0)
*Released on 2016-02-29.*

- [ADD] Swift Package Manager supports

## [Version 2.3.0](https://github.com/yannickl/DynamicColor/releases/tag/2.3.0)
*Released on 2015-12-12.*

- [ADD] `adjustedAlphaColor` method
- [REFACTORING] Move `redComponent/greenComponent/blueComponent/alphaComponent` methods to properties in order to reflect the OSX API

## [Version 2.2.0](https://github.com/yannickl/DynamicColor/releases/tag/2.2.0)
*Released on 2015-11-19.*

- [ADD] `isLightColor` method
- [REFACTORING] `red/green/blue/alpha` methods to `redComponent/greenComponent/blueComponent/alphaComponent`
- [ADD] OSX supports

## [Version 2.1.0](https://github.com/yannickl/DynamicColor/releases/tag/2.1.0)
*Released on 2015-10-29.*

- [ADD] WatchOS 2 supports
- [ADD] TVOS 9 supports

## [Version 2.0.1](https://github.com/yannickl/DynamicColor/releases/tag/2.0.1)
*Released on 2015-10-26.*

- [FIX] BITCODE supports ([#6](https://github.com/yannickl/DynamicColor/pull/6))

## [Version 2.0.0](https://github.com/yannickl/DynamicColor/releases/tag/2.0.0)
*Released on 2015-09-17.*

- [UPDATE] Swift 2 compatibility
- [FIX] Use Double instead of CGFloat due to float precision

## [Version 1.5.4](https://github.com/yannickl/DynamicColor/releases/tag/1.5.4)
*Released on 2015-09-01.*

- [FIX] Mandatory clip parameters for Xcode7 beta 6 ([#5](https://github.com/yannickl/DynamicColor/pull/5))

## [Version 1.5.3](https://github.com/yannickl/DynamicColor/releases/tag/1.5.3)
*Released on 2015-08-29.*

- [UPDATE] Make the DynamicColor typealias public

## [Version 1.5.2](https://github.com/yannickl/DynamicColor/releases/tag/1.5.2)
Released on 2015-08-27.

- [ADD] Changelog.md file

## [Version 1.5.1](https://github.com/yannickl/DynamicColor/releases/tag/1.5.1)
*Released on 2015-07-29.*

- [FIX] Project framework target sets to 8.0 for Carthage support ([#4](https://github.com/yannickl/DynamicColor/pull/4))

## [Version 1.5.0](https://github.com/yannickl/DynamicColor/releases/tag/1.5.0)
*Released on 2015-07-28.*

- [ADD] Initialization with hue
- [ADD] `toHSLAComponents` method

## [Version 1.4.0](https://github.com/yannickl/DynamicColor/releases/tag/1.4.0)
*Released on 2015-07-24.*

- [ADD] `toHex` method
- [ADD] `isEqualToHex` method

## [Version 1.3.0](https://github.com/yannickl/DynamicColor/releases/tag/1.3.0)
*Released on 2015-07-09.*

- [UPDATE] Documentation
- [FIX] Some var to let ([#3](https://github.com/yannickl/DynamicColor/pull/3))
- [ADD] `toComponents` method
- [ADD] `red/green/blue/alpha` methods

## [Version 1.2.0](https://github.com/yannickl/DynamicColor/releases/tag/1.2.0)
*Released on 2015-06-12.*

- [ADD] Carthage support

## [Version 1.1.1](https://github.com/yannickl/DynamicColor/releases/tag/1.1.1)
*Released on 2015-06-10.*

- [FIX] Typos in the documentation ([#1](https://github.com/yannickl/DynamicColor/pull/1))
- [IMPROVEMENT] Check interval for parameter

## [Version 1.1.0](https://github.com/yannickl/DynamicColor/releases/tag/1.1.0)
*Released on 2015-06-06.*

- [ADD] `shadeColor` method
- [ADD] `tintColor` method
- [ADD] `mixWithColor` method

## [Version 1.0.0](https://github.com/yannickl/DynamicColor/releases/tag/1.0.0)
*Released on 2015-06-02.*

- `saturated` method
- `desaturate` method
- `lighter/lighten` methods
- `darker/darken` methods
- `grayscale` method
- `adjustHue` method
- `complementColor` method
- `invertColor` method
- `toHexString` method
- `isEqualToHexString` method
- Initialization with hex strings and integers
- Cocoapods support
