require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-ndi-wrapper"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-ndi-wrapper
                   DESC
  s.homepage     = "https://github.com/bharatbiswal/react-native-ndi-wrapper"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Bharat Biswal" => "bharat.biswal@gmail.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/bharatbiswal/react-native-ndi-wrapper.git", :tag => "#{s.version}" }

  s.source_files = "ios/*.{h,m,swift}", "ios/NdiSDK_4_5/include/*.{h,m,swift}", "ios/NdiSDK_4_5/lib/iOS/*.{a}"
  s.preserve_paths = 'ios/NdiSDK_4_5/include/*.h',  'ios/NdiSDK_4_5/lib/iOS/*.a'
  s.vendored_libraries = 'ios/NdiSDK_4_5/lib/iOS/libndi_ios.a'
  s.libraries = 'ndi_ios'
  s.ios.user_target_xcconfig = { 
    'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/react-native-ndi-wrapper/ios/NdiSDK_4_5/include/**"',
    'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/react-native-ndi-wrapper/ios/NdiSDK_4_5/lib/iOS/**"'
  }
  s.requires_arc = true

  s.dependency "React"
  s.dependency 'AFNetworking', '~> 3.0'
  # s.dependency "..."

end

