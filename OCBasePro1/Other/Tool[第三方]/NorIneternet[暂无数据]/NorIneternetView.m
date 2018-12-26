//
//  NorIneternetView.m
//  work
//
//  Created by 田黎强 on 16/7/2.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "NorIneternetView.h"
#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]

@implementation NorIneternetView
#pragma mark - IBAction Methods
- (IBAction)refreshButtonClick:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(theRefreshButtonClick)]) {
            [self.delegate theRefreshButtonClick];
        }
//    self.refreshButton.enabled = NO;
}
#pragma mark -UIView Methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.refreshButton.layer.borderWidth = 1.0f;
    self.refreshButton.layer.borderColor = RGBColor(156.0f, 156.0f, 156.0f).CGColor;
    self.refreshButton.layer.cornerRadius = 30.0f/2;
    self.refreshButton.clipsToBounds = YES;
    self.InternetNorTopConstraint.constant = (winHeight-198 - naviHeight)/4;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
