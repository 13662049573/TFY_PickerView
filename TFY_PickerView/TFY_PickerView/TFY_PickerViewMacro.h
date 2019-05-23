//
//  TFY_PickerViewMacro.h
//  TFY_AutoLMTools
//
//  Created by 田风有 on 2019/5/20.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#ifndef TFY_PickerViewMacro_h
#define TFY_PickerViewMacro_h

// 屏幕大小、宽、高
#ifndef TFY_SCREEN_BOUNDS
#define TFY_SCREEN_BOUNDS [UIScreen mainScreen].bounds
#endif
#ifndef TFY_SCREEN_WIDTH
#define TFY_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
#ifndef TFY_SCREEN_HEIGHT
#define TFY_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

// RGB颜色(16进制)
#define TFY_RGB_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

#define TFY_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define TFY_IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

// 等比例适配系数
#define TFY_kScaleFit (TFY_IS_IPHONE ? ((TFY_SCREEN_WIDTH < TFY_SCREEN_HEIGHT) ? TFY_SCREEN_WIDTH / 375.0f : TFY_SCREEN_WIDTH / 667.0f) : 1.1f)

#define TFY_kPickerHeight 216
#define TFY_kTopViewHeight 44

// 状态栏的高度(20 / 44(iPhoneX))
#define TFY_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define TFY_IS_iPhoneX ((TFY_STATUSBAR_HEIGHT == 44) ? YES : NO)
// 底部安全区域远离高度
#define TFY_BOTTOM_MARGIN ((CGFloat)(TFY_IS_iPhoneX ? 34 : 0))

// 默认主题颜色
#define TFY_kDefaultThemeColor TFY_RGB_HEX(0x464646, 1.0)
// topView视图的背景颜色
#define TFY_kBRToolBarColor TFY_RGB_HEX(0xFDFDFD, 1.0f)

// 静态库中编写 Category 时的便利宏，用于解决 Category 方法从静态库中加载需要特别设置的问题
#ifndef TFY_SYNTH_DUMMY_CLASS

#define TFY_SYNTH_DUMMY_CLASS(_name_) \
@interface TFY_SYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation TFY_SYNTH_DUMMY_CLASS_ ## _name_ @end

#endif

// 过期提醒
#define TFY_PickerViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 打印错误日志
#define TFY_ErrorLog(...) NSLog(@"reason: %@", [NSString stringWithFormat:__VA_ARGS__])

/**
 合成弱引用/强引用
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
//#ifndef weakify
//    #if DEBUG
//        #if __has_feature(objc_arc)
//            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
//        #else
//            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
//        #endif
//    #else
//        #if __has_feature(objc_arc)
//            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
//        #else
//            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
//       #endif
//    #endif
//#endif
//
//#ifndef strongify
//     #if DEBUG
//         #if __has_feature(objc_arc)
//             #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
//         #else
//             #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
//         #endif
//    #else
//          #if __has_feature(objc_arc)
//              #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
//          #else
//              #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
//          #endif
//    #endif
//#endif


#endif /* TFY_PickerViewMacro_h */
