//
//  TFY_AddressPickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法


#import "TFY_BaseView.h"
#import "TFY_AddressModel.h"

/// 地址选择器类型
typedef NS_ENUM(NSInteger, TFYAddressPickerMode) {
    /** 显示【省市区】（默认） */
    TFYAddressPickerModeArea,
    /** 显示【省市】 */
    TFYAddressPickerModeCity,
    /** 显示【省】 */
    TFYAddressPickerModeProvince
};

typedef void(^TFYAddressResultBlock)(TFY_ProvinceModel * _Nullable province, TFY_CityModel * _Nullable city, TFY_AreaModel * _Nullable area);

NS_ASSUME_NONNULL_BEGIN

@interface TFY_AddressPickerView : TFY_BaseView
/**
 //////////////////////////////////////////////////////////////////////////
 ///
 ///   【用法一】
 ///    特点：灵活，扩展性强（推荐使用！）
 ///
 ////////////////////////////////////////////////////////////////////////*/

/** 地址选择器显示类型 */
@property (nonatomic, assign) TFYAddressPickerMode pickerMode;

/** 默认选中的位置(1.传索引数组，如：@[@10, @0, @4]) */
@property (nullable, nonatomic, copy) NSArray <NSNumber *> *selectIndexs;
/** 默认选中的位置(2.传值数组，如：@[@"浙江省", @"杭州市", @"西湖区"]) */
@property (nullable, nonatomic, copy) NSArray <NSString *> *selectValues;

/** 选择结果的回调 */
@property (nullable, nonatomic, copy) TFYAddressResultBlock resultBlock;

/** 滚动选择时触发的回调 */
@property (nullable, nonatomic, copy) TFYAddressResultBlock changeBlock;

/**
 *  地区数据源（不传或为nil，默认就获取本地 TFY_City.json 文件的数据）
 *  1.可以传 JSON数组，要注意 层级结构 和 key 要与 TFY_City.json 保持一致
 *  2.可以传 模型数组(NSArray <TFY_ProvinceModel *> * 类型)，自己解析数据源 只需要注意层级结构就行
 */
@property (nullable, nonatomic, copy) NSArray *dataSourceArr;

/// 初始化地址选择器
///  pickerMode 地址选择器显示类型
- (instancetype)initWithPickerMode:(TFYAddressPickerMode)pickerMode;

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
 *  1.显示地址选择器
 *
 *   selectIndexs             默认选中的值(传索引数组，如：@[@10, @0, @4])
 *   resultBlock              选择后的回调
 *
 */
+ (void)showAddressPickerWithSelectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                              resultBlock:(nullable TFYAddressResultBlock)resultBlock;

/**
 *  2.显示地址选择器
 *
 *   mode                     地址选择器显示类型
 *   selectIndexs             默认选中的值(传索引数组，如：@[@10, @0, @4])
 *   isAutoSelect             是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock              选择后的回调
 *
 */
+ (void)showAddressPickerWithMode:(TFYAddressPickerMode)mode
                     selectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                     isAutoSelect:(BOOL)isAutoSelect
                      resultBlock:(nullable TFYAddressResultBlock)resultBlock;

/**
 *  3.显示地址选择器
 *
 *   mode                     地址选择器显示类型
 *   dataSource               地区数据源
 *   selectIndexs             默认选中的值(传索引数组，如：@[@10, @0, @4])
 *   isAutoSelect             是否自动选择，即滚动选择器后就执行结果回调，默认为 NO
 *   resultBlock              选择后的回调
 *
 */
+ (void)showAddressPickerWithMode:(TFYAddressPickerMode)mode
                       dataSource:(nullable NSArray *)dataSource
                     selectIndexs:(nullable NSArray <NSNumber *> *)selectIndexs
                     isAutoSelect:(BOOL)isAutoSelect
                      resultBlock:(nullable TFYAddressResultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
