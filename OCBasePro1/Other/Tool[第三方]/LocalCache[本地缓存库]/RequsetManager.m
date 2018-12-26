//
//  RequsetManager.m
//  LogisticsPro
//
//  Created by 李东晓 on 2018/8/22.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import "RequsetManager.h"
#import "Model.h"
@implementation RequsetManager
{
    NSMutableDictionary * paramsDic;
}
+(instancetype)sharedRequset
{
    static RequsetManager * sharedRequset = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedRequset == nil) {
            sharedRequset = [[RequsetManager alloc]init];
        }
    });
    return sharedRequset;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self requsetGo];
    }
    return self;
}
-(void)requsetGo:(NSString * )dispatchNo
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    array = (NSMutableArray *)[[DataManager sharedInstance]queryDataBase];
    if (array.count > 0) {
        for (Model * model in array) {
            if ([model.dispatchNO isEqualToString:dispatchNo]) {
                paramsDic = [[NSMutableDictionary alloc]init];
                [paramsDic setObject:model.dispatchNO forKey:@"transBean.dispatchNO"];//配载单号
                [paramsDic setObject:model.lng forKey:@"transBean.longitude"];//经纬度纬度
                [paramsDic setObject:model.lat forKey:@"transBean.latitudes"];//经度
                [paramsDic setObject:model.goCarTime forKey:@"transBean.time"];//发车时间
                [paramsDic setObject:model.MaBiaoNum forKey:@"transBean.kilometers"];//码表数
                [paramsDic setObject:model.MyPrice forKey:@"transBean.pics"];//发车图片
            }
        }
        
        NSLog(@"arr ==== %@",array);
    }
}


-(void)requsetAssignNote
{
    [XcwHUD showBasicChrysanthemunHUDForbidUserInteraction];
//    [XcwHUD show];
    [XcwHUD showSuccessWithMessage:@"您有操作尚未完整，正在自动完成操作请稍后...."];
    [[LDXNetworking sharedInstance]POST:k_BASE_URL(KdepartAssignNote) parameters:paramsDic success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        [XcwGifHUD HideXcwGifHUD];
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"header"][@"status"]] isEqualToString:@"1"]) {
////            popNaiv;
        }
     
        [XcwHUD hide];
//        [self showText:responseObject[@"header"][@"errMsg"]];
    } failure:^(NSError * _Nonnull error) {
        
        [XcwHUD hide];
        [XcwGifHUD HideXcwGifHUD];
//        [self showText:@"网络异常"];
    }];
}


@end
