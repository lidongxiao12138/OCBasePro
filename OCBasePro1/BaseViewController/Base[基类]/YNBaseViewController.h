//
//  YNBaseViewController.h
//  yuenow
//
//  Created by Kraig.wu on 2018/5/4.
//  Copyright © 2018年 wanhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
//#import <BaiduMapKit/BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "SelectImgsView.h"
#import "NorIneternetView.h"
@interface YNBaseViewController : UIViewController
//地图
@property (nonatomic,strong)BMKLocationService * locService;
//地址
@property (nonatomic,copy)NSString * AddressStr;
//图片
@property (strong,nonatomic) SelectImgsView *baseSelectimgsview;

@property (nonatomic,strong) NorIneternetView * internetView;



- (void)initBaseNaviWithBackground;
- (void)initBaseNavi;
/**
 带返回按钮的头部
 */
- (void)initBackItemNav;
- (void)backAction;
- (void)showNullViewWithImage:(NSString *)imgUrl text:(NSString *)text frame:(CGRect)frame;
- (void)closeNullView;
- (void)showText:(NSString *)text;
- (void)callPhone:(NSString *)phone;
- (NSString *)getAgeWithBirth:(NSString *)birth;

//现在的时间
-(NSString *)timeNow;

// 提示信息弹窗
- (void)showAlertViewWithMessage:(NSString*)messageStr;

- (void)CreatLocService;

- (NSString *)addressCitylat:(double)lat lng:(double)lng;

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
//base64
- (NSString *)imageToString:(NSData *)image;

//百度地图
-(void)BMKBaiDuMapAddresslat:(double)latitude long:(double)longitude;

//百度地图代理
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error;

//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//网络图片转image
-(UIImage *) getImageFromURL:(NSString *)fileURL;


-(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;


- (NSString *) encryptUseDES1:(NSString *)plainText key:(NSString *)key;

- (NSString*)encrypt:(NSString*)plainText;
- (NSString*)decrypt:(NSString*)encryptText;


- (NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key;


-(NSString *)DES_EncryptWithText:(NSString *)sText;

- (BOOL)isNum:(NSString *)checkedNumString;

#pragma mark -- 数组排序方法（降序）
- (NSArray *)arraySortDESC:(NSMutableArray *)array;

@end
