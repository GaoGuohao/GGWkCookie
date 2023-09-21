#
# Be sure to run `pod lib lint GGWkCookie.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GGWkCookie'
  s.version          = '0.1.3'
  s.summary          = '解决 WKWebView cookie 设置难题'

#s.description      = <<-DESC
#   解决 WKWebView cookie 设置难题。
#                      DESC

  s.homepage         = 'https://github.com/gaoguohao/GGWkCookie'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaoguohao' => 'guohaoggh@163.com' }
  s.source           = { :git => 'https://github.com/gaoguohao/GGWkCookie.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GGWkCookie/Classes/**/*'
  
  s.resource_bundles = {
    'GGWkCookie' => ['GGWkCookie/Assets/*']
  }

#  s.public_header_files = 'GGWkCookie/Classes/GGWkCookie.h'
  s.frameworks = 'WebKit'
end
