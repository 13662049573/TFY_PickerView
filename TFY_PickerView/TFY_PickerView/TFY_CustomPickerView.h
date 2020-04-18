//
//  TFY_CustomPickerView.h
//  TFY_PickerView
//
//  Created by tiandengyou on 2020/4/17.
//  Copyright © 2020 恋机科技. All rights reserved.
//

#import "TFY_BaseView.h"
#import "TFY_AddressModel.h"

typedef NS_ENUM(NSInteger, TFY_CustomPickerMode) {
    // 只显一组
    TFY_PickerModeOneGroup = 1,
    // 显示二组
    TFY_PickerModeTwoGroup,
    // 显示三组（默认）
    TFY_PickerModeThreeGroup
};

typedef void(^TFY_CustomResultBlock)(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area);
typedef void(^TFY_CustomCancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface TFY_CustomPickerView : TFY_BaseView

/** 自定的文件必须放在--TFY_CityBundle.bundle---里面 模型根据 TFY_City.plist 模型修改，不然没用
 *  显示地址选择器（支持 设置选择器类型、传入地区数据源、设置自动选择、自定义主题颜色、取消选择的回调）
 */
+ (void)showTitle:(NSString *)title pathForResource:(NSString *)resource CustomPickerWithShowType:(TFY_CustomPickerMode)showType dataSource:(NSArray *)dataSource defaultSelected:(NSArray *)defaultSelectedArr isAutoSelect:(BOOL)isAutoSelect themeColor:(UIColor *)themeColor resultBlock:(TFY_CustomResultBlock)resultBlock cancelBlock:(TFY_CustomCancelBlock)cancelBlock;

@end

NS_ASSUME_NONNULL_END
