//
//  NSDate+TFY_PickerView.m
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "NSDate+TFY_PickerView.h"
#import "TFY_PickerViewMacro.h"

TFYSYNTH_DUMMY_CLASS(NSDate_TFY_PickerView)

static const NSCalendarUnit unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter);

@implementation NSDate (TFY_PickerView)

#pragma mark - 获取日历单例对象
+ (NSCalendar *)picker_calendar {
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        // 创建日历对象，指定日历的算法（公历/阳历）
        sharedCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // NSCalendar 设置时区
        //sharedCalendar.timeZone = [NSTimeZone timeZoneWithName:@"America/Chicago"];
    }
    return sharedCalendar;
}

#pragma mark - NSDate 转 NSDateComponents
+ (NSDateComponents *)picker_componentsFromDate:(NSDate *)date {
    // 通过日历类 NSCalendar 进行转换
    NSCalendar *calendar = [self picker_calendar];
    // NSDateComponents 可以获得日期的详细信息，即日期的组成
    return [calendar components:unitFlags fromDate:date];
}

#pragma mark - NSDateComponents 转 NSDate
+ (NSDate *)picker_dateFromComponents:(NSDateComponents *)components {
    // 通过日历类 NSCalendar 进行转换
    NSCalendar *calendar = [self picker_calendar];
    return [calendar dateFromComponents:components];
}

#pragma mark - 获取指定日期的年份
- (NSInteger)picker_year {
    return [NSDate picker_componentsFromDate:self].year;
}

#pragma mark - 获取指定日期的月份
- (NSInteger)picker_month {
    return [NSDate picker_componentsFromDate:self].month;
}

#pragma mark - 获取指定日期的天
- (NSInteger)picker_day {
    return [NSDate picker_componentsFromDate:self].day;
}

#pragma mark - 获取指定日期的小时
- (NSInteger)picker_hour {
    return [NSDate picker_componentsFromDate:self].hour;
}

#pragma mark - 获取指定日期的分钟
- (NSInteger)picker_minute {
    return [NSDate picker_componentsFromDate:self].minute;
}

#pragma mark - 获取指定日期的秒
- (NSInteger)picker_second {
    return [NSDate picker_componentsFromDate:self].second;
}

#pragma mark - 获取指定日期的星期
- (NSInteger)picker_weekday {
    return [NSDate picker_componentsFromDate:self].weekday;
}

#pragma mark - 获取指定日期的月周
- (NSInteger)picker_monthWeek {
    return [NSDate picker_componentsFromDate:self].weekOfMonth;
}

#pragma mark - 获取指定日期的年周
- (NSInteger)picker_yearWeek {
    return [NSDate picker_componentsFromDate:self].weekOfYear;
}

#pragma mark - 获取指定日期的季度
- (NSInteger)picker_quarter {
//    [NSDate picker_componentsFromDate:self].quarter; // 取到的季度值总是0?
    NSInteger quarter = 1;
    NSInteger month = self.picker_month;
    if (month > 3) quarter = 2;
    if (month > 6) quarter = 3;
    if (month > 9) quarter = 4;
    
    return quarter;
}

