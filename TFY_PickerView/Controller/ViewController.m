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
        btn.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10+i*50);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDragInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag==0) {
        
    }
    else if (btn.tag==1){
        
    }
    else if (btn.tag==2){
        
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
