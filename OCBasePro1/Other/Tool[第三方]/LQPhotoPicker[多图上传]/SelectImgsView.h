//
//  SelectImgsView.h
//  DepthSZ
//
//  Created by yons on 16/10/31.
//  Copyright © 2016年 於建光. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectImgsViewblock) ();
@interface SelectImgsView : UIView

@property (nonatomic,strong) NSMutableArray *imagesMarray;//缩略图
@property (nonatomic,strong) NSMutableArray <NSData *> *selectdailibigImgDataArray;// 原图

@property (nonatomic,strong) UIViewController *showviewcontroller;

@property (nonatomic,strong) SelectImgsViewblock Valuechangeblock;
@property (nonatomic, assign) CGFloat height;

@property (assign,nonatomic) NSInteger imageCount;
@property (nonatomic,weak) UILabel *addImgStrLabel;
//@property (nonatomic,copy) NSString * IfRequsetStr;


- (void)DidValuechangeblock:(SelectImgsViewblock)block;


@end

