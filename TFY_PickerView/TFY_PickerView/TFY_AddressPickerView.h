//
//  TFY_AddressPickerView.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//  使用方法
/*
 第三种：
 [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity defaultSelected:@[@"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
 NSLog(@"地址选择器3--%@ %@ %@",province.code,city.code,area.code);
 } cancelBlock:^{
 
 }];
 第四种
 [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity dataSource:nil defaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
 NSLog(@"地址选择器4--%@ %@ %@",province.code,city.code,area.code);
 } cancelBlock:^{
 
 }];
 */

#import "TFY_BaseView.h"
#import "TFY_AddressModel.h"

typedef NS_ENUM(NSInteger, TFY_AddressPickerMode) {
    // 只显示省
    TFY_AddressPickerModeProvince = 1,
    // 显示省市
    TFY_AddressPickerModeCity,
    // 显示省市区（默认）
    TFY_AddressPickerModeArea
};

typedef void(^TFY_AddressResultBlock)(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area);
typedef void(^TFY_AddressCancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface TFY_AddressPickerView : TFY_BaseView
/**
 *  默认选中的值(传数组，如：@[@"浙江省", @"杭州市", @"西湖区"])
 */
+ (void)showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr
                                 resultBlock:(TFY_AddressResultBlock)resultBlock;
/**
 * 显示地址选择器（支持 设置自动选择 和 自定义主题颜色）defaultSelectedArr  默认选中的值(传数组，如：@[@"浙江省", @"杭州市", @"西湖区"]) isAutoSelect             是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值 themeColor    自定义主题颜色
 */
+ (void)showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr
                                isAutoSelect:(BOOL)isAutoSelect
                                  themeColor:(UIColor *)themeColor
                                 resultBlock:(TFY_AddressResultBlock)resultBlock;
/**
 * 显示地址选择器（支持 设置选择器类型、设置自动选择、自定义主题颜色、取消选择的回调）
 */
+ (void)showAddressPickerWithShowType:(TFY_AddressPickerMode)showType
                      defaultSelected:(NSArray *)defaultSelectedArr
                         isAutoSelect:(BOOL)isAutoSelect
                           themeColor:(UIColor *)themeColor
                          resultBlock:(TFY_AddressResultBlock)resultBlock
                          cancelBlock:(TFY_AddressCancelBlock)cancelBlock;

/**
 *  显示地址选择器（支持 设置选择器类型、传入地区数据源、设置自动选择、自定义主题颜色、取消选择的回调）
 */
+ (void)showAddressPickerWithShowType:(TFY_AddressPickerMode)showType
                           dataSource:(NSArray *)dataSource
                      defaultSelected:(NSArray *)defaultSelectedArr
                         isAutoSelect:(BOOL)isAutoSelect
                           themeColor:(UIColor *)themeColor
                          resultBlock:(TFY_AddressResultBlock)resultBlock
                          cancelBlock:(TFY_AddressCancelBlock)cancelBlock;
@end

NS_ASSUME_NONNULL_END
