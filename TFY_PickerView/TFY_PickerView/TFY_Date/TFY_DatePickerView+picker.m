//
//  TFY_DatePickerView+picker.m
//  TFY_PickerView
//
//  Created by 田风有 on 2023/5/4.
//  Copyright © 2023 恋机科技. All rights reserved.
//

#import "TFY_DatePickerView+picker.h"
#import "NSBundle+PickerView.h"

TFYSYNTH_DUMMY_CLASS(TFY_DatePickerView_picker)

@implementation TFY_DatePickerView (picker)

#pragma mark - 最小日期
- (NSDate *)handlerMinDate:(NSDate *)minDate {
    if (!minDate) {
        if (self.pickerMode == TFYDatePickerModeMDHM) {
            minDate = [NSDate picker_setMonth:1 day:1 hour:0 minute:0];
        } else if (self.pickerMode == TFYDatePickerModeMD) {
            minDate = [NSDate picker_setMonth:1 day:1];
        } else if (self.pickerMode == TFYDatePickerModeTime || self.pickerMode == TFYDatePickerModeCountDownTimer || self.pickerMode == TFYDatePickerModeHM) {
            minDate = [NSDate picker_setHour:0 minute:0];
        } else if (self.pickerMode == TFYDatePickerModeHMS) {
            minDate = [NSDate picker_setHour:0 minute:0 second:0];
        } else if (self.pickerMode == TFYDatePickerModeMS) {
            minDate = [NSDate picker_setMinute:0 second:0];
        } else {
            minDate = [NSDate distantPast]; // 遥远的过去的一个时间点
        }
    }
    return minDate;
}

#pragma mark - 最大日期
- (NSDate *)handlerMaxDate:(NSDate *)maxDate {
    if (!maxDate) {
        if (self.pickerMode == TFYDatePickerModeMDHM) {
            maxDate = [NSDate picker_setMonth:12 day:31 hour:23 minute:59];
        } else if (self.pickerMode == TFYDatePickerModeMD) {
            maxDate = [NSDate picker_setMonth:12 day:31];
        } else if (self.pickerMode == TFYDatePickerModeTime || self.pickerMode == TFYDatePickerModeCountDownTimer || self.pickerMode == TFYDatePickerModeHM) {
            maxDate = [NSDate picker_setHour:23 minute:59];
        } else if (self.pickerMode == TFYDatePickerModeHMS) {
            maxDate = [NSDate picker_setHour:23 minute:59 second:59];
        } else if (self.pickerMode == TFYDatePickerModeMS) {
            maxDate = [NSDate picker_setMinute:59 second:59];
        } else {
            maxDate = [NSDate distantFuture]; // 遥远的未来的一个时间点
        }
    }
    return maxDate;
}

