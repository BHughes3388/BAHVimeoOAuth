#
# Be sure to run `pod lib lint BAHVimeoOAuth.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BAHVimeoOAuth"
  s.version          = "0.1.0"
  s.summary          = "Simple Vimeo OAuth 2.0 client"
  s.description      = <<-DESC
                       A very easy, simple to use, specific to Vimeo OAuth 2.0 client.

                       DESC
  s.homepage         = "https://github.com/BHughes3388/BAHVimeoOAuth"
  s.screenshots     = "http://img.photobucket.com/albums/v235/rx7anator/Mobile%20Applications/6bffa370-627d-43b7-8128-136d11700b27_zpsgdk1fbjo.png"
  s.license          = 'MIT'
  s.author           = { "BHughes3388" => "BHughes3388@gmail.com" }
  s.source           = { :git => "https://github.com/BHughes3388/BAHVimeoOAuth.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BAHVimeoOAuth' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
