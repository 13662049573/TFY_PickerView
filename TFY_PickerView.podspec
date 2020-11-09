

Pod::Spec.new do |spec|

  spec.name         = "TFY_PickerView"

  spec.version      = "2.6.6"

  spec.summary      = "时间选择器，多种选择模式，适合多种选择"

  spec.description  = "时间选择器，多种选择模式，适合多种选择"

  spec.homepage     = "https://github.com/13662049573/TFY_PickerView"
  
  spec.license      = "MIT"
 
  spec.author       = { "tianfengyou" => "420144542@qq.com" }
  
  spec.platform     = :ios, "12.0"
  
  spec.source       = { :git => "https://github.com/13662049573/TFY_PickerView.git", :tag => spec.version }

  spec.source_files  = "TFY_PickerView/TFY_PickerView/TFY_PickerView.h"
  
  spec.subspec 'TFY_Address' do |ss|
    ss.source_files  = "TFY_PickerView/TFY_PickerView/TFY_Address/**/*.{h,m}"
    ss.dependency "TFY_PickerView/TFY_Macro"
  end

  spec.subspec 'TFY_Date' do |ss|
    ss.source_files  = "TFY_PickerView/TFY_PickerView/TFY_Date/**/*.{h,m}"
    ss.dependency "TFY_PickerView/TFY_Macro"
  end

  spec.subspec 'TFY_Macro' do |ss|
    ss.source_files  = "TFY_PickerView/TFY_PickerView/TFY_Macro/**/*.{h,m}"
  end

  spec.subspec 'TFY_String' do |ss|
    ss.source_files  = "TFY_PickerView/TFY_PickerView/TFY_String/**/*.{h,m}"
    ss.dependency "TFY_PickerView/TFY_Macro"
  end

  spec.resources = "TFY_PickerView/TFY_PickerView/TFY_CityBundle.bundle"

  spec.frameworks = "UIKit", "Foundation"

  spec.requires_arc = true

end
