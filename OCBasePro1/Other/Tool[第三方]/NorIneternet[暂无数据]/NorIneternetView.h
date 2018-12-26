//
//  NorIneternetView.h
//  work
//
//  Created by 田黎强 on 16/7/2.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NorIneternetViewDelegate<NSObject>
-(void)theRefreshButtonClick;
@end

@interface NorIneternetView : UIView
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property(weak,nonatomic)id<NorIneternetViewDelegate>delegate;
- (IBAction)refreshButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *InternetNorTopConstraint;

@property (weak, nonatomic) IBOutlet UILabel *LabNoRequset;//暂无网络

@end
