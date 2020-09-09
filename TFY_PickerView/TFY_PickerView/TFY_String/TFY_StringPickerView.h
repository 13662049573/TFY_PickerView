//
//  TFY_StringPickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法如下：
/*
 第一种
 [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" resultBlock:^(id  _Nonnull selectValue) {
 
 NSLog(@"普通选择器1---%@",selectValue);
 
 }];
 第二种
 [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(id  _Nonnull selectValue) {
 
 NSLog(@"普通选择器3自定义颜色---%@",selectValue);
 
 } cancelBlock:^{
 NSLog(@"普通选择器3自定义颜色---%@",@"cancel");
 }];
 第三种
 NSArray *dataSource = @[@[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周", @"第6周", @"第7周"], @[@"第1天", @"第2天", @"第3天", @"第4天", @"第5天", @"第6天", @"第7天"]];
 [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:dataSource defaultSelValue:@"第5周" isAutoSelect:YES themeColor:[UIColor greenColor] resultBlock:^(id  _Nonnull selectValue) {
 NSLog(@"普通选择器2自定义颜色---%@",selectValue[0]);
 }];
 */

#import "TFY_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable TFY_StringResultBlock)(id selectValue);
typedef void(^ _Nullable TFY_StringCancelBlock)(void);

@interface TFY_StringPickerView : TFY_BaseView
/**
 *  title 标题  dataSource  数组数据源  defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 */
+ (void)showStringPickerWithTitle:(NSString *_Nullable)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                      resultBlock:(TFY_StringResultBlock)resultBlock;
/**
 *  title 标题  plistName  plist文件名  defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 */
+ (void)showStringPickerWithTitle:(NSString *_Nullable)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                       themeColor:(UIColor *_Nullable)themeColor
                      resultBlock:(TFY_StringResultBlock)resultBlock;

/**
 * title 标题 dataSource 数据源（1.直接传数组：NSArray类型；2.可以传plist文件名：NSString类型，带后缀名，plist文件内容要是数组格式）defaultSelValue  默认选中的行(单列传字符串，多列传一维数组) isAutoSelect 是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值 themeColor 自定义主题颜色 resultBlock      选择后的回调 cancelBlock      取消选择的回调
 */
+ (void)showStringPickerWithTitle:(NSString *_Nullable)title
                       dataSource:(id)dataSource
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                       themeColor:(UIColor *_Nullable)themeColor
                      resultBlock:(TFY_StringResultBlock)resultBlock
                      cancelBlock:(TFY_StringCancelBlock)cancelBlock;
@end

NS_ASSUME_NONNULL_END
