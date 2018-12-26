//
//  YNWebViewController.h
//  yuenow
//
//  Created by Kraig.wu on 2018/5/11.
//  Copyright © 2018年 wanhe. All rights reserved.
//

#import "YNBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSExport.h>

@interface YNWebViewController : YNBaseViewController

@property(nonatomic,copy) NSString* webUrl;

-(instancetype)initWithTitle:(NSString*)title webUrl:(NSString*)webUrl;

@end
