Pod::Spec.new do |s|
  s.name             = 'DynamicColor'
  s.version          = '1.5.2'
  s.license          = 'MIT'
  s.summary          = 'Yet another extension to manipulate colors easily in Swift'
  s.homepage         = 'https://github.com/yannickl/DynamicColor.git'
  s.social_media_url = 'https://twitter.com/yannickloriot'
  s.authors          = { 'Yannick Loriot' => 'contact@yannickloriot.com' }
  s.source           = { :git => 'https://github.com/yannickl/DynamicColor.git', :tag => s.version }
  s.screenshot       = 'http://yannickloriot.com/resources/dynamiccolor-sample-screenshot.png'

  s.ios.deployment_target = '8.0'

  s.framework    = 'UIKit'
  s.source_files = 'DynamicColor/*.swift'
  s.requires_arc = true
end
