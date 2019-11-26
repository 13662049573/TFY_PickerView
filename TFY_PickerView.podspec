

Pod::Spec.new do |spec|

  spec.name         = "TFY_PickerView"

  spec.version      = "2.5.2"

  spec.summary      = "时间选择器，多种选择模式，适合多种选择"

  spec.description  = "时间选择器，多种选择模式，适合多种选择"

  spec.homepage     = "https://github.com/13662049573/TFY_PickerView"
  
  spec.license      = "MIT"
 
  spec.author       = { "tianfengyou" => "420144542@qq.com" }
  
  spec.platform     = :ios
  
  spec.source       = { :git => "https://github.com/13662049573/TFY_PickerView.git", :tag => spec.version }

  spec.source_files  = "TFY_PickerView/TFY_PickerView/**/*.{h,m}"
  
  spec.resources = "TFY_PickerView/TFY_PickerView/TFY_CityBundle.bundle"

  spec.frameworks = "UIKit", "Foundation"

  spec.requires_arc = true

end