#pragma mark - 获取指定日期的星期
- (NSString *)picker_weekdayString {
    switch (self.picker_weekday - 1) {
        case 0:
        {
            return @"周日";
        }
            break;
        case 1:
        {
            return @"周一";
        }
            break;
        case 2:
        {
            return @"周二";
        }
            break;
        case 3:
        {
            return @"周三";
        }
            break;
        case 4:
        {
            return @"周四";
        }
            break;
        case 5:
        {
            return @"周五";
        }
            break;
        case 6:
        {
            return @"周六";
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}

/// ---------------- 创建 date ----------------
#pragma mark - 通过 NSDateComponents对象 来创建 NSDate对象（可以设置时区）
+ (nullable NSDate *)picker_setDateFromComponents:(NSDateComponents *)components timeZone:(NSTimeZone *)timeZone {
    // 创建日历对象，指定日历的算法（公历/阳历）
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    if (timeZone) {
        // NSCalendar 设置时区
        calendar.timeZone = timeZone;
    }
    return [calendar dateFromComponents:components];
}

#pragma mark - 创建date（通过 NSCalendar 类来创建日期）
+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self picker_setYear:year month:month day:day hour:hour minute:minute second:second weekOfMonth:0 weekOfYear:0 quarter:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                  hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
           weekOfMonth:(NSInteger)weekOfMonth weekOfYear:(NSInteger)weekOfYear quarter:(NSInteger)quarter {
    NSDateComponents *components = [self picker_componentsFromDate:[NSDate date]];
    if (year > 0) {
        // 初始化日期组件
        components = [[NSDateComponents alloc]init];
        components.year = year;
    }
    if (month > 0) {
        components.month = month;
    }
    if (day > 0) {
        components.day = day;
    }
    if (hour >= 0) {
        components.hour = hour;
    }
    if (minute >= 0) {
        components.minute = minute;
    }
    if (second >= 0) {
        components.second = second;
    }
    if (weekOfMonth > 0) {
        components.weekOfMonth = weekOfMonth;
    }
    if (weekOfYear > 0) {
        components.weekOfYear = weekOfYear;
    }
    if (quarter > 0) {
        components.quarter = quarter;
    }
    
    return [self picker_dateFromComponents:components];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self picker_setYear:year month:month day:day hour:hour minute:minute second:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    return [self picker_setYear:year month:month day:day hour:hour minute:0 second:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self picker_setYear:year month:month day:day hour:0 minute:0 second:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month {
    return [self picker_setYear:year month:month day:0 hour:0 minute:0 second:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year {
    return [self picker_setYear:year month:0 day:0 hour:0 minute:0 second:0];
}

+ (NSDate *)picker_setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self picker_setYear:0 month:month day:day hour:hour minute:minute second:0];
}

+ (NSDate *)picker_setMonth:(NSInteger)month day:(NSInteger)day {
    return [self picker_setYear:0 month:month day:day hour:0 minute:0 second:0];
}

+ (NSDate *)picker_setHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self picker_setYear:0 month:0 day:0 hour:hour minute:minute second:second];
}

+ (NSDate *)picker_setHour:(NSInteger)hour minute:(NSInteger)minute {
    return [self picker_setYear:0 month:0 day:0 hour:hour minute:minute second:0];
}

+ (NSDate *)picker_setMinute:(NSInteger)minute second:(NSInteger)second {
    return [self picker_setYear:0 month:0 day:0 hour:0 minute:minute second:second];
}

+ (NSDate *)picker_setYear:(NSInteger)year month:(NSInteger)month weekOfMonth:(NSInteger)weekOfMonth {
    return [self picker_setYear:year month:month day:0 hour:0 minute:0 second:0 weekOfMonth:weekOfMonth weekOfYear:0 quarter:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year weekOfYear:(NSInteger)weekOfYear {
    return [self picker_setYear:year month:0 day:0 hour:0 minute:0 second:0 weekOfMonth:0 weekOfYear:weekOfYear quarter:0];
}

+ (NSDate *)picker_setYear:(NSInteger)year quarter:(NSInteger)quarter {
    return [self picker_setYear:year month:0 day:0 hour:0 minute:0 second:0 weekOfMonth:0 weekOfYear:0 quarter:quarter];
}

#pragma mark - 获取某个月的天数（通过年月求每月天数）
+ (NSUInteger)picker_getDaysInYear:(NSInteger)year month:(NSInteger)month {
    BOOL isLeapYear = year % 4 == 0 ? (year % 100 == 0 ? (year % 400 == 0 ? YES : NO) : YES) : NO;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        {
            return 31;
        }
        case 4:
        case 6:
        case 9:
        case 11:
        {
            return 30;
        }
        case 2:
        {
            if (isLeapYear) {
                return 29;
            } else {
                return 28;
            }
        }
        default:
            break;
    }
    
    return 0;
}

#pragma mark - 获取某个月的周数（通过年月求该月周数）
+ (NSUInteger)picker_getWeeksOfMonthInYear:(NSInteger)year month:(NSInteger)month {
    NSUInteger lastDayOfMonth = [self picker_getDaysInYear:year month:month];
    NSDate *endDate = [self picker_setYear:year month:month day:lastDayOfMonth];
    return endDate.picker_monthWeek;
}

#pragma mark - 获取某一年的周数（通过年求该年周数）
+ (NSUInteger)picker_getWeeksOfYearInYear:(NSInteger)year {
    NSDate *endDate = [self picker_setYear:year month:12 day:31];
    NSInteger weeks = endDate.picker_yearWeek;
    if (weeks == 1) weeks = 52;
    return weeks;
}

#pragma mark - 获取某一年的季度数（通过年求该年季度数）
+ (NSUInteger)picker_getQuartersInYear:(NSInteger)year {
    NSDate *endDate = [self picker_setYear:year month:12 day:31];
    return endDate.picker_quarter;
}

#pragma mark - 获取 日期加上/减去某天数后的新日期
- (NSDate *)picker_getNewDateToDays:(NSTimeInterval)days {
    // days 为正数时，表示几天之后的日期；负数表示几天之前的日期
    return [self dateByAddingTimeInterval:60 * 60 * 24 * days];
}

#pragma mark - 获取 日期加上/减去某个月数后的新日期
- (nullable NSDate *)picker_getNewDateToMonths:(NSTimeInterval)months {
    // months 为正数时，表示几个月之后的日期；负数表示几个月之前的日期
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calender dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - NSDate 转 NSString
+ (NSString *)picker_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    return [self picker_stringFromDate:date dateFormat:dateFormat timeZone:nil language:nil];
}
#pragma mark - NSDate 转 NSString
+ (NSString *)picker_stringFromDate:(NSDate *)date
                     dateFormat:(NSString *)dateFormat
                       timeZone:(NSTimeZone *)timeZone
                       language:(NSString *)language {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateFormatter.dateFormat = dateFormat;
    // NSDateFormatter 设置时区 ，不设置默认为系统时区
    if (timeZone) {
        dateFormatter.timeZone = timeZone;
    }
    if (!language) {
        language = [NSLocale preferredLanguages].firstObject;
    }
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:language];
    NSString *dateString = [dateFormatter stringFromDate:date];

    return dateString;
}

#pragma mark - NSString 转 NSDate
+ (NSDate *)picker_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    return [self picker_dateFromString:dateString dateFormat:dateFormat timeZone:nil language:nil];
}
#pragma mark - NSString 转 NSDate
+ (NSDate *)picker_dateFromString:(NSString *)dateString
                   dateFormat:(NSString *)dateFormat
                     timeZone:(NSTimeZone *)timeZone
                     language:(NSString *)language {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateFormatter.dateFormat = dateFormat;
    // 设置时区
    if (!timeZone) {
        timeZone = [self currentTimeZone];
    }
    if (!language) {
        language = [NSLocale preferredLanguages].firstObject;
    }
    dateFormatter.timeZone = timeZone;
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:language];
    // 如果当前时间不存在，就获取距离最近的整点时间
    dateFormatter.lenient = YES;
    
    return [dateFormatter dateFromString:dateString];
}

#pragma mark - 获取当前时区(不使用夏时制)
+ (NSTimeZone *)currentTimeZone {
    // 当前时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    // 当前时区相对于GMT(零时区)的偏移秒数
    NSInteger interval = [localTimeZone secondsFromGMTForDate:[NSDate date]];
    // 当前时区(不使用夏时制)：由偏移量获得对应的NSTimeZone对象
    // 注意：一些夏令时时间 NSString 转 NSDate 时，默认会导致 NSDateFormatter 格式化失败，返回 null
    return [NSTimeZone timeZoneForSecondsFromGMT:interval];
}

@end
