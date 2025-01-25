# TFY_PickerView

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://github.com/13662049573/TFY_PickerView)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/TFY_PickerView.svg)](https://img.shields.io/cocoapods/v/TFY_PickerView.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

一个功能强大且高度自定义的选择器,支持日期、地址、自定义字符串以及联动选择。完美支持 Swift 和 Objective-C。

<p align="center">
<img src="https://github.com/13662049573/TFY_PickerView/raw/master/Snapshots/demo_datepicker.gif" width="23%">
<img src="https://github.com/13662049573/TFY_PickerView/raw/master/Snapshots/demo_addresspicker.gif" width="23%">
<img src="https://github.com/13662049573/TFY_PickerView/raw/master/Snapshots/demo_stringpicker.gif" width="23%">
<img src="https://github.com/13662049573/TFY_PickerView/raw/master/Snapshots/demo_custom.gif" width="23%">
</p>

## 功能特点

- 丰富的选择器类型:
  - 日期选择器 (年月日时分秒)
  - 地址选择器 (省市区三级联动)
  - 自定义字符串选择器 (单列/多列/联动)
  - 完全自定义选择器
- 高度自定义UI样式
  - 自定义主题颜色
  - 自定义按钮文字和样式
  - 自定义标题栏
  - 自定义分割线
  - 自定义选择器背景
- 丰富的功能选项
  - 支持自动选择
  - 支持默认选中值
  - 支持选择范围限制
  - 支持选择器添加到指定视图
  - 支持选择器顶部/底部添加自定义视图
- 完善的国际化支持
  - 支持简体中文
  - 支持繁体中文
  - 支持英文
- 优秀的兼容性
  - 支持 iOS 暗黑模式
  - 支持横竖屏切换
  - 支持 iPad
  - 支持 Safe Area

## 系统要求

- iOS 12.0+
- Xcode 12.0+
- ARC

## 安装

### CocoaPods

1. 在 Podfile 中添加:

```ruby
pod 'TFY_PickerView'
```

2. 执行命令:

```bash
pod install
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/13662049573/TFY_PickerView.git", .upToNextMajor(from: "2.7.7"))
]
```

### 手动安装

将 `TFY_PickerView` 文件夹拖入项目即可。

## 快速开始

### 导入头文件

```objc
#import <TFY_PickerView/TFY_PickerView.h>
```

### 日期选择器

```objc
// 1.基础使用
[TFY_DatePickerView showDatePickerWithTitle:@"选择日期" 
                                  dateType:TFYDatePickerModeYMDHM 
                           defaultSelValue:nil 
                              resultBlock:^(NSString *selectValue) {
    NSLog(@"选择的日期:%@", selectValue);
}];

// 2.自定义日期范围
NSDate *minDate = [NSDate date];
NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60*30];
[TFY_DatePickerView showDatePickerWithTitle:@"选择日期"
                                  dateType:TFYDatePickerModeYMD
                           defaultSelValue:nil
                                 minDate:minDate
                                 maxDate:maxDate
                            isAutoSelect:YES
                              themeColor:[UIColor blueColor]
                             resultBlock:^(NSString *selectValue) {
    NSLog(@"选择的日期:%@", selectValue);
}];
```

### 地址选择器

```objc
// 1.基础使用
[TFY_AddressPickerView showAddressPickerWithDefaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] 
                                              resultBlock:^(TFY_ProvinceModel *province, TFY_CityModel *city, TFY_AreaModel *area) {
    NSLog(@"选择的地址:%@%@%@", province.name, city.name, area.name);
}];

// 2.自定义样式
[TFY_AddressPickerView showAddressPickerWithShowType:TFYAddressPickerModeArea
                                    defaultSelected:@[@"浙江省", @"杭州市", @"西湖区"]
                                      isAutoSelect:YES
                                       themeColor:[UIColor redColor]
                                     resultBlock:^(TFY_ProvinceModel *province, TFY_CityModel *city, TFY_AreaModel *area) {
    NSLog(@"选择的地址:%@%@%@", province.name, city.name, area.name);
}];
```

### 自定义字符串选择器

