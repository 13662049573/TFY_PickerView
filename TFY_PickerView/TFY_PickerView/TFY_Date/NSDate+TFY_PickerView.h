//
//  NSDate+TFY_PickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TFY_PickerViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface NSDate (TFY_PickerView)
@property (readonly) NSInteger tfy_year;    // 年
@property (readonly) NSInteger tfy_month;   // 月
@property (readonly) NSInteger tfy_day;     // 日
@property (readonly) NSInteger tfy_hour;    // 时
@property (readonly) NSInteger tfy_minute;  // 分
@property (readonly) NSInteger tfy_second;  // 秒
@property (readonly) NSInteger tfy_weekday; // 星期

/** 创建 date */
/** yyyy */
+ (nullable NSDate *)tfy_setYear:(NSInteger)year;
/** yyyy-MM */
+ (nullable NSDate *)tfy_setYear:(NSInteger)year month:(NSInteger)month;
/** yyyy-MM-dd */
+ (nullable NSDate *)tfy_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)tfy_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd HH:mm */
+ (nullable NSDate *)tfy_setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd */
+ (nullable NSDate *)tfy_setMonth:(NSInteger)month day:(NSInteger)day;
/** HH:mm */
+ (nullable NSDate *)tfy_setHour:(NSInteger)hour minute:(NSInteger)minute;

/** yyyy */
+ (nullable NSDate *)setYear:(NSInteger)year TFY_PickerViewDeprecated("过期提醒：请使用带br前缀的方法");
/** yyyy-MM */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");
/** yyyy-MM-dd */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");
/** MM-dd HH:mm */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");
/** MM-dd */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");
/** HH:mm */
+ (nullable NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute TFY_PickerViewDeprecated("过期提醒：请使用带tfy前缀的方法");

/** 日期和字符串之间的转换：NSDate --> NSString */
+ (nullable  NSString *)tfy_getDateString:(NSDate *)date format:(NSString *)format;
/** 日期和字符串之间的转换：NSString --> NSDate */
+ (nullable  NSDate *)tfy_getDate:(NSString *)dateString format:(NSString *)format;
/** 获取某个月的天数（通过年月求每月天数）*/
+ (NSUInteger)tfy_getDaysInYear:(NSInteger)year month:(NSInteger)month;

/**  获取 日期加上/减去某天数后的新日期 */
- (nullable NSDate *)tfy_getNewDate:(NSDate *)date addDays:(NSTimeInterval)days;

/**
 *  比较两个时间大小（可以指定比较级数，即按指定格式进行比较）
 */
- (NSComparisonResult)tfy_compare:(NSDate *)targetDate format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
