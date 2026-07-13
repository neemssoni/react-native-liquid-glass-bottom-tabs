require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "LiquidGlassBottomTabs"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "14.0" }
  s.source       = { :git => "https://github.com/neemssoni/react-native-liquid-glass-bottom-tabs.git", :tag => "#{s.version}" }

  # 1. ADDED 'swift' to the ios/ source files array!
  s.source_files = "ios/**/*.{h,m,mm,swift}", "ios/generated/*.{h,cpp,mm}"
  s.private_header_files = "ios/**/*.h"
  
  # 2. ADDED Swift version specification
  s.swift_version = "5.0"

  install_modules_dependencies(s)
end