#pragma mark - 默认选中的日期
- (NSDate *)handlerSelectDate:(NSDate *)selectDate dateFormat:(NSString *)dateFormat {
    // selectDate 优先级高于 selectValue（推荐使用 selectDate 设置默认选中的日期）
    if (!selectDate) {
        if (self.selectValue && self.selectValue.length > 0) {
            if (self.pickerMode == TFYDatePickerModeYMDH && self.isShowAMAndPM) {
                NSString *firstString = [[self.selectValue componentsSeparatedByString:@" "] firstObject];
                NSString *lastString = [[self.selectValue componentsSeparatedByString:@" "] lastObject];
                if ([lastString isEqualToString:[self getAMText]]) {
                    self.selectValue = [NSString stringWithFormat:@"%@ 00", firstString];
                }
                if ([lastString isEqualToString:[self getPMText]]) {
                    self.selectValue = [NSString stringWithFormat:@"%@ 12", firstString];
                }
            }
            
            NSDate *date = nil;
            if ([self.selectValue isEqualToString:self.lastRowContent]) {
                date = self.addToNow ? [NSDate date] : nil;
            } else if ([self.selectValue isEqualToString:self.firstRowContent]) {
                date = nil;
            } else {
                date = [self picker_dateFromString:self.selectValue dateFormat:dateFormat];
                if (!date) {
                    TFYErrorLog(@"参数异常！字符串 selectValue 的正确格式是：%@", dateFormat);
                    NSAssert(date, @"参数异常！请检查字符串 selectValue 的格式");
                    date = [NSDate date]; // 默认值参数格式错误时，重置/忽略默认值，防止在 Release 环境下崩溃！
                }
                if (self.pickerMode == TFYDatePickerModeMDHM) {
                    selectDate = [NSDate picker_setMonth:date.picker_month day:date.picker_day hour:date.picker_hour minute:date.picker_minute];
                } else if (self.pickerMode == TFYDatePickerModeMD) {
                    selectDate = [NSDate picker_setMonth:date.picker_month day:date.picker_day];
                } else if (self.pickerMode == TFYDatePickerModeTime || self.pickerMode == TFYDatePickerModeCountDownTimer || self.pickerMode == TFYDatePickerModeHM) {
                    selectDate = [NSDate picker_setHour:date.picker_hour minute:date.picker_minute];
                } else if (self.pickerMode == TFYDatePickerModeHMS) {
                    selectDate = [NSDate picker_setHour:date.picker_hour minute:date.picker_minute second:date.picker_second];
                } else if (self.pickerMode == TFYDatePickerModeMS) {
                    selectDate = [NSDate picker_setMinute:date.picker_minute second:date.picker_second];
                } else {
                    selectDate = date;
                }
            }
        } else {
            // 不设置默认日期
            if (self.pickerMode == TFYDatePickerModeTime ||
                self.pickerMode == TFYDatePickerModeCountDownTimer ||
                self.pickerMode == TFYDatePickerModeHM ||
                self.pickerMode == TFYDatePickerModeHMS ||
                self.pickerMode == TFYDatePickerModeMS) {
                // 默认选中最小日期
                selectDate = self.minDate;
            } else {
                if (self.minuteInterval > 1 || self.secondInterval > 1) {
                    NSDate *date = [NSDate date];
                    NSInteger minute = self.minDate.picker_minute % self.minuteInterval == 0 ? self.minDate.picker_minute : 0;
                    NSInteger second = self.minDate.picker_second % self.secondInterval == 0 ? self.minDate.picker_second : 0;
                    selectDate = [NSDate picker_setYear:date.picker_year month:date.picker_month day:date.picker_day hour:date.picker_hour minute:minute second:second];
                } else {
                    // 默认选中今天的日期
                    selectDate = [NSDate date];
                }
            }
        }
    }
    
    // 判断日期是否超过边界限制
    BOOL selectLessThanMin = [self picker_compareDate:selectDate targetDate:self.minDate dateFormat:dateFormat] == NSOrderedAscending;
    BOOL selectMoreThanMax = [self picker_compareDate:selectDate targetDate:self.maxDate dateFormat:dateFormat] == NSOrderedDescending;
    if (selectLessThanMin) {
        TFYErrorLog(@"默认选择的日期不能小于最小日期！");
        selectDate = self.minDate;
    }
    if (selectMoreThanMax) {
        TFYErrorLog(@"默认选择的日期不能大于最大日期！");
        selectDate = self.maxDate;
    }
    
    return selectDate;
}

#pragma mark - NSDate 转 NSString
- (NSString *)picker_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    return [NSDate picker_stringFromDate:date dateFormat:dateFormat timeZone:self.timeZone language:self.pickerStyle.language];
}

#pragma mark - NSString 转 NSDate
- (NSDate *)picker_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    return [NSDate picker_dateFromString:dateString dateFormat:dateFormat timeZone:self.timeZone language:self.pickerStyle.language];
}

