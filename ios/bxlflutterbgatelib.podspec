#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bxlflutterbgatelib.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bxlflutterbgatelib'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Plugin for Bixolon Bgate Library'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  #s.source_files = 'Classes/**/*', 'Libs/**/*.{h,m,swift}'
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  #s.vendored_library = 'Libs/libMPosSDK.a'
  s.vendored_frameworks = 'Libs/frameworkMPosSDK.xcframework'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  #s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #s.pod_target_xcconfig = {  'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  #s.user_target_xcconfig = {  'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '4.0'
end
