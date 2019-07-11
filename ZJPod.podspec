#
#  Be sure to run `pod spec lint WZJBaseViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
spec.name         = "ZJPod"
spec.version      = "1.2"
spec.summary      = "Base Class "
spec.description  = <<-DESC
BaseViewController
DESC

spec.homepage     = "https://github.com/vstx143/ZJPod"
spec.license      = "MIT"
spec.author             = { "vstx143" => "549890753@qq.com" }
spec.platform     = :ios, "8.0"

spec.source       = { :git => "https://github.com/vstx143/ZJPod.git", :tag => "#{spec.version}" }
spec.source_files  = 'ZJPod','**/*.{h,m}'
spec.requires_arc = true
spec.dependency "DZNEmptyDataSet"
spec.dependency "MJRefresh"
spec.dependency "AFNetworking"
end