#pragma mark - 比较两个日期大小（可以指定比较级数，即按指定格式进行比较）
- (NSComparisonResult)picker_compareDate:(NSDate *)date targetDate:(NSDate *)targetDate dateFormat:(NSString *)dateFormat {
    NSString *dateString1 = [self picker_stringFromDate:date dateFormat:dateFormat];
    NSString *dateString2 = [self picker_stringFromDate:targetDate dateFormat:dateFormat];
    NSDate *date1 = [self picker_dateFromString:dateString1 dateFormat:dateFormat];
    NSDate *date2 = [self picker_dateFromString:dateString2 dateFormat:dateFormat];
    if ([date1 compare:date2] == NSOrderedDescending) {
        return 1; // 大于
    } else if ([date1 compare:date2] == NSOrderedAscending) {
        return -1; // 小于
    } else {
        return 0; // 等于
    }
}

#pragma mark - 获取 yearArr 数组
- (NSArray *)getYearArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = self.minDate.picker_year; i <= self.maxDate.picker_year; i++) {
        [tempArr addObject:[self getYearNumber:i]];
    }
    if (self.isDescending) {
        NSArray *reversedArr = [[tempArr reverseObjectEnumerator] allObjects];
        tempArr = [reversedArr mutableCopy];
    }
    // 判断是否需要添加【自定义字符串】
    if (self.lastRowContent || self.firstRowContent) {
        switch (self.pickerMode) {
            case TFYDatePickerModeYMDHMS:
            case TFYDatePickerModeYMDHM:
            case TFYDatePickerModeYMDH:
            case TFYDatePickerModeYMD:
            case TFYDatePickerModeYM:
            case TFYDatePickerModeY:
            {
                if (self.lastRowContent) {
                    [tempArr addObject:self.lastRowContent];
                }
                if (self.firstRowContent) {
                    [tempArr insertObject:self.firstRowContent atIndex:0];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 monthArr 数组
- (NSArray *)getMonthArr:(NSInteger)year {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    if (year == self.minDate.picker_year) {
        startMonth = self.minDate.picker_month;
    }
    if (year == self.maxDate.picker_year) {
        endMonth = self.maxDate.picker_month;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        NSArray *reversedArr = [[tempArr reverseObjectEnumerator] allObjects];
        tempArr = [reversedArr mutableCopy];
    }
    // 判断是否需要添加【自定义字符串】
    if (self.lastRowContent || self.firstRowContent) {
        switch (self.pickerMode) {
            case TFYDatePickerModeMDHM:
            case TFYDatePickerModeMD:
            {
                if (self.lastRowContent) {
                    [tempArr addObject:self.lastRowContent];
                }
                if (self.firstRowContent) {
                    [tempArr insertObject:self.firstRowContent atIndex:0];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 dayArr 数组
- (NSArray *)getDayArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startDay = 1;
    NSInteger endDay = [NSDate picker_getDaysInYear:year month:month];
    if (year == self.minDate.picker_year && month == self.minDate.picker_month) {
        startDay = self.minDate.picker_day;
    }
    if (year == self.maxDate.picker_year && month == self.maxDate.picker_month) {
        endDay = self.maxDate.picker_day;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        return [[tempArr reverseObjectEnumerator] allObjects];
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 hourArr 数组
- (NSArray *)getHourArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    if (self.pickerMode == TFYDatePickerModeYMDH && self.isShowAMAndPM) {
        return @[[self getAMText], [self getPMText]];
    }
    
    NSInteger startHour = 0;
    NSInteger endHour = 23;
    if (year == self.minDate.picker_year && month == self.minDate.picker_month && day == self.minDate.picker_day) {
        startHour = self.minDate.picker_hour;
    }
    if (year == self.maxDate.picker_year && month == self.maxDate.picker_month && day == self.maxDate.picker_day) {
        endHour = self.maxDate.picker_hour;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startHour; i <= endHour; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        NSArray *reversedArr = [[tempArr reverseObjectEnumerator] allObjects];
        tempArr = [reversedArr mutableCopy];
    }
    // 判断是否需要添加【自定义字符串】
    if (self.lastRowContent || self.firstRowContent) {
        switch (self.pickerMode) {
            case TFYDatePickerModeHMS:
            case TFYDatePickerModeHM:
            {
                if (self.lastRowContent) {
                    [tempArr addObject:self.lastRowContent];
                }
                if (self.firstRowContent) {
                    [tempArr insertObject:self.firstRowContent atIndex:0];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 minuteArr 数组
- (NSArray *)getMinuteArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    NSInteger startMinute = 0;
    NSInteger endMinute = 59;
    if (year == self.minDate.picker_year && month == self.minDate.picker_month && day == self.minDate.picker_day && hour == self.minDate.picker_hour) {
        startMinute = self.minDate.picker_minute;
    }
    if (year == self.maxDate.picker_year && month == self.maxDate.picker_month && day == self.maxDate.picker_day && hour == self.maxDate.picker_hour) {
        endMinute = self.maxDate.picker_minute;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startMinute; i <= endMinute; i += self.minuteInterval) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        NSArray *reversedArr = [[tempArr reverseObjectEnumerator] allObjects];
        tempArr = [reversedArr mutableCopy];
    }
    // 判断是否需要添加【自定义字符串】
    if (self.lastRowContent || self.firstRowContent) {
        switch (self.pickerMode) {
            case TFYDatePickerModeMS:
            {
                if (self.lastRowContent) {
                    [tempArr addObject:self.lastRowContent];
                }
                if (self.firstRowContent) {
                    [tempArr insertObject:self.firstRowContent atIndex:0];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 secondArr 数组
- (NSArray *)getSecondArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    NSInteger startSecond = 0;
    NSInteger endSecond = 59;
    if (year == self.minDate.picker_year && month == self.minDate.picker_month && day == self.minDate.picker_day && hour == self.minDate.picker_hour && minute == self.minDate.picker_minute) {
        startSecond = self.minDate.picker_second;
    }
    if (year == self.maxDate.picker_year && month == self.maxDate.picker_month && day == self.maxDate.picker_day && hour == self.maxDate.picker_hour && minute == self.maxDate.picker_minute) {
        endSecond = self.maxDate.picker_second;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startSecond; i <= endSecond; i += self.secondInterval) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        return [[tempArr reverseObjectEnumerator] allObjects];
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 monthWeekArr 数组
- (NSArray *)getMonthWeekArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startWeek = 1;
    NSInteger endWeek = [NSDate picker_getWeeksOfMonthInYear:year month:month];
    if (year == self.minDate.picker_year && month == self.minDate.picker_month) {
        startWeek = self.minDate.picker_monthWeek;
    }
    if (year == self.maxDate.picker_year && month == self.maxDate.picker_month) {
        endWeek = self.maxDate.picker_monthWeek;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startWeek; i <= endWeek; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        return [[tempArr reverseObjectEnumerator] allObjects];
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 yearWeekArr 数组
- (NSArray *)getYearWeekArr:(NSInteger)year {
    NSInteger startWeek = 1;
    NSInteger endWeek = [NSDate picker_getWeeksOfYearInYear:year];
    if (year == self.minDate.picker_year) {
        startWeek = self.minDate.picker_yearWeek;
    }
    if (year == self.maxDate.picker_year) {
        endWeek = self.maxDate.picker_yearWeek;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startWeek; i <= endWeek; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        return [[tempArr reverseObjectEnumerator] allObjects];
    }
    
    return [tempArr copy];
}

#pragma mark - 获取 quarterArr 数组
- (NSArray *)getQuarterArr:(NSInteger)year {
    NSInteger startQuarter = 1;
    NSInteger endQuarter = [NSDate picker_getQuartersInYear:year];
    if (year == self.minDate.picker_year) {
        startQuarter = self.minDate.picker_quarter;
    }
    if (year == self.maxDate.picker_year) {
        endQuarter = self.maxDate.picker_quarter;
    }
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = startQuarter; i <= endQuarter; i++) {
        [tempArr addObject:[self getMDHMSNumber:i]];
    }
    if (self.isDescending) {
        return [[tempArr reverseObjectEnumerator] allObjects];
    }
    
    return [tempArr copy];
}

#pragma mark - 添加 pickerView
- (void)setupPickerView:(UIView *)pickerView toView:(UIView *)view {
    if (view) {
        // 立即刷新容器视图 view 的布局（防止 view 使用自动布局时，选择器视图无法正常显示）
        [view setNeedsLayout];
        [view layoutIfNeeded];
        
        self.frame = view.bounds;
        CGFloat pickerHeaderViewHeight = self.pickerHeaderView ? self.pickerHeaderView.bounds.size.height : 0;
        CGFloat pickerFooterViewHeight = self.pickerFooterView ? self.pickerFooterView.bounds.size.height : 0;
        pickerView.frame = CGRectMake(0, pickerHeaderViewHeight, view.bounds.size.width, view.bounds.size.height - pickerHeaderViewHeight - pickerFooterViewHeight);
        [self addSubview:pickerView];
    } else {
        // iOS16：重新设置 pickerView 高度（解决懒加载设置frame不生效问题）
        CGFloat pickerHeaderViewHeight = self.pickerHeaderView ? self.pickerHeaderView.bounds.size.height : 0;
        pickerView.frame = CGRectMake(0, self.pickerStyle.titleBarHeight + pickerHeaderViewHeight, self.keyView.bounds.size.width, self.pickerStyle.pickerHeight);

        [self.alertView addSubview:pickerView];
    }
}

#pragma mark - 获取日期单位
- (NSArray *)setupPickerUnitLabel:(UIPickerView *)pickerView unitArr:(NSArray *)unitArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < pickerView.numberOfComponents; i++) {
        // label宽度
        CGFloat labelWidth = pickerView.bounds.size.width / pickerView.numberOfComponents;
        // 根据占位文本长度去计算宽度
        NSString *tempText = @"00";
        if (i == 0) {
            switch (self.pickerMode) {
                case TFYDatePickerModeYMDHMS:
                case TFYDatePickerModeYMDHM:
                case TFYDatePickerModeYMDH:
                case TFYDatePickerModeYMD:
                case TFYDatePickerModeYM:
                case TFYDatePickerModeY:
                {
                    tempText = @"0123";
                }
                    break;
                    
                default:
                    break;
            }
        }
        // 文本宽度
        CGFloat labelTextWidth = [tempText boundingRectWithSize:CGSizeMake(MAXFLOAT, self.pickerStyle.rowHeight)
                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                     attributes:@{NSFontAttributeName: self.pickerStyle.pickerTextFont}
                                                        context:nil].size.width;
        // 单位label
        UILabel *unitLabel = [[UILabel alloc]init];
        unitLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        unitLabel.backgroundColor = [UIColor clearColor];
        if (self.pickerMode != TFYDatePickerModeYMDHMS) {
            unitLabel.textAlignment = NSTextAlignmentCenter;
        }
        unitLabel.font = self.pickerStyle.dateUnitTextFont;
        unitLabel.textColor = self.pickerStyle.dateUnitTextColor;
        // 字体自适应属性
        unitLabel.adjustsFontSizeToFitWidth = YES;
        // 自适应最小字体缩放比例
        unitLabel.minimumScaleFactor = 0.5f;
        unitLabel.text = (unitArr.count > 0 && i < unitArr.count) ? unitArr[i] : nil;
        
        CGFloat originX = i * labelWidth + labelWidth / 2.0 + labelTextWidth / 2.0 + self.pickerStyle.dateUnitOffsetX;
        CGFloat originY = (pickerView.frame.size.height - self.pickerStyle.rowHeight) / 2 + self.pickerStyle.dateUnitOffsetY;
        unitLabel.frame = CGRectMake(originX, originY, MAX(self.pickerStyle.rowHeight, labelTextWidth), self.pickerStyle.rowHeight);
        
        [tempArr addObject:unitLabel];
        
        [pickerView addSubview:unitLabel];
    }
    
    return [tempArr copy];
}

- (NSString *)getYearNumber:(NSInteger)year {
    NSString *yearString = [NSString stringWithFormat:@"%@", @(year)];
    if (self.isNumberFullName) {
        yearString = [NSString stringWithFormat:@"%04d", [yearString intValue]];
    }
    return yearString;
}

- (NSString *)getMDHMSNumber:(NSInteger)number {
    NSString *string = [NSString stringWithFormat:@"%@", @(number)];
    if (self.isNumberFullName) {
        string = [NSString stringWithFormat:@"%02d", [string intValue]];
    }
    return string;
}

- (NSString *)getYearText:(NSArray *)yearArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, yearArr.count - 1);
    }
    NSString *yearString = [yearArr objectAtIndex:index];
    if ((self.lastRowContent && [yearString isEqualToString:self.lastRowContent]) || (self.firstRowContent && [yearString isEqualToString:self.firstRowContent])) {
        return yearString;
    }
    NSString *yearUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getYearUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", yearString, yearUnit];
}

- (NSString *)getMonthText:(NSArray *)monthArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, monthArr.count - 1);
    }
    NSString *monthString = [monthArr objectAtIndex:index];
    // 首行/末行是自定义字符串，直接返回
    if ((self.firstRowContent && [monthString isEqualToString:self.firstRowContent]) || (self.lastRowContent && [monthString isEqualToString:self.lastRowContent])) {
        return monthString;
    }
    
    // 自定义月份数据源
    if (self.monthNames && self.monthNames.count > 0) {
        NSInteger index = [monthString integerValue] - 1;
        monthString = (index >= 0 && index < self.monthNames.count) ? self.monthNames[index] : @"";
    } else {
        if (![self.pickerStyle.language hasPrefix:@"zh"] && (self.pickerMode == TFYDatePickerModeYMD || self.pickerMode == TFYDatePickerModeYM || self.pickerMode == TFYDatePickerModeYMW)) {
            // 非中文环境：月份使用系统的月份名称
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:self.pickerStyle.language];
            // monthSymbols: @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
            // shortMonthSymbols: @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
            NSArray *monthNames = self.isShortMonthName ? dateFormatter.shortMonthSymbols : dateFormatter.monthSymbols;
            NSInteger index = [monthString integerValue] - 1;
            monthString = (index >= 0 && index < monthNames.count) ? monthNames[index] : @"";
        } else {
            // 中文环境：月份显示数字
            NSString *monthUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getMonthUnit] : @"";
            monthString = [NSString stringWithFormat:@"%@%@", monthString, monthUnit];
        }
    }
    
    return monthString;
}

- (NSString *)getDayText:(NSArray *)dayArr row:(NSInteger)row mSelectDate:(NSDate *)mSelectDate {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, dayArr.count - 1);
    }
    NSString *dayString = [dayArr objectAtIndex:index];
    if (self.isShowToday && mSelectDate.picker_year == [NSDate date].picker_year && mSelectDate.picker_month == [NSDate date].picker_month && [dayString integerValue] == [NSDate date].picker_day) {
        return [NSBundle picker_localizedStringForKey:@"今天" language:self.pickerStyle.language];
    }
    NSString *dayUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getDayUnit] : @"";
    dayString = [NSString stringWithFormat:@"%@%@", dayString, dayUnit];
    if (self.isShowWeek) {
        NSDate *date = [NSDate picker_setYear:mSelectDate.picker_year month:mSelectDate.picker_month day:[dayString integerValue]];
        NSString *weekdayString = [NSBundle picker_localizedStringForKey:[date picker_weekdayString] language:self.pickerStyle.language];
        dayString = [NSString stringWithFormat:@"%@%@", dayString, weekdayString];
    }
    return dayString;
}

- (NSString *)getHourText:(NSArray *)hourArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, hourArr.count - 1);
    }
    NSString *hourString = [hourArr objectAtIndex:index];
    if ((self.lastRowContent && [hourString isEqualToString:self.lastRowContent]) || (self.firstRowContent && [hourString isEqualToString:self.firstRowContent])) {
        return hourString;
    }
    NSString *hourUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getHourUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", hourString, hourUnit];
}

- (NSString *)getMinuteText:(NSArray *)minuteArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, minuteArr.count - 1);
    }
    NSString *minuteString = [minuteArr objectAtIndex:index];
    NSString *minuteUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getMinuteUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", minuteString, minuteUnit];
}

