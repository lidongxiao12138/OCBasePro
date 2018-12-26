//
//  MainTabViewController.m
//  TJProperty
//
//  Created by Miffy@Remmo on 15-5-26.
//  Copyright (c) 2015年 bocweb. All rights reserved.
//

#import "MainTabViewController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : KTitLableColor
                                                        } forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName : KNavigationBgColor
                                                        } forState:UIControlStateSelected];


  
    
    HomeViewController *book = [[HomeViewController alloc]init];
    [self addChildViewController:book withImageName:@"icon_home_nor" title:@"首页"];
    MeViewController *Me= [[MeViewController alloc]init];
    [self addChildViewController:Me withImageName:@"icon_wode_nor" title:@"我的"];
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    //TabBar背景色
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"toolbar_background"];
    self.tabBar.tintColor = KNavigationBgColor;

    self.tabBar.selectionIndicatorImage = [[UIImage alloc]init];
    
    [self setSelectedIndex:0];
    
}




- (void)addChildViewController:(UIViewController *)childController withImageName:(NSString *)icon title:(NSString *)title
{
    UITabBarItem *item = childController.tabBarItem;
    
    childController.title = title;
    
    NSString *selectIcon = [icon stringByAppendingString:@"_selected"];
    UIImage *iconImage = [UIImage imageNamed:icon];
    UIImage *selectIconImage = [UIImage imageNamed:selectIcon];
    if ([selectIconImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
        selectIconImage = [selectIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    item.image = iconImage;
    item.selectedImage = selectIconImage;
    
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}





@end
