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
    
     NSArray *arr = @[@"普通选择器1",@"普通选择器2",@"普通选择器3",@"时间选择器1",@"时间选择器2",@"时间选择器3",@"地址选择器1",@"地址选择器2",@"地址选择器3"];
    
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
        [TFY_StringPickerView showPickerWithTitle:@"选择" dataSourceArr:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] selectIndex:2 resultBlock:^(TFY_ResultModel * _Nullable resultModel) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = resultModel.value;
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
       [TFY_StringPickerView showMultiPickerWithTitle:@"选择" dataSourceArr:array selectIndexs:@[@1,@3] resultBlock:^(NSArray<TFY_ResultModel *> * _Nullable resultModelArr) {
           ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@",resultModelArr.firstObject.value,resultModelArr.lastObject.value];
       }];
    }
     if (indexPath.row==2){
         [TFY_StringPickerView showPickerWithTitle:@"选择" dataSourceArr:@[@"男",@"女",@"渣男",@"渣女",@"小姐姐",@"小哥哥",@"其他"] selectIndex:1 resultBlock:^(TFY_ResultModel * _Nullable resultModel) {
             
             ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = resultModel.value;
         }];
    }
    if (indexPath.row==3){
        [TFY_DatePickerView showDatePickerWithMode:TFYDatePickerModeYMD title:@"选择" selectValue:@"" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
        }];
    }
    if (indexPath.row==4){
        NSDate *minDate = [NSDate picker_setHour:1 minute:1];
        NSDate *maxDate = [NSDate picker_setHour:1 minute:1];
        [TFY_DatePickerView showDatePickerWithMode:TFYDatePickerModeYM title:@"选择" selectValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
        }];
    }
     if (indexPath.row==5){
         [TFY_DatePickerView showDatePickerWithMode:TFYDatePickerModeDateAndTime title:@"选择" selectValue:@"" resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
             ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = selectValue;
         }];
    }
  if (indexPath.row==6){
      [TFY_AddressPickerView showAddressPickerWithMode:TFYAddressPickerModeArea selectIndexs:@[@1,@3] isAutoSelect:YES resultBlock:^(TFY_ProvinceModel * _Nullable province, TFY_CityModel * _Nullable city, TFY_AreaModel * _Nullable area) {
          ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
      }];
    }
     if (indexPath.row==7){
         [TFY_AddressPickerView showAddressPickerWithMode:TFYAddressPickerModeCity selectIndexs:@[@1,@3] isAutoSelect:YES resultBlock:^(TFY_ProvinceModel * _Nullable province, TFY_CityModel * _Nullable city, TFY_AreaModel * _Nullable area) {
             ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
         }];
    }
    if (indexPath.row==8){
        [TFY_AddressPickerView showAddressPickerWithMode:TFYAddressPickerModeProvince selectIndexs:@[@1,@3] isAutoSelect:YES resultBlock:^(TFY_ProvinceModel * _Nullable province, TFY_CityModel * _Nullable city, TFY_AreaModel * _Nullable area) {
            ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
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