- (NSString *)getSecondText:(NSArray *)secondArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, secondArr.count - 1);
    }
    NSString *secondString = [secondArr objectAtIndex:index];
    NSString *secondUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getSecondUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", secondString, secondUnit];
}

- (NSString *)getWeekText:(NSArray *)weekArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, weekArr.count - 1);
    }
    NSString *weekString = [weekArr objectAtIndex:index];
    if ((self.lastRowContent && [weekString isEqualToString:self.lastRowContent]) || (self.firstRowContent && [weekString isEqualToString:self.firstRowContent])) {
        return weekString;
    }
    NSString *weekUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getWeekUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", weekString, weekUnit];
}

- (NSString *)getQuarterText:(NSArray *)quarterArr row:(NSInteger)row {
    NSInteger index = 0;
    if (row >= 0) {
        index = MIN(row, quarterArr.count - 1);
    }
    NSString *quarterString = [quarterArr objectAtIndex:index];
    if ((self.lastRowContent && [quarterString isEqualToString:self.lastRowContent]) || (self.firstRowContent && [quarterString isEqualToString:self.firstRowContent])) {
        return quarterString;
    }
    NSString *quarterUnit = self.showUnitType == TFYShowUnitTypeAll ? [self getQuarterUnit] : @"";
    return [NSString stringWithFormat:@"%@%@", quarterString, quarterUnit];
}

