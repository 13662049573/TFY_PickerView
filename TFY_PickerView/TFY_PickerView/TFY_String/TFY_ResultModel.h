//
//  TFY_ResultModel.h
//  TFY_PickerView
//
//  Created by 田风有 on 2023/5/4.
//  Copyright © 2023 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_ResultModel : NSObject

/** key */
@property (nullable, nonatomic, copy) NSString *key;
/** value */
@property (nullable, nonatomic, copy) NSString *value;
/** 父级key（提示：联动时第一级数据，parentKey设置为：@"-1"） */
@property (nullable, nonatomic, copy) NSString *parentKey;
/** 父级value */
@property (nullable, nonatomic, copy) NSString *parentValue;
/** 级别 */
@property (nullable, nonatomic, copy) NSString *level;
/** 子级list */
@property (nullable, nonatomic, copy) NSArray<TFY_ResultModel *> *children;
/** 记录选择的索引位置 */
@property (nonatomic, assign) NSInteger index;

/// 其它扩展字段
@property (nullable, nonatomic, strong) id extras;
@property (nullable, nonatomic, copy) NSString *remark;

@end

NS_ASSUME_NONNULL_END
