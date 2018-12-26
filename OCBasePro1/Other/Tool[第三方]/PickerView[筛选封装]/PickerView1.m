//
//  PickerView.m
//  TouGuApp
//
//  Created by tianshikechuang on 16/7/18.
//  Copyright © 2016年 tianshikechuang. All rights reserved.
//

#import "PickerView1.h"


#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface PickerView1 () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    
}

@property(nonatomic, strong) UIPickerView * pickerView1;
@property(nonatomic, strong) UIDatePicker * datePicker;

@property(nonatomic, strong) NSMutableArray * selectArr;


@end





@implementation PickerView1

+ (PickerView1 *)showPickerViewInkeyWindowTopWithType:(PickerViewType)type{
    
    UIView * view = [UIApplication sharedApplication].keyWindow;
    
    return [self showPickerViewInView:view withType:type];
}


+ (PickerView1 *)showPickerViewInVCTop:(UIViewController *)VC withType:(PickerViewType)type{
    
    UIView * view;
    if (VC.tabBarController) {
        view = VC.tabBarController.view;
    }else if (VC.navigationController){
        view = VC.navigationController.view;
    }else{
        view = VC.view;
    }
    
    return [self showPickerViewInView:view withType:type];
}


+ (PickerView1 *)showPickerViewInView:(UIView *)view withType:(PickerViewType)type{
    PickerView1 * picker = [[PickerView1 alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    picker.pickerType = type;
    
    [picker showInView:view];
    [picker addSureAndCancelButton];

    return picker;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.selectArr = [NSMutableArray array];
        self.contentHeight = 156;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}




- (UIPickerView *)pickerView1{
    
    if (_datePicker) {
        [_datePicker removeFromSuperview];
    }
    
    if (!_pickerView1) {
        
        _pickerView1 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, screenHeight - self.contentHeight, screenWidth, self.contentHeight)];
        _pickerView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pickerView1.delegate = self;
        _pickerView1.dataSource = self;
        
    }
    return _pickerView1;
}




- (UIDatePicker *)datePicker{
    
    if (_pickerView1) {
        [_pickerView1 removeFromSuperview];
    }
    
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenHeight - self.contentHeight, screenWidth, self.contentHeight)];
        _datePicker.backgroundColor = [UIColor greenColor];
        _datePicker.date = [NSDate date];
        [_datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}


- (void)setPickerType:(PickerViewType)pickerType{
    
    _pickerType = pickerType;
    
    switch (pickerType) {
        case PickerViewTypeDate_Time:
            
            self.datePicker.datePickerMode = UIDatePickerModeTime;
            [self addSubview:self.datePicker];
            
            break;
        case PickerViewTypeDate_Date:
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            [self addSubview:self.datePicker];
            
            break;
            
        case PickerViewTypeDate_DateAndTime:
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            [self addSubview:self.datePicker];
            
            break;
        case PickerViewTypeDate_Timer:
            self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
            [self addSubview:self.datePicker];
            
            break;
            
        case PickerViewTypeData:
            
            [self addSubview:self.pickerView1];
            
            break;
            
        default:
            break;
    }
   
}


- (void)setDataSources:(NSArray *)dataSources{
    
    _dataSources = dataSources;
    for (NSArray * arr in dataSources) {
        if (![arr isKindOfClass:[NSArray class]]) {
            _dataSources = @[];
            NSLog(@"\n\n--------- 传入的dataSources格式有误，请传入嵌套数组! (@[@[@\"1 - 1\",@\"1 - 2\"],@[@\"2 - 1\",@\"2 - 2\"]]) --------\n\n");
            return;
        }
        [self.selectArr addObject:[arr firstObject]];
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    if (self.dataSources) {
        return self.dataSources.count;
    }else{
        return 0;
    }
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.dataSources[component]) {
        NSArray * arr = self.dataSources[component];
        return arr.count;
    }else{
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray * arr = self.dataSources[component];
    
    return [arr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSArray * arr = self.dataSources[component];
    [self.selectArr replaceObjectAtIndex:component withObject:[arr objectAtIndex:row]];
    
    
    if (self.selectBlock) {
        self.selectBlock(self.selectArr,NO);
    }

}




- (void)addSureAndCancelButton{
    
    UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - self.contentHeight - 40, screenWidth, 40)];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonView];
    
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:kBlueColor forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonView addSubview:cancel];
    
    
    UIButton * sure = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 100, 0, 100, 40)];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:kBlueColor forState:UIControlStateNormal];
    sure.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonView addSubview:sure];
    sure.tag = 101;
    
    
}

- (void)buttonAction:(UIButton  *)button{
    
    [self removeFromSuperview];
    
    if (self.selectBlock && button.tag == 101) {
        
        if (self.pickerType == PickerViewTypeData) {
            self.selectBlock(self.selectArr,YES);
        }else{
            self.selectBlock(self.datePicker.date,YES);
        }
    }
}

- (void)datePickerAction:(UIDatePicker *)picker{
    if (self.selectBlock) {
        self.selectBlock(picker.date,NO);
    }
}


- (void)showInView:(UIView *)view{
    
    [view addSubview:self];
    self.frame = CGRectMake(0, screenHeight, screenWidth, 0);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }];
}


- (void)removeFromSuperview{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, screenHeight, screenWidth, screenHeight);
        
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
    
    
    
}







//////////////////////////////////////////////////////////////////////////////////////////
//      PickerViewTypeDate -- 对应的属性 与 方法
//////////////////////////////////////////////////////////////////////////////////////////
- (void)setMinimumDate:(NSDate *)minimumDate{
    
    [self.datePicker setMinimumDate:minimumDate];
}
- (NSDate *)minimumDate{
    return self.datePicker.minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate{
    [self.datePicker setMaximumDate:maximumDate];
}
- (NSDate *)maximumDate{
    return self.datePicker.maximumDate;
}

- (void)setCountDownDuration:(NSTimeInterval)countDownDuration{
    [self.datePicker setCountDownDuration:countDownDuration];
}
- (NSTimeInterval)countDownDuration{
    return self.datePicker.countDownDuration;
}

- (void)setMinuteInterval:(NSInteger)minuteInterval{
    [self.datePicker setMinuteInterval:minuteInterval];
}
- (NSInteger)minuteInterval{
    return self.datePicker.minuteInterval;
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated{
    [self.datePicker setDate:date animated:animated];
}

//////////////////////////////////////////////////////////////////////////////////////////





@end