- (NSString *)getAMText {
    return [NSBundle picker_localizedStringForKey:@"上午" language:self.pickerStyle.language];
}

- (NSString *)getPMText {
    return [NSBundle picker_localizedStringForKey:@"下午" language:self.pickerStyle.language];
}

- (NSString *)getYearUnit {
    if (self.customUnit) {
        return self.customUnit[@"year"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"年" language:self.pickerStyle.language];
}

- (NSString *)getMonthUnit {
    if (self.customUnit) {
        return self.customUnit[@"month"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"月" language:self.pickerStyle.language];
}

- (NSString *)getDayUnit {
    if (self.customUnit) {
        return self.customUnit[@"day"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"日" language:self.pickerStyle.language];
}

- (NSString *)getHourUnit {
    if (self.pickerMode == TFYDatePickerModeYMDH && self.isShowAMAndPM) {
        return @"";
    }
    if (self.customUnit) {
        return self.customUnit[@"hour"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"时" language:self.pickerStyle.language];
}

- (NSString *)getMinuteUnit {
    if (self.customUnit) {
        return self.customUnit[@"minute"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"分" language:self.pickerStyle.language];
}

- (NSString *)getSecondUnit {
    if (self.customUnit) {
        return self.customUnit[@"second"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"秒" language:self.pickerStyle.language];
}

- (NSString *)getWeekUnit {
    if (self.customUnit) {
        return self.customUnit[@"week"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"周" language:self.pickerStyle.language];
}

- (NSString *)getQuarterUnit {
    if (self.customUnit) {
        return self.customUnit[@"quarter"] ? : @"";
    }
    if (![self.pickerStyle.language hasPrefix:@"zh"]) {
        return @"";
    }
    return [NSBundle picker_localizedStringForKey:@"季度" language:self.pickerStyle.language];
}

- (NSInteger)getIndexWithArray:(NSArray *)array object:(NSString *)obj {
    if (!array || array.count == 0 || !obj) {
        return 0;
    }
    if ([array containsObject:obj]) {
        return [array indexOfObject:obj];
    }
    return 0;
}

@end
