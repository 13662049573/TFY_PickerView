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
    
    NSArray *arr = @[@"普通选择器1",@"普通选择器2",@"普通选择器3",@"时间选择器1",@"时间选择器2",@"时间选择器3",@"地址选择器1",@"地址选择器2",@"地址选择器3",@"地址选择器4"];
    
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
        NSArray *dataSource = @[@[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周", @"第6周", @"第7周"], @[@"第1天", @"第2天", @"第3天", @"第4天", @"第5天", @"第6天", @"第7天"]];
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:dataSource defaultSelValue:@"第5周" isAutoSelect:YES themeColor:[UIColor greenColor] resultBlock:^(id  _Nonnull selectValue) {
            NSLog(@"普通选择器2自定义颜色---%@",selectValue[0]);
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
        
    }
    else if (btn.tag==4){
        
    }
    else if (btn.tag==5){
        
    }
    else if (btn.tag==6){
        
    }
    else if (btn.tag==7){
        
    }
    else if (btn.tag==8){
        
    }else if (btn.tag==9){
        
    }
}
@end
