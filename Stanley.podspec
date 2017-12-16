Pod::Spec.new do |s|
  s.name             = 'Stanley'
  s.version          = '1.7.5'
  s.summary          = 'Stanley is an iOS/macOS/tvOS/watchOS framework that extends the Foundation framework.'

  s.description      = <<-DESC
Stanley is an iOS/macOS/tvOS/watchOS framework that extends the `Foundation` framework. It includes a number of macros, functions, categories and classes that make repetitive tasks easier. It provides a localized phone number formatter. It also provides a wrapper around the SCNetworkReachability APIs, KSTReachabilityManager.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/Stanley'
  s.license          = { :type => 'BSD', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/Stanley.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  
  s.requires_arc = true

  s.source_files = 'Stanley/**/*.{h,m}'
  s.exclude_files = 'Stanley/Stanley-Info.h'
  s.private_header_files = 'Stanley/Private/*.h'
  s.ios.exclude_files = 'Stanley/macOS'
  s.osx.exclude_files = 'Stanley/iOS'
  s.tvos.exclude_files = 'Stanley/macOS'
  s.watchos.exclude_files = 'Stanley/macOS', 'Stanley/KSTReachabilityManager.{h,m}'
  
  s.resource_bundles = {
    'Stanley' => ['Stanley/**/*.{xcassets,lproj}']
  }

  s.ios.frameworks = 'Foundation', 'SystemConfiguration'
  s.osx.frameworks = 'Foundation', 'SystemConfiguration'
  s.tvos.frameworks = 'Foundation', 'SystemConfiguration'
  s.watchos.frameworks = 'Foundation'
end
