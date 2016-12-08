Pod::Spec.new do |s|
  s.name         = "YUGCDObjC"
  s.version      = “1.0.1”
  s.summary      = "YUGCDObjC is Grand Central Dispatch simplified with objective-c" 
  s.homepage     = "https://github.com/c6357/YUGCDObjCExample"
  s.license      = "MIT"
  s.author             = { "BruceYu" => "c6357@outlook.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/c6357/YUGCDObjCExample.git", :tag => "#{s.version}" }
  s.source_files  = "YUGCDObjC", "YUGCDObjC/**/*.{h,m}"
  s.requires_arc = true
end