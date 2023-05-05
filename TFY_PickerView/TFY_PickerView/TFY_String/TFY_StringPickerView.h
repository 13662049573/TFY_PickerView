//
//  TFY_StringPickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法如下：

#import "TFY_BaseView.h"
#import "TFY_ResultModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 字符串选择器类型
typedef NS_ENUM(NSInteger, TFYStringPickerMode) {
    /** 单列选择器 */
    TFYStringPickerComponentSingle,
    /** 多列选择器 */
    TFYStringPickerComponentMulti,
    /** 多级联动选择器 */
    TFYStringPickerComponentLinkage
};

typedef void(^TFYStringResultModelBlock)(TFY_ResultModel * _Nullable resultModel);

typedef void(^TFYStringResultModelArrayBlock)(NSArray <TFY_ResultModel *> * _Nullable resultModelArr);

@interface TFY_StringPickerView : TFY_BaseView
/**
 //////////////////////////////////////////////////////////////////////////
 ///
 ///   【用法一】
 ///    特点：灵活，扩展性强（推荐使用！）
 ///
 ////////////////////////////////////////////////////////////////////////*/

/** 字符串选择器显示类型 */
@property (nonatomic, assign) TFYStringPickerMode pickerMode;

/**
 *  1.设置数据源
 *    单列：@[@"男", @"女", @"其他"]，或直接传一维模型数组(NSArray <TFY_ResultModel *>*)
 *    多列：@[@[@"语文", @"数学", @"英语"], @[@"优秀", @"良好"]]，或直接传多维模型数组
 *    联动：直接传一维模型数组(NSArray <TFY_ResultModel *>*)，要注意数据源联动格式，可参考Demo
 */
@property (nullable, nonatomic, copy) NSArray *dataSourceArr;
/**
 *  2.设置数据源
 *    直接传plist文件名：NSString类型（如：@"test.plist"），要带后缀名
 *    场景：可以将数据源数据（数组类型）放到plist文件中，直接传plist文件名更加简单
 */
@property (nullable, nonatomic, copy) NSString *plistName;

/**
 *  设置默认选中的位置【单列】
 *  推荐使用 selectIndex，更加严谨，可以避免使用 selectValue 时，有名称相同的情况
 */
@property (nonatomic, assign) NSInteger selectIndex;
@property (nullable, nonatomic, copy) NSString *selectValue;

/**
 *  设置默认选中的位置【多列】
 *  推荐使用 selectIndexs，更加严谨，可以避免使用 selectValues 时，有名称相同的情况
 */
@property (nullable, nonatomic, copy) NSArray <NSNumber *> *selectIndexs;
@property (nullable, nonatomic, copy) NSArray <NSString *> *selectValues;

/** 选择结果的回调【单列】 */
@property (nullable, nonatomic, copy) TFYStringResultModelBlock resultModelBlock;
/** 选择结果的回调【多列】 */
@property (nullable, nonatomic, copy) TFYStringResultModelArrayBlock resultModelArrayBlock;

/** 滚动选择时触发的回调【单列】 */
@property (nullable, nonatomic, copy) TFYStringResultModelBlock changeModelBlock;
/** 滚动选择时触发的回调【多列】 */
@property (nullable, nonatomic, copy) TFYStringResultModelArrayBlock changeModelArrayBlock;

/**
 *  最大层级数(列数) for `TFYStringPickerComponentLinkage`, ignored otherwise.
 *  使用场景：默认可选，当数据源中有 key 等于 parentKey 情况时，必须要设置
 */
@property (nonatomic, assign) NSInteger numberOfComponents;

/// 初始化字符串选择器
///  pickerMode 字符串选择器显示类型
- (instancetype)initWithPickerMode:(TFYStringPickerMode)pickerMode;

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
 *  1.显示【单列】选择器
 *
 *   title               选择器标题
 *   dataSourceArr       数据源，格式：@[@"男", @"女", @"其他"]，或直接传一维模型数组(NSArray <TFY_ResultModel *>*)
 *   selectIndex         默认选中的位置
 *   resultBlock         选择后的回调
 *
 */
+ (void)showPickerWithTitle:(nullable NSString *)title
              dataSourceArr:(nullable NSArray *)dataSourceArr
                selectIndex:(NSInteger)selectIndex
                resultBlock:(nullable TFYStringResultModelBlock)resultBlock;

/**
 *  2.显示【单列】选择器
 *
 *   title               选择器标题
 *   dataSourceArr       数据源（如：@[@"男", @"女", @"其他"]，或直接传模型数组）
 *   selectIndex         默认选中的位置
 *   isAutoSelect        是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock         选择后的回调
 *
 */
+ (void)showPickerWithTitle:(nullable NSString *)title
              dataSourceArr:(nullable NSArray *)dataSourceArr
                selectIndex:(NSInteger)selectIndex
               isAutoSelect:(BOOL)isAutoSelect
                resultBlock:(nullable TFYStringResultModelBlock)resultBlock;

/**
 *  3.显示【多列】选择器
 *
 *   title               选择器标题
 *   dataSourceArr       数据源，格式：@[@[@"语文", @"数学", @"英语"], @[@"优秀", @"良好"]]，或直接传多维模型数组
 *   selectIndexs        默认选中的位置（传索引数组，如：@[@2, @1]）
 *   resultBlock         选择后的回调
 *
 */
+ (void)showMultiPickerWithTitle:(nullable NSString *)title
                   dataSourceArr:(nullable NSArray *)dataSourceArr
                    selectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                     resultBlock:(nullable TFYStringResultModelArrayBlock)resultBlock;

/**
 *  4.显示【多列】选择器
 *
 *   title               选择器标题
 *   dataSourceArr       数据源，格式：@[@[@"语文", @"数学", @"英语"], @[@"优秀", @"良好"]]，或直接传多维模型数组
 *   selectIndexs        默认选中的位置（传索引数组，如：@[@2, @1]）
 *   isAutoSelect        是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock         选择后的回调
 *
 */
+ (void)showMultiPickerWithTitle:(nullable NSString *)title
                   dataSourceArr:(nullable NSArray *)dataSourceArr
                    selectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                    isAutoSelect:(BOOL)isAutoSelect
                     resultBlock:(nullable TFYStringResultModelArrayBlock)resultBlock;

/**
 *  5.显示【联动】选择器
 *
 *   title               选择器标题
 *   dataSourceArr       数据源，格式：直接传一维模型数组(NSArray <TFY_ResultModel *>*)
 *   selectIndexs        默认选中的位置（传索引数组，如：@[@2, @1]）
 *   isAutoSelect        是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock         选择后的回调
 *
 */
+ (void)showLinkagePickerWithTitle:(nullable NSString *)title
                     dataSourceArr:(nullable NSArray *)dataSourceArr
                      selectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                      isAutoSelect:(BOOL)isAutoSelect
                       resultBlock:(nullable TFYStringResultModelArrayBlock)resultBlock;
@end

NS_ASSUME_NONNULL_END
