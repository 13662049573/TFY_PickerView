# TFY_PickerView

下载使用： pod 'TFY_PickerView'  普通选择器，时间选择器，省市县选择器

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
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeYMDHM defaultSelValue:@"" resultBlock:^(NSString * _Nonnull selectValue) {
            NSLog(@"时间选择器1---%@",selectValue);
        }];
    }
    else if (btn.tag==4){
        NSDate *minDate = [NSDate tfy_setHour:8 minute:10];
        NSDate *maxDate = [NSDate tfy_setHour:20 minute:35];
        [TFY_DatePickerView showDatePickerWithTitle:@"选择" dateType:TFY_DatePickerModeDateAndTime defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:[UIColor blackColor] resultBlock:^(NSString * _Nonnull selectValue) {
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
        [TFY_AddressPickerView showAddressPickerWithShowType:TFY_AddressPickerModeCity dataSource:nil defaultSelected:@[@"浙江省", @"杭州市", @"西湖区"] isAutoSelect:NO themeColor:[UIColor blueColor] resultBlock:^(TFY_AddressModel * _Nonnull province, CityModel * _Nonnull city, AreaModel * _Nonnull area) {
            NSLog(@"地址选择器4--%@ %@ %@",province.code,city.code,area.code);
        } cancelBlock:^{
            
        }];
    }
}
