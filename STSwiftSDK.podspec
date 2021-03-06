#
# Be sure to run `pod lib lint fansPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'STSwiftSDK'
  s.version          = '0.0.2'
  s.summary          = 'StarkTeam swift SDK kit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Thinkerfan/STSwiftSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thinkerfan' => '731666148@qq.com' }
  s.source           = { :git => 'https://github.com/Thinkerfan/STSwiftSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  s.ios.deployment_target = '10.0'
  s.source_files = 'STSwiftSDK/Classes/**/*'
  s.swift_version = '4.2'  
  # s.resource_bundles = {
  #   'fansPod' => ['fansPod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'MBProgressHUD'
   s.dependency 'MBProgressHUD'
   s.dependency 'Alamofire'

end
