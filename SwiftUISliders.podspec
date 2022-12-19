Pod::Spec.new do |s|
  s.name = "SwiftUISliders"
  s.version = "2.1.0"
  s.summary = "🚀 SwiftUI Sliders with custom styles"

  s.homepage = "https://github.com/spacenation/swiftui-sliders"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "SpaceNation" => '' }
  s.source = { :git => "https://github.com/spacenation/swiftui-sliders.git", :tag => s.version.to_s }

  s.osx.deployment_target = "10.13"
	s.ios.deployment_target = "14.0"

  s.swift_version = "5.0"

  s.source_files = "Sources/**/*"
end