```objc
// 1.单列
NSArray *dataSource = @[@"男", @"女", @"其他"];
[TFY_StringPickerView showStringPickerWithTitle:@"选择性别" 
                                   dataSource:dataSource
                              defaultSelValue:@"男"
                                resultBlock:^(id selectValue) {
    NSLog(@"选择的值:%@", selectValue);
}];

// 2.多列
NSArray *dataSource = @[@[@"语文", @"数学", @"英语"], 
                       @[@"优秀", @"良好", @"及格"]];
[TFY_StringPickerView showStringPickerWithTitle:@"选择科目成绩" 
                                   dataSource:dataSource
                              defaultSelValue:@[@"英语", @"良好"]
                                isAutoSelect:YES
                                 themeColor:[UIColor greenColor]
                                resultBlock:^(id selectValue) {
    NSLog(@"选择的值:%@", selectValue);
}];
```

## 自定义样式

TFY_PickerView 提供了非常丰富的自定义选项:

```objc
TFY_PickerStyle *customStyle = [[TFY_PickerStyle alloc]init];

// 1.基础样式设置
customStyle.titleBarColor = [UIColor whiteColor];
customStyle.titleTextColor = [UIColor blackColor];
customStyle.pickerTextColor = [UIColor blackColor];
customStyle.separatorColor = [UIColor lightGrayColor];

// 2.标题栏设置
customStyle.titleBarHeight = 44.0f;
customStyle.titleTextFont = [UIFont systemFontOfSize:16.0f];
customStyle.hiddenTitleLine = NO;

// 3.按钮设置
customStyle.doneBtnTitle = @"完成";
customStyle.cancelBtnTitle = @"取消";
customStyle.doneBtnFont = [UIFont systemFontOfSize:16.0f];
customStyle.cancelBtnFont = [UIFont systemFontOfSize:16.0f];

// 4.选择器设置
customStyle.pickerHeight = 216.0f;
customStyle.rowHeight = 35.0f;
customStyle.hiddenMaskView = NO;

// 5.设置选择器样式
pickerView.pickerStyle = customStyle;
```

## 高级用法

### 1.自定义弹出动画

```objc
// 示例:从底部弹出
[UIView animateWithDuration:0.3 animations:^{
    self.alertView.frame = CGRectMake(0, self.keyView.bounds.size.height - height, width, height);
}];
```

### 2.添加自定义视图

```objc
// 添加到标题栏
UILabel *tipLabel = [[UILabel alloc]init];
tipLabel.text = @"提示文字";
[pickerView addSubViewToTitleBar:tipLabel];

// 添加到选择器
UIView *customView = [[UIView alloc]init];
[pickerView addSubViewToPicker:customView];
```

### 3.监听选择器滚动

```objc
pickerView.changeBlock = ^(NSDate *selectDate, NSString *selectValue) {
    NSLog(@"滚动选择:%@", selectValue);
};
```

## 注意事项

1. 选择器默认使用系统的 UIPickerView 实现,如需自定义样式请设置 pickerStyle
2. 日期选择器支持的最小系统版本为 iOS 12.0
3. 地址选择器默认使用内置的省市区数据,如需自定义数据源请设置 dataSource 属性
4. 在 iPad 上使用时建议设置 keyView 属性以保证选择器位置正确

## 常见问题

### Q1: 如何修改选择器默认选中的值?
A1: 可以通过设置 selectDate(日期选择器)、selectIndexs(地址选择器)、selectValue(字符串选择器) 属性来实现。

### Q2: 选择器弹出时动画卡顿怎么处理?
A2: 建议在主线程刷新UI,可以尝试使用 dispatch_async(dispatch_get_main_queue(), ^{ }) 优化。

### Q3: 地址选择器的数据是否支持自定义?
A3: 支持,可以通过设置 dataSource 属性来自定义数据源。数据源格式需要符合要求,具体可参考 Demo。

## 作者

田风有 

- 邮箱: 13662049573@163.com
- 微信: 13662049573

## 许可证

TFY_PickerView 基于 MIT 许可证发布。详细内容请查看 [LICENSE](LICENSE) 文件。

## 更新日志

### 2.7.7
- 新增暗黑模式支持
- 优化选择器弹出动画
- 修复已知问题

### 2.7.6 
- 新增自定义视图支持
- 优化代码结构
- 完善文档说明

### 2.7.5
- 新增国际化支持
- 优化选择器样式
- 修复 Bug

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=13662049573/TFY_PickerView&type=Date)](https://star-history.com/#13662049573/TFY_PickerView&Date)

## 贡献

欢迎提交 Issue 和 Pull Request。

1. Fork 项目
2. 创建新分支 (git checkout -b feature/AmazingFeature)
3. 提交更改 (git commit -m 'Add some AmazingFeature')
4. 推送到分支 (git push origin feature/AmazingFeature)
5. 打开 Pull Request
