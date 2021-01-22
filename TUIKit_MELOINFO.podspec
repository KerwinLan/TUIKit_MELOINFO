Pod::Spec.new do |s|
  s.name         = "TUIKit_MELOINFO"
  s.version      = "0.0.1"
  s.summary      = "腾讯TUIKit5.1.2修改版本"
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage     = "https://github.com/KerwinLan/TUIKit_MELOINFO"
  s.license      = "MIT"
  s.author             = { "KerwinLAN" => "kerwinlan56@gmail.com" }
  s.social_media_url   = "https://github.com/KerwinLan"
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/KerwinLan/TUIKit_MELOINFO.git", :tag => s.version.to_s }
  s.default_subspec = "Core"
  s.xcconfig = { 'VALID_ARCHS' => 'armv7 arm64 x86_64' }
  s.libraries = "stdc++"
  s.pod_target_xcconfig = {
	"EXCLUDED_ARCHS[sdk=iphonesimulator*]": "arm64"
  }
  s.user_target_xcconfig = {
    "EXCLUDED_ARCHS[sdk=iphonesimulator*]": "arm64"
  }
  
  s.subspec 'Core' do |core|
    core.source_files  = "**/TUIKit_MELOINFO/Classes/*.{h,m,mm}"
    core.vendored_libraries = [
      "**/TUIKit_MELOINFO/Classes/Third/voiceConvert/opencore-amrnb/libopencore-amrnb.a",
      "**/TUIKit_MELOINFO/Classes/Third/voiceConvert/opencore-amrnb/libopencore-amrwb.a"
    ]
    core.resources = [
      "**/TUIKit_MELOINFO/Resources/TUIKitFace.bundle",
      "**/TUIKit_MELOINFO/Resources/TUIKitResource.bundle"
    ]
    core.resource_bundles = {
      "TUIKitLocalizable" => [
        "**/TUIKit_MELOINFO/Resources/Localizable/*"
      ]
    }
    core.dependency "TXIMSDK_iOS", "5.1.21"
    core.dependency "Toast", "4.0.0"
    core.dependency "ReactiveObjC", "3.1.1"
    core.dependency "SDWebImage", "5.9.0"
    core.dependency "MMLayout", "0.2.0"
    core.dependency "TXLiteAVSDK_TRTC", "7.8.9519"
  end

end
