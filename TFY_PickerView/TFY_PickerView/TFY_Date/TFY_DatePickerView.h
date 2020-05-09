//
//  TFY_DatePickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法
/*
 第一种
 [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYMDHM defaultSelValue:@"" resultBlock:^(NSString * _Nonnull selectValue) {
 NSLog(@"时间选择器1---%@",selectValue);
 }];
 第二种
 NSDate *minDate = [NSDate tfy_setHour:8 minute:10];
 NSDate *maxDate = [NSDate tfy_setHour:20 minute:35];
 [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeDateAndTime defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blackColor] resultBlock:^(NSString * _Nonnull selectValue) {
 NSLog(@"时间选择器2---%@",selectValue);
 }];
 */

#import "TFY_BaseView.h"
#import "NSDate+TFY_PickerView.h"

NS_ASSUME_NONNULL_BEGIN

/// 弹出日期类型
typedef NS_ENUM(NSInteger, TFY_DatePickerMode) {
    // --- 以下4种是系统自带的样式 ---
    // UIDatePickerModeTime
    TFY_DatePickerModeTime,              // HH:mm
    // UIDatePickerModeDate
    TFY_DatePickerModeDate,              // yyyy-MM-dd
    // UIDatePickerModeDateAndTime
    TFY_DatePickerModeDateAndTime,       // yyyy-MM-dd HH:mm
    // UIDatePickerModeCountDownTimer
    TFY_DatePickerModeCountDownTimer,    // HH:mm
    // --- 以下7种是自定义样式 ---
    // 年月日时分
    TFY_DatePickerModeYMDHM,      // yyyy-MM-dd HH:mm
    // 月日时分
    TFY_DatePickerModeMDHM,       // MM-dd HH:mm
    // 年月日
    TFY_DatePickerModeYMD,        // yyyy-MM-dd
    // 年月
    TFY_DatePickerModeYM,         // yyyy-MM
    // 年
    TFY_DatePickerModeY,          // yyyy
    // 月日
    TFY_DatePickerModeMD,         // MM-dd
    // 时分
    TFY_DatePickerModeHM          // HH:mm
};


typedef void(^TFY_DateResultBlock)(NSString *selectValue);
typedef void(^TFY_DateCancelBlock)(void);

@interface TFY_DatePickerView : TFY_BaseView
/**
 * title 标题 type 类型（时间、日期、日期和时间、倒计时） defaultSelValue  默认选中的时间（为空，默认选中现在的时间）minDateStr       最小时间（如：2015-08-28 00:00:00），可为空 maxDateStr 最大时间（如：2018-05-05 00:00:00），可为空 isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 */
+ (void)showDatePickerWithTitle:(NSString *)title
                       dateType:(TFY_DatePickerMode)dateType
                defaultSelValue:(NSString *)defaultSelValue
                    resultBlock:(TFY_DateResultBlock)resultBlock;
/**
 * title 标题  dateType 日期显示类型  defaultSelValue  默认选中的时间（值为空/值格式错误时，默认就选中现在的时间）minDate 最小时间，可为空（请使用 NSDate+TFY_PickerView 分类中和显示类型格式对应的方法创建 minDate） maxDate 最大时间，可为空（请使用 NSDate+TFY_PickerView 分类中和显示类型格式对应的方法创建 maxDate） isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值 themeColor  自定义主题颜色
 */
+ (void)showDatePickerWithTitle:(NSString *)title
                       dateType:(TFY_DatePickerMode)dateType
                defaultSelValue:(NSString *)defaultSelValue
                        minDate:(NSDate *)minDate
                        maxDate:(NSDate *)maxDate
                   isAutoSelect:(BOOL)isAutoSelect
                     themeColor:(UIColor *)themeColor
                    resultBlock:(TFY_DateResultBlock)resultBlock;
/**
 * title 标题  dateType 日期显示类型  defaultSelValue  默认选中的时间（值为空/值格式错误时，默认就选中现在的时间）minDate 最小时间，可为空（请使用 NSDate+TFY_PickerView 分类中和显示类型格式对应的方法创建 minDate） maxDate 最大时间，可为空（请使用 NSDate+TFY_PickerView 分类中和显示类型格式对应的方法创建 maxDate） isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值 themeColor  自定义主题颜色
 */
+ (void)showDatePickerWithTitle:(NSString *)title
                       dateType:(TFY_DatePickerMode)dateType
                defaultSelValue:(NSString *)defaultSelValue
                        minDate:(NSDate *)minDate
                        maxDate:(NSDate *)maxDate
                   isAutoSelect:(BOOL)isAutoSelect
                     themeColor:(UIColor *)themeColor
                    resultBlock:(TFY_DateResultBlock)resultBlock
                    cancelBlock:(TFY_DateCancelBlock)cancelBlock;
@end

NS_ASSUME_NONNULL_END
