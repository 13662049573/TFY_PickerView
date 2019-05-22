//
//  TFY_StringPickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法如下：
/*
 第一种
 [TFY_StringPickerView showStringPickerWithTitle:@"宝宝性别" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:textField.text resultBlock:^(id selectValue) {
 textField.text = self.infoModel.genderStr = selectValue;
 }];
 第二种
 NSString *dataSource = @"testData1.plist"; // 可以将数据源（上面的数组）放到plist文件中
 [TFY_StringPickerView showStringPickerWithTitle:@"学历" dataSource:dataSource defaultSelValue:textField.text isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
 textField.text = self.infoModel.educationStr = selectValue;
 } cancelBlock:^{
 NSLog(@"点击了背景视图或取消按钮");
 }];
 第三种
 NSArray *dataSource = @[@[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周", @"第6周", @"第7周"], @[@"第1天", @"第2天", @"第3天", @"第4天", @"第5天", @"第6天", @"第7天"]];
 // NSString *dataSource = @"testData3.plist"; // 可以将数据源（上面的数组）放到plist文件中
 NSArray *defaultSelArr = [textField.text componentsSeparatedByString:@"，"];
 [TFY_StringPickerView showStringPickerWithTitle:@"自定义多列字符串" dataSource:dataSource defaultSelValue:defaultSelArr isAutoSelect:YES themeColor:TFY_RGB_HEX(0xff7998, 1.0f) resultBlock:^(id selectValue) {
 textField.text = self.infoModel.otherStr = [NSString stringWithFormat:@"%@，%@", selectValue[0], selectValue[1]];
 } cancelBlock:^{
 NSLog(@"点击了背景视图或取消按钮");
 }];
 */

#import "TFY_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TFY_StringResultBlock)(id selectValue);
typedef void(^TFY_StringCancelBlock)(void);

@interface TFY_StringPickerView : TFY_BaseView
/**
 *  title 标题  dataSource  数组数据源  defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                      resultBlock:(TFY_StringResultBlock)resultBlock;
/**
 *  title 标题  plistName  plist文件名  defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                       themeColor:(UIColor *)themeColor
                      resultBlock:(TFY_StringResultBlock)resultBlock;

/**
 * title 标题 dataSource 数据源（1.直接传数组：NSArray类型；2.可以传plist文件名：NSString类型，带后缀名，plist文件内容要是数组格式）defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect 是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值 themeColor 自定义主题颜色 resultBlock      选择后的回调 cancelBlock      取消选择的回调
 */
+ (void)showStringPickerWithTitle:(NSString *)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                       themeColor:(UIColor *)themeColor
                      resultBlock:(TFY_StringResultBlock)resultBlock
                      cancelBlock:(TFY_StringCancelBlock)cancelBlock;
@end

NS_ASSUME_NONNULL_END
