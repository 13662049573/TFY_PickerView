//
//  TFY_DatePickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法


#import "TFY_BaseView.h"
#import "NSDate+TFY_PickerView.h"

NS_ASSUME_NONNULL_BEGIN

/// 日期选择器格式
typedef NS_ENUM(NSInteger, TFYDatePickerMode) {
    // ----- 以下4种是系统样式（兼容国际化日期格式） -----
    /** 【yyyy-MM-dd】UIDatePickerModeDate（美式日期：MM-dd-yyyy；英式日期：dd-MM-yyyy）*/
    TFYDatePickerModeDate,
    /** 【yyyy-MM-dd HH:mm】 UIDatePickerModeDateAndTime */
    TFYDatePickerModeDateAndTime,
    /** 【HH:mm】UIDatePickerModeTime */
    TFYDatePickerModeTime,
    /** 【HH:mm】UIDatePickerModeCountDownTimer */
    TFYDatePickerModeCountDownTimer,
    
    // ----- 以下14种是自定义样式 -----
    /** 【yyyy-MM-dd HH:mm:ss】年月日时分秒 */
    TFYDatePickerModeYMDHMS,
    /** 【yyyy-MM-dd HH:mm】年月日时分 */
    TFYDatePickerModeYMDHM,
    /** 【yyyy-MM-dd HH】年月日时 */
    TFYDatePickerModeYMDH,
    /** 【MM-dd HH:mm】月日时分 */
    TFYDatePickerModeMDHM,
    /** 【yyyy-MM-dd】年月日（兼容国际化日期：dd-MM-yyyy）*/
    TFYDatePickerModeYMD,
    /** 【yyyy-MM】年月（兼容国际化日期：MM-yyyy）*/
    TFYDatePickerModeYM,
    /** 【yyyy】年 */
    TFYDatePickerModeY,
    /** 【MM-dd】月日 */
    TFYDatePickerModeMD,
    /** 【HH:mm:ss】时分秒 */
    TFYDatePickerModeHMS,
    /** 【HH:mm】时分 */
    TFYDatePickerModeHM,
    /** 【mm:ss】分秒 */
    TFYDatePickerModeMS,
    
    /** 【yyyy-qq】年季度 */
    TFYDatePickerModeYQ,
    /** 【yyyy-MM-ww】年月周 */
    TFYDatePickerModeYMW,
    /** 【yyyy-ww】年周 */
    TFYDatePickerModeYW
};

/// 日期单位显示的位置
typedef NS_ENUM(NSInteger, TFYShowUnitType) {
    /** 日期单位显示全部行（默认）*/
    TFYShowUnitTypeAll,
    /** 日期单位仅显示中间行 */
    TFYShowUnitTypeOnlyCenter,
    /** 日期单位不显示（隐藏日期单位）*/
    TFYShowUnitTypeNone
};

typedef void (^TFYDateResultBlock)(NSDate * _Nullable selectDate, NSString * _Nullable selectValue);

typedef void (^TFYDateResultRangeBlock)(NSDate * _Nullable selectStartDate, NSDate * _Nullable selectEndDate, NSString * _Nullable selectValue);

@interface TFY_DatePickerView : TFY_BaseView
/**
 //////////////////////////////////////////////////////////////////////////
 ///
 ///   【用法一】
 ///    特点：灵活，扩展性强（推荐使用！）
 ///
 ////////////////////////////////////////////////////////////////////////*/

/** 日期选择器显示类型 */
@property (nonatomic, assign) TFYDatePickerMode pickerMode;

/** 设置选中的日期（推荐使用 selectDate） */
@property (nullable, nonatomic, strong) NSDate *selectDate;
@property (nullable, nonatomic, copy) NSString *selectValue;

/** 最小日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）*/
@property (nullable, nonatomic, strong) NSDate *minDate;
/** 最大日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）*/
@property (nullable, nonatomic, strong) NSDate *maxDate;

/** 选择结果的回调 */
@property (nullable, nonatomic, copy) TFYDateResultBlock resultBlock;
/** 选择结果范围的回调：for `TFYDatePickerModeYQ`、`TFYDatePickerModeYMW`、`TFYDatePickerModeYW`, ignored otherwise. */
@property (nullable, nonatomic, copy) TFYDateResultRangeBlock resultRangeBlock;

/** 滚动选择时触发的回调 */
@property (nullable, nonatomic, copy) TFYDateResultBlock changeBlock;
/** 滚动选择范围时触发的回调：for `TFYDatePickerModeYQ`、`TFYDatePickerModeYMW`、`TFYDatePickerModeYW`, ignored otherwise. */
@property (nullable, nonatomic, copy) TFYDateResultRangeBlock changeRangeBlock;

/** 日期单位显示类型 */
@property (nonatomic, assign) TFYShowUnitType showUnitType;

/** 是否显示【星期】，默认为 NO */
@property (nonatomic, assign, getter=isShowWeek) BOOL showWeek;

/** 是否显示【今天】，默认为 NO */
@property (nonatomic, assign, getter=isShowToday) BOOL showToday;

/** 是否添加【至今】，默认为 NO */
@property (nonatomic, assign, getter=isAddToNow) BOOL addToNow;

/** 首行添加【自定义字符串】，配合 selectValue 可设置默认选中 */
@property (nullable, nonatomic, copy) NSString *firstRowContent;

/** 末行添加【自定义字符串】，配合 selectValue 可设置默认选中 */
@property (nullable, nonatomic, copy) NSString *lastRowContent;

/** 滚轮上日期数据排序是否降序，默认为 NO（升序）*/
@property (nonatomic, assign, getter=isDescending) BOOL descending;

