

Pod::Spec.new do |s|

 
  s.name         = "LDNetwork"
  s.version      = "0.0.1"
  s.summary      = "A simple package of AFNetworking and YYCache."

  s.homepage     = "https://github.com/alexiiio/LDNetwork"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "AleXiiio" => "450145524@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/alexiiio/LDNetwork.git", :tag => "v0.0.1" }

  s.source_files  = 'LDNetworkManager/Network/LDNetwork/'
  
  s.dependency 'AFNetworking'

  s.dependency 'YYCache'

  s.requires_arc = true

end