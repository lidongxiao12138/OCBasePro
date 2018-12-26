//
//  ChargePhotoView.h
//  LogisticsPro
//
//  Created by 李东晓 on 2018/9/11.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChargePhotoViewblock) ();

@interface ChargePhotoView : UIView

@property (nonatomic,strong) NSMutableArray *imagesMarray;//缩略图
@property (nonatomic,strong) NSMutableArray <NSData *> *selectdailibigImgDataArray;// 原图

@property (nonatomic,strong) UIViewController *showviewcontroller;

@property (nonatomic,strong) ChargePhotoViewblock Valuechangeblock;
@property (nonatomic, assign) CGFloat height;

@property (assign,nonatomic) NSInteger imageCount;
@property (nonatomic,weak) UILabel *addImgStrLabel;
@property (assign,nonatomic) NSString * HavePhoto;


- (void)DidValuechangeblock:(ChargePhotoViewblock)block;


@end
