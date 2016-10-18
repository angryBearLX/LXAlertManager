Pod::Spec.new do |s|
  s.name         = "LXAlertManager"
  s.version      = "1.0.0"
  s.summary      = "It's a alert or actionsheet."
  s.description  = <<-DESC
                   It is a alert or actionsheet on iOS.
		   DESC
  s.homepage     = "https://github.com/angryBearLX/LXAlertManager.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "熊大" => "280208990@qq.com" }
  s.source       = {:git => "https://github.com/angryBearLX/LXAlertManager.git",:tag => s.version.to_s}
  s.platform     = :ios, "5.0"

  s.source_files  = "LXAlertManager/*"
  # s.resources = "Resources/*.png"

  s.framework  = "Foundation","CoreGraphics","UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
