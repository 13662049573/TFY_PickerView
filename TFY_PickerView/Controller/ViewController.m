//
//  ViewController.m
//  TFY_PickerView
//
//  Created by 田风有 on 2019/5/22.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "ViewController.h"
#import "TFY_PickerView.H"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     NSArray *arr = @[@"普通选择器1",@"普通选择器2",@"普通选择器3",@"时间选择器1",@"时间选择器2",@"时间选择器3",@"地址选择器1",@"地址选择器2",@"地址选择器3",@"地址选择器4",@"自定义数据模型"];
    
    self.array = [NSMutableArray arrayWithArray:arr];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" resultBlock:^(id  _Nonnull selectValue) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
            
        }];
    }
   if (indexPath.row==1){
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
            
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@",selectValue[0],selectValue[1]];
        }];
    }
     if (indexPath.row==2){
        [TFY_StringPickerView showStringPickerWithTitle:@"选择" dataSource:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] defaultSelValue:@"渣男" isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(id  _Nonnull selectValue) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
            
        } cancelBlock:^{
            NSLog(@"普通选择器3自定义颜色---%@",@"cancel");
        }];
    }
    if (indexPath.row==3){
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYMDHM defaultSelValue:@"" resultBlock:^(NSString * _Nonnull selectValue) {
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
        }];
    }
    if (indexPath.row==4){
        NSDate *minDate = [NSDate tfy_setHour:1 minute:1];
        NSDate *maxDate = [NSDate tfy_setHour:1 minute:1];
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blackColor] resultBlock:^(NSString * _Nonnull selectValue) {
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
        }];
    }
     if (indexPath.row==5){
        NSDate *minDate = [NSDate tfy_setHour:1 minute:10];
        NSDate *maxDate = [NSDate tfy_setHour:33 minute:35];
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeDate defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blueColor] resultBlock:^(NSString * _Nonnull selectValue) {
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
        } cancelBlock:^{
            
        }];
    }
  if (indexPath.row==6){
        [TFY_AddressPickerView showAddressPickerWithDefaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
            
        }];
    }
     if (indexPath.row==7){
        [TFY_AddressPickerView showAddressPickerWithDefaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor brownColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
           ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        }];
    }
    if (indexPath.row==8){
        [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity defaultSelected:@[@"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        } cancelBlock:^{
            
        }];
    }
    if (indexPath.row==9){
        [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity dataSource:@[] defaultSelected:@[@"36", @".50"] isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
            
        } cancelBlock:^{
            
        }];
    }
     if(indexPath.row ==10){
        
        [TFY_CustomPickerView showTitle:@"温度选择" pathForResource:@"TFY_Temp" CustomPickerWithShowType:TFY_PickerModeTwoGroup defaultSelected:@[@"36",@".50"] isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
            
        } cancelBlock:^{
            
        }];
    }
    
    [UIView performWithoutAnimation:^{
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