/** 选择器上数字是否带有前导零，默认为 NO（如：无前导零:2020-1-1；有前导零:2020-01-01）*/
@property (nonatomic, assign, getter=isNumberFullName) BOOL numberFullName;

/** 设置分的时间间隔，默认为1（范围：1 ~ 30）*/
@property (nonatomic, assign) NSInteger minuteInterval;

/** 设置秒的时间间隔，默认为1（范围：1 ~ 30）*/
@property (nonatomic, assign) NSInteger secondInterval;

/** 设置倒计时的时长，默认为0（范围：0 ~ 24*60*60-1，单位为秒） for `TFYDatePickerModeCountDownTimer`, ignored otherwise. */
@property (nonatomic, assign) NSTimeInterval countDownDuration;

/**
 *  自定义月份数据源
 *  如：@[@"1月", @"2月",..., @"12月"]、 @[@"一月", @"二月",..., @"十二月"]、 @[@"Jan", @"Feb",..., @"Dec"] 等
 */
@property (nonatomic, copy) NSArray <NSString *> *monthNames;

/**
 *  设置国际化日期(非中文环境下)月份是否显示简称，默认为 NO。for `TFYDatePickerModeYMD` and `TFYDatePickerModeYM`, ignored otherwise.
 *  如：January 的简称为：Jan
 */
@property (nonatomic, assign, getter=isShortMonthName) BOOL shortMonthName;

/**
 *  自定义日期单位
 *  字典格式：@{@"year": @"年", @"month": @"月", @"day": @"日", @"hour": @"时", @"minute": @"分", @"second": @"秒"}
 */
@property (nonatomic, copy) NSDictionary *customUnit;

/** 显示上午和下午，默认为 NO. for `TFYDatePickerModeYMDH`, ignored otherwise. */
@property (nonatomic, assign, getter=isShowAMAndPM) BOOL showAMAndPM;

/** 设置时区，默认为当前时区 */
@property (nullable, nonatomic, copy) NSTimeZone *timeZone;

/** default is [NSCalendar currentCalendar]. setting nil returns to default. for `UIDatePicker` */
@property (nonatomic, copy) NSCalendar *calendar;

/** 指定不允许选择的日期 */
@property (nullable, nonatomic, copy) NSArray <NSDate *> *nonSelectableDates;

/** 不允许选择日期的回调 */
@property (nullable, nonatomic, copy) TFYDateResultBlock nonSelectableBlock;

/// 初始化日期选择器
///  pickerMode  日期选择器显示类型
- (instancetype)initWithPickerMode:(TFYDatePickerMode)pickerMode;

/// 弹出选择器视图
- (void)show;

/// 关闭选择器视图
- (void)dismiss;




//================================================= 华丽的分割线 =================================================




/**
 //////////////////////////////////////////////////////////////////////////
 ///
 ///   【用法二】：快捷使用，直接选择下面其中的一个方法进行使用
 ///    特点：快捷，方便
 ///
 ////////////////////////////////////////////////////////////////////////*/

/**
 *  1.显示日期选择器
 *
 *   mode             日期显示类型
 *   title            选择器标题
 *   selectValue      默认选中的日期（默认选中当前日期）
 *   resultBlock      选择结果的回调
 *
 */
+ (void)showDatePickerWithMode:(TFYDatePickerMode)mode
                         title:(nullable NSString *)title
                   selectValue:(nullable NSString *)selectValue
                   resultBlock:(nullable TFYDateResultBlock)resultBlock;

/**
 *  2.显示日期选择器
 *
 *   mode             日期显示类型
 *   title            选择器标题
 *   selectValue      默认选中的日期（默认选中当前日期）
 *   isAutoSelect     是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock      选择结果的回调
 *
 */
+ (void)showDatePickerWithMode:(TFYDatePickerMode)mode
                         title:(nullable NSString *)title
                   selectValue:(nullable NSString *)selectValue
                  isAutoSelect:(BOOL)isAutoSelect
                   resultBlock:(nullable TFYDateResultBlock)resultBlock;

/**
 *  3.显示日期选择器
 *
 *   mode             日期显示类型
 *   title            选择器标题
 *   selectValue      默认选中的日期（默认选中当前日期）
 *   minDate          最小日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）
 *   maxDate          最大日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）
 *   isAutoSelect     是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock      选择结果的回调
 *
 */
+ (void)showDatePickerWithMode:(TFYDatePickerMode)mode
                         title:(nullable NSString *)title
                   selectValue:(nullable NSString *)selectValue
                       minDate:(nullable NSDate *)minDate
                       maxDate:(nullable NSDate *)maxDate
                  isAutoSelect:(BOOL)isAutoSelect
                   resultBlock:(nullable TFYDateResultBlock)resultBlock;

/**
 * 3.显示日期选择器
 *
 *  mode             日期显示类型
 *  title            选择器标题
 *  selectValue      默认选中的日期（默认选中当前日期）
 *  minDate          最小日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）
 *  maxDate          最大日期（可使用 NSDate+TFY_PickerView 分类中对应的方法进行创建）
 *  isAutoSelect     是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *  resultBlock      选择结果的回调
 *  resultRangeBlock 范围选择结果的回调
 *
 */
+ (void)showDatePickerWithMode:(TFYDatePickerMode)mode
                         title:(nullable NSString *)title
                   selectValue:(nullable NSString *)selectValue
                       minDate:(nullable NSDate *)minDate
                       maxDate:(nullable NSDate *)maxDate
                  isAutoSelect:(BOOL)isAutoSelect
                   resultBlock:(nullable TFYDateResultBlock)resultBlock
              resultRangeBlock:(nullable TFYDateResultRangeBlock)resultRangeBlock;
@end

NS_ASSUME_NONNULL_END
