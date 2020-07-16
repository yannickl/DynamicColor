Pod::Spec.new do |s|
  s.name             = 'DynamicColor'
  s.version          = '5.0.1'
  s.license          = 'MIT'
  s.swift_version    = ['5.0', '5.1']
  s.summary          = 'Yet another extension to manipulate colors easily in Swift (UIColor, NSColor and SwiftUI)'
  s.homepage         = 'https://github.com/yannickl/DynamicColor.git'
  s.social_media_url = 'https://twitter.com/yannickloriot'
  s.authors          = { 'Yannick Loriot' => 'contact@yannickloriot.com' }
  s.source           = { :git => 'https://github.com/yannickl/DynamicColor.git', :tag => s.version }
  s.screenshot       = 'http://yannickloriot.com/resources/dynamiccolor-sample-screenshot.png'

  s.ios.deployment_target     = '11.0'
  s.osx.deployment_target     = '10.11'
  s.tvos.deployment_target    = '11.0'
  s.watchos.deployment_target = '4.0'

  s.ios.framework     = 'UIKit'
  s.osx.framework     = 'AppKit'
  s.tvos.framework    = 'UIKit'
  s.watchos.framework = 'UIKit'

  s.source_files = 'Sources/**/*.swift'
  s.requires_arc = true
end
