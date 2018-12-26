//
//  MainNavigationController.m
//  TJProperty
//
//  Created by Miffy@Remmo on 15-5-26.
//  Copyright (c) 2015年 bocweb. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self preferredStatusBarStyle];
}

+ (void)initialize
{
    [self setNavigationItemTheme];
    [self setNavigationBarTheme];
}

+ (void)setNavigationItemTheme
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttributes[NSShadowAttributeName] = shadow;
    [barItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

+ (void)setNavigationBarTheme
{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2.设置导航栏的背景图片
//    navBar.barTintColor = RGB(230, 63, 79);
    navBar.barTintColor = KNavigationBgColor;

    

    //    NSString *navBarBg = @"beijing";
//    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    // 3. 设置导航栏的渐变色（iOS7中返回箭头的颜色）
//    navBar.tintColor = KTitLableColor;
    navBar.tintColor = [UIColor whiteColor];

    // 4.设置导航栏标题颜色
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributes[NSFontAttributeName] = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-BookIta" size:18];
    
    // 5.去除阴影
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttributes[NSShadowAttributeName] = shadow;
    [navBar setTitleTextAttributes:textAttributes];
}

-(UIBarButtonItem*) createBackButton
{
    UIImage* image= [UIImage imageNamed:@"publicwhite_back"];
    CGRect backframe= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)popself
{
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 0){
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
    [super pushViewController:viewController animated:animated];
}
//更改电池栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
