#
#  Be sure to run `pod spec lint FFPopup.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name                = "FFPopup"
  s.version             = "1.1.5"
  s.summary             = "Presenting custom views as a popup in iOS."

  s.description         = <<-DESC
                          A lightweight library for presenting custom views as a popup in iOS.
                          DESC

  s.homepage            = "https://github.com/JonyFang/FFPopup"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "JonyFang" => "jony.chunfang@gmail.com" }
  s.social_media_url    = "https://www.jonyfang.com"

  s.requires_arc        = true
  s.framework           = "UIKit"
  s.ios.deployment_target = "8.0"

  s.source_files        = "FFPopup/Classes/*.{h,m}"
  s.source              = { :git => "https://github.com/JonyFang/FFPopup.git", :tag => s.version.to_s }

end
