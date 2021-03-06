#
#  Be sure to run `pod spec lint NBRouter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "NBRouter"
  s.version      = "1.3.1.3"
  s.summary      = "提供控制器切换管理,完全解耦,随时随地,实现切换控制器"


  s.homepage     = "https://github.com/NapoleonBaiAndroid/NBRouter"


  s.license      = "MIT"


  s.author       = { "NapoleonBai" => "napoleonbaiandroid@gmail.com" }


  s.source       = { :git => "https://github.com/NapoleonBaiAndroid/NBRouter.git", :tag => "1.3.1.3" }

  s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source_files  = "NBRouter/NBRouter/*.{h,m}"

  s.public_header_files = "NBRouter/NBRouter/*.h"

  s.requires_arc = true

end
