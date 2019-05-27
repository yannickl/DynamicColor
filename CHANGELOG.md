# Change log

## [Version 4.1.0](https://github.com/yannickl/DynamicColor/releases/tag/4.1.0)
*Released on 2019-05-27.*

- Minor improvements (compilation performance, documentation)
- Swift 5/Xcode 10 support

## [Version 4](https://github.com/yannickl/DynamicColor/releases/tag/4)
*Released on 2017-11-07.*

- Minor improvements (compilation performance, documentation)
- Swift 4/Xcode 9 support

## [Version 3.3](https://github.com/yannickl/DynamicColor/releases/tag/3.3)
*Released on 2017-04-15.*

- [ADD] Support alpha channel with the hex strings (e.g. #FF0934CC)

## [Version 3.2.1](https://github.com/yannickl/DynamicColor/releases/tag/3.2.1)
*Released on 2016-12-15.*

- [FIX] `mixed` method with the alpha channel

## [Version 3.2.0](https://github.com/yannickl/DynamicColor/releases/tag/3.2.0)
*Released on 2016-12-12.*

- [ADD] `luminance` property
- [ADD] `contrastRatio` method
- [ADD] `isContrasting` method

## [Version 3.1.0](https://github.com/yannickl/DynamicColor/releases/tag/3.1.0)
*Released on 2016-09-08.*

- [ADD] CIE XYZ Color Space
- Initialization with XYZ components
- `toXYZComponents()` method
- [ADD] CIE L*a*b* Color Space
- Initialization with L*a*b* components
- `toLabComponents()` method
- `toHSBComponents()` method
- [REFACTORING] `toHSLAComponents` to `toHSLComponents`
- [REFACTORING] Hue range is now from 0° and 360° instead of 0.0 and 1.0
- [ADD] `DynamicGradient` object
- [ADD] `colorPalette` method to a gradient
- [ADD] `pickColorAt` method to a gradient
- [ADD] `gradient` property to array of colors
- [ADD] `DynamicColorSpace` enum
- [REFACTORING] `mixed` colors using different color spaces

## [Version 3.0.0](https://github.com/yannickl/DynamicColor/releases/tag/3.0.0)
*Released on 2016-06-14.*

- Swift 3 Supports
- `isLight` instead of `isLightColor`
- `adjustedAlpha` instead of `adjustedAlphaColor`
- `inverted` instead of `invertColor`
- `grayscaled` instead of `grayscaledColor`
- `darkened` instead of `darkerColor`
- `lighter` instead of `lighterColor`
- `saturated` instead of `saturatedColor`
- `desaturated` instead of `desaturatedColor`
- `complemented` instead of `complementColor`
- `adjustedHue` instead of `adjustedHueColor`
- `tinted` instead of `tintColor`
- `shaded` instead of `shadeColor`
- `mixed` instead of `mixWithColor`
- `isEqual:toHex` instead of `isEqualToHex`
- `isEqual:toHexString` instead of `isEqualToHexString`
- Removing the `darkenColor`, use `darkened` instead
- Removing the `lightenColor`, use `lighter` instead
- Removing the `saturateColor`, use `saturated` instead
- Removing the `desaturateColor`, use `desaturated` instead
- Use `CGFloat` instead of `Double` everywhere

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
