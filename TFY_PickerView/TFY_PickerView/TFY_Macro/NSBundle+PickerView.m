//
//  NSBundle+PickerView.m
//  TFY_PickerView
//
//  Created by 田风有 on 2023/5/4.
//  Copyright © 2023 恋机科技. All rights reserved.
//

#import "NSBundle+PickerView.h"


TFYSYNTH_DUMMY_CLASS(NSBundle_PickerView)

@implementation NSBundle (PickerView)

#pragma mark - 获取 TFY_PickerView.bundle
+ (instancetype)picker_pickerBundle {
    static NSBundle *pickerBundle = nil;
    if (!pickerBundle) {
        /*
            先拿到最外面的 bundle。
            对 framework 链接方式来说就是 framework 的 bundle 根目录，
            对静态库链接方式来说就是 target client 的 main bundle，
            然后再去找下面名为 TFY_PickerView 的 bundle 对象。
         */
        NSBundle *bundle = [NSBundle bundleForClass:[TFY_BaseView class]];
        NSURL *url = [bundle URLForResource:@"TFY_PickerView" withExtension:@"bundle"];
        pickerBundle = [NSBundle bundleWithURL:url];
    }
    return pickerBundle;
}

#pragma mark - 获取国际化后的文本
+ (NSString *)picker_localizedStringForKey:(NSString *)key language:(NSString *)language {
    return [self picker_localizedStringForKey:key value:nil language:language];
}

+ (NSString *)picker_localizedStringForKey:(NSString *)key value:(NSString *)value language:(NSString *)language {
    static NSBundle *bundle = nil;
    if (!bundle) {
        // 如果没有手动设置语言，将随系统的语言自动改变
        if (!language) {
            // 系统首选语言
            language = [NSLocale preferredLanguages].firstObject;
        }
        
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant、zh-HK、zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
        
        // 从 TFY_PickerView.bundle 中查找资源
        bundle = [NSBundle bundleWithPath:[[self picker_pickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end
