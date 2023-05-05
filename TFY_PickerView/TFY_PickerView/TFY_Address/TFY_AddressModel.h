//
//  TFY_AddressModel.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/17.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 省
@interface TFY_ProvinceModel : NSObject
/** 省对应的code或id */
@property (nullable, nonatomic, copy) NSString *code;
/** 省的名称 */
@property (nullable, nonatomic, copy) NSString *name;
/** 城市数组 */
@property (nullable, nonatomic, copy) NSArray *citylist;
/** 记录省选择的索引位置 */
@property (nonatomic, assign) NSInteger index;

@end

/// 市
@interface TFY_CityModel : NSObject
/** 市对应的code或id */
@property (nullable, nonatomic, copy) NSString *code;
/** 市的名称 */
@property (nullable, nonatomic, copy) NSString *name;
/** 地区数组 */
@property (nullable, nonatomic, copy) NSArray *arealist;
/** 记录市选择的索引位置 */
@property (nonatomic, assign) NSInteger index;

@end

/// 区
@interface TFY_AreaModel : NSObject
/** 区对应的code或id */
@property (nullable, nonatomic, copy) NSString *code;
/** 区的名称 */
@property (nullable, nonatomic, copy) NSString *name;
/** 记录区选择的索引位置 */
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
