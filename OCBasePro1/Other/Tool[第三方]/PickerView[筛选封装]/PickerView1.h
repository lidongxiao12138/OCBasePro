///////////////////////////////////////////////////////////////////////////////////
    /**
     
            示例
 //    PickerView * picker = [PickerView showPickerViewInView:view withType:PickerViewTypeData];
 PickerView * picker = [PickerView showPickerViewInkeyWindowTopWithType:PickerViewTypeData];
 
 picker.dataSources = @[@[@"aaa",@"aab"],@[@"baa",@"bab"],@[@"caa",@"cab",@"cac"]];

 [picker setSelectBlock:^(NSObject *data, BOOL isSureBtn) {
    NSLog(@"%@ -- %d",data,isSureBtn);
 }];
 
     
     */
//////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "PickerView1.h"
typedef enum PickerViewType : NSUInteger {
    PickerViewTypeDate_Time,
    PickerViewTypeDate_Date,
    PickerViewTypeDate_DateAndTime,
    PickerViewTypeDate_Timer,
    PickerViewTypeData,
} PickerViewType;



typedef void(^DidSelectBlock)(NSObject * data,BOOL isSureBtn);


@interface PickerView1 : UIView

/**
 *  传入的值必须是嵌套的数组 @[@[@"aaa",@"aab"],@[@"baa",@"bab"],@[@"caa",@"cab",@"cac"]]
 */
@property(nonatomic, strong) NSArray * dataSources;

@property(nonatomic, strong) DidSelectBlock selectBlock;

@property(nonatomic, assign) PickerViewType pickerType;

@property(nonatomic, assign) CGFloat contentHeight;

//////////////////////////////////////////////////////////////////////////////////////////
//      PickerViewTypeDate -- 对应的属性 与 方法
//////////////////////////////////////////////////////////////////////////////////////////
@property (nonatomic, strong) NSDate *minimumDate;

@property (nonatomic, strong) NSDate *maximumDate;

@property (nonatomic) NSTimeInterval countDownDuration;

@property (nonatomic) NSInteger      minuteInterval;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;
/////////////////////////////////////////////////////////////////////////////////////



+ (PickerView1 *)showPickerViewInkeyWindowTopWithType:(PickerViewType)type;
+ (PickerView1 *)showPickerViewInVCTop:(UIViewController *)VC withType:(PickerViewType)type;
+ (PickerView1 *)showPickerViewInView:(UIView *)view withType:(PickerViewType)type;

- (void)setSelectBlock:(DidSelectBlock)selectBlock;



@end
