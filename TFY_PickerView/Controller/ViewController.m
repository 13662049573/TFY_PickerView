//
//  ViewController.m
//  TFY_PickerView
//
//  Created by 田风有 on 2019/5/22.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "ViewController.h"
#import "TFY_PickerHeader.H"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSArray *arr = @[@"普通选择器1",@"普通选择器2",@"普通选择器3",@"时间选择器1",@"时间选择器2",@"时间选择器3",@"地址选择器1",@"地址选择器2",@"地址选择器3",@"地址选择器4",@"自定义数据模型"];
    
    for (NSInteger i =0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, 100+i*60, [UIScreen mainScreen].bounds.size.width, 50);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    NSLog(@"**************************************");
    if (btn.tag==0) {
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" resultBlock:^(id  _Nonnull selectValue) {
            
            NSLog(@"普通选择器1---%@",selectValue);
            
        }];
    }
    else if (btn.tag==1){
       NSMutableArray *array2 = [NSMutableArray array];
        NSMutableArray *array3 = [NSMutableArray array];
         
        for (NSInteger i = 30; i<=150; i++) {
            NSString *string = [NSString stringWithFormat:@"%ld",i];
            [array2 addObject:string];
        }
        for (NSInteger i = 0; i<=200; i++) {
            NSString *string = [NSString stringWithFormat:@".%ldKG",i];
            [array3 addObject:string];
        }
        NSMutableArray *array = [NSMutableArray arrayWithObjects: array2,array3, nil];
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:array defaultSelValue:@[@"50",@".50"] isAutoSelect:YES themeColor:[UIColor greenColor] resultBlock:^(id  _Nonnull selectValue) {
            NSLog(@"普通选择器2自定义颜色---%@  -- %@",selectValue[0],selectValue[1]);
        }];
    }
    else if (btn.tag==2){
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(id  _Nonnull selectValue) {
            
            NSLog(@"普通选择器3自定义颜色---%@",selectValue);
            
        } cancelBlock:^{
            NSLog(@"普通选择器3自定义颜色---%@",@"cancel");
        }];
    }
    else if (btn.tag==3){
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYMDHM defaultSelValue:@"" resultBlock:^(NSString * _Nonnull selectValue) {
            NSLog(@"时间选择器1---%@",selectValue);
        }];
    }
    else if (btn.tag==4){
        NSDate *minDate = [NSDate tfy_setHour:1 minute:1];
        NSDate *maxDate = [NSDate tfy_setHour:1 minute:1];
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blackColor] resultBlock:^(NSString * _Nonnull selectValue) {
            NSLog(@"时间选择器2---%@",selectValue);
        }];
    }
    else if (btn.tag==5){
        NSDate *minDate = [NSDate tfy_setHour:1 minute:10];
        NSDate *maxDate = [NSDate tfy_setHour:33 minute:35];
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeDate defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blueColor] resultBlock:^(NSString * _Nonnull selectValue) {
            NSLog(@"时间选择器3---%@",selectValue);
        } cancelBlock:^{
            
        }];
    }
    else if (btn.tag==6){
        [TFY_AddressPickerView showAddressPickerWithDefaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            NSLog(@"地址选择器1---%@ %@ %@",province.code,city.code,area.code);
            
        }];
    }
    else if (btn.tag==7){
        [TFY_AddressPickerView showAddressPickerWithDefaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor brownColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            NSLog(@"地址选择器2--%@ %@ %@",province.code,city.code,area.code);
        }];
    }
    else if (btn.tag==8){
        [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity defaultSelected:@[@"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            NSLog(@"地址选择器3--%@ %@ %@",province.code,city.code,area.code);
        } cancelBlock:^{
            
        }];
    }else if (btn.tag==9){
        [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity dataSource:@[] defaultSelected:@[@"36", @".50"] isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            NSLog(@"地址选择器4--%@ %@ %@",province.name,city.name,area.name);
            
        } cancelBlock:^{
            
        }];
    }
    else if(btn.tag ==10){
        
        [TFY_CustomPickerView showTitle:@"温度选择" pathForResource:@"TFY_Temp" CustomPickerWithShowType:TFY_PickerModeTwoGroup defaultSelected:@[@"36",@".50"] isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            NSLog(@"自定义--%@ %@ %@",province.name,city.name,area.name);
            
        } cancelBlock:^{
            
        }];
    }
}
@end
