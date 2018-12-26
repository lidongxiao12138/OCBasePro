//
//  RequsetManager.h
//  LogisticsPro
//
//  Created by 李东晓 on 2018/8/22.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequsetManager : NSObject
+(instancetype)sharedRequset;
-(instancetype)init;
-(void)requsetGo;

@end
