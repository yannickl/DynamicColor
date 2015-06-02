![DynamicColor](http://yannickloriot.com/resources/dynamiccolor-header.png)

[![Supported Plateforms](https://cocoapod-badges.herokuapp.com/p/DynamicColor/badge.svg)](http://cocoadocs.org/docsets/DynamicColor/) [![Version](https://cocoapod-badges.herokuapp.com/v/DynamicColor/badge.svg)](http://cocoadocs.org/docsets/DynamicColor/) [![Build Status](https://travis-ci.org/yannickl/DynamicColor.png?branch=master)](https://travis-ci.org/yannickl/DynamicColor)

DynamicColor provides powerfull methods to manipulate colors in an easy way.

## Usage

### Darken & Lighten

### Saturate, & Desaturate

### Adjust-hue

### Grayscale

### Invert

```swift
```

To go further, take a look at the example project. 

## Installation

#### CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _DynamicColor_:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

use_frameworks!
pod 'SnappingStepper', '~> 1.0.0'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import DynamicColor` framework into your files.

#### Manually

[Download](https://github.com/YannickL/DynamicColor/archive/master.zip) the project and copy the `DynamicColor` folder into your project to use it in.
    
## Contact

Yannick Loriot
 - [https://twitter.com/yannickloriot](https://twitter.com/yannickloriot)
 - [contact@yannickloriot.com](mailto:contact@yannickloriot.com)


## License (MIT)

Copyright (c) 2015-present - Yannick Loriot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
