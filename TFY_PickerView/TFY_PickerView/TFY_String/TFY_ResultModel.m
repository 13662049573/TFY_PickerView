//
//  TFY_ResultModel.m
//  TFY_PickerView
//
//  Created by 田风有 on 2023/5/4.
//  Copyright © 2023 恋机科技. All rights reserved.
//

#import "TFY_ResultModel.h"

@implementation TFY_ResultModel

/// @param object 目标对象
- (BOOL)isEqual:(id)object {
    // 1.对象的地址相同
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TFY_ResultModel class]]) {
        return NO;
    }
    
    TFY_ResultModel *model = (TFY_ResultModel *)object;
    if (!model) {
        return NO;
    }
    // 2.对象的类型相同，且对象的各个属性相等
    BOOL isSameKey = (!self.key && !model.key) || [self.key isEqualToString:model.key];
    BOOL isSameValue = (!self.value && !model.value) || [self.value isEqualToString:model.value];
    
    return isSameKey && isSameValue;
}

- (NSUInteger)hash {
    return [self.key hash] ^ [self.value hash];
}


@end
