//
//  NSBundle+PickerView.h
//  TFY_PickerView
//
//  Created by 田风有 on 2023/5/4.
//  Copyright © 2023 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFY_BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (PickerView)

/// 获取 TFY_PickerView.bundle
+ (instancetype)picker_pickerBundle;

/// 获取国际化后的文本
/// key 代表 Localizable.strings 文件中 key-value 中的 key。
/// language 设置语言（可为空，为nil时将随系统的语言自动改变）
+ (NSString *)picker_localizedStringForKey:(NSString *)key language:(NSString *)language;


@end

NS_ASSUME_NONNULL_END
