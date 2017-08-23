#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Stanley'
  s.version          = '0.12.1'
  s.summary          = 'Stanley is an iOS/macOS/tvOS/watchOS framework that extends the Foundation framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Stanley is an iOS/macOS/tvOS/watchOS framework that extends the `Foundation` framework. It includes a number of macros, functions, categories and classes that make repetitive tasks easier.
                       DESC

  s.homepage         = 'https://github.com/Kosoku/Stanley'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'license.txt' }
  s.author           = { 'William Towe' => 'willbur1984@gmail.com' }
  s.source           = { :git => 'https://github.com/Kosoku/Stanley.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

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
  s.watchos.exclude_files = 'Stanley/macOS'
  
  s.resource_bundles = {
    'Stanley' => ['Stanley/**/*.{xcassets,lproj}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
