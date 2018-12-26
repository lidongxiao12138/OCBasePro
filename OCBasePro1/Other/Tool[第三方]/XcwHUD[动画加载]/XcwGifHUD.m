//
//  XcwGifHUD.m
//  WORX
//
//  Created by yons on 16/11/17.
//  Copyright © 2016年 Hbung. All rights reserved.
//

#import "XcwGifHUD.h"

@implementation XcwGifHUD

+ (XcwGifHUD*)sharedView {
    static dispatch_once_t once;

    static XcwGifHUD *sharedView;

    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });

    return sharedView;
}

- (instancetype) initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:CGRectMake(winWidth/2-40, winHeight/2-35, 200, 200)]) {
        
        

        
//        self.backgroundColor=[[UIColor clearColor] colorWithAlphaComponent:0.7];
//        self.layer.cornerRadius=5;
//        UILabel * label = [[UILabel alloc]init];
//        [label setText:@"WORX"];
//        [label setTextColor:[UIColor orangeColor]];
//        [label setFont:[UIFont boldSystemFontOfSize:30]];
//        [label setTextAlignment:NSTextAlignmentCenter];
//        [label setBackgroundColor:[UIColor clearColor]];
////        [self addSubview:label];
////        [label mas_makeConstraints:^(MASConstraintMaker *make) {
////
////            make.left.equalTo(self.mas_left);
////            make.top.equalTo(self.mas_top);
////            make.centerX.equalTo(self);
////            make.height.mas_equalTo(self.frame.size.height-30);
////        }];
//
//        NSArray *myImages = [NSArray arrayWithObjects:
//                             [UIImage imageNamed:@"swipe0.png"],
//
//                             [UIImage imageNamed:@"swipe1.png"],
//
//                             [UIImage imageNamed:@"swipe2.png"],
//
//                             [UIImage imageNamed:@"swipe3.png"],
//
//                             [UIImage imageNamed:@"swipe4.png"],
//
//                             [UIImage imageNamed:@"swipe5.png"],
//
//                             [UIImage imageNamed:@"swipe6.png"],
//
//                             [UIImage imageNamed:@"swipe7.png"],
//
//                             [UIImage imageNamed:@"swipe8.png"],
//
//                             [UIImage imageNamed:@"swipe9.png"],
//
//                             [UIImage imageNamed:@"swipe10.png"],
//
//                             [UIImage imageNamed:@"swipe11.png"],
//
//                             [UIImage imageNamed:@"swipe12.png"],
//
//                             [UIImage imageNamed:@"swipe13.png"],
//
//                             [UIImage imageNamed:@"swipe14.png"],
//
//                             [UIImage imageNamed:@"swipe15.png"],
//
//                             [UIImage imageNamed:@"swipe16.png"],
//
//                             [UIImage imageNamed:@"swipe17.png"],
//
//                             nil];
//
//        UIImageView *myAnimatedView = [[UIImageView alloc] init];
//
//        myAnimatedView.animationImages = myImages;
//        myAnimatedView.animationDuration=0.8f;
//        myAnimatedView.animationRepeatCount = 0;
//        ViewRadius(myAnimatedView, 5);
//        [myAnimatedView startAnimating];
//
//        [self addSubview:svImgView];
//
//        [myAnimatedView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.size.mas_equalTo(CGSizeMake(80, 70));
//            make.center.equalTo(self);
//
//        }];

    }
    return self;

}

 - (void)show{

    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews lastObject];
    [topView addSubview:self];

}



+ (void)showXcwGifHUD{

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
    [SVProgressHUD setInfoImage:[UIImage imageWithGIFNamed:@"loading4"]];
    UIImageView *svImgView = [[SVProgressHUD sharedView] valueForKey:@"imageView"];
    CGRect imgFrame = svImgView.frame;
    
    // 设置图片的显示大小
    imgFrame.size = CGSizeMake(60, 60);
    svImgView.frame = imgFrame;
    [SVProgressHUD showInfoWithStatus:@"正在加载..."];
}

 
- (void)hide{

  [self removeFromSuperview];

}

+ (void)HideXcwGifHUD{

//    [[XcwGifHUD sharedView] hide ];

    [SVProgressHUD dismiss];
}


@end
