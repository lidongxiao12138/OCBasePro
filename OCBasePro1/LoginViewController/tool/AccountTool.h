//
//  AccountTool.h
//  XieChang
//
//  Created by yons on 17/5/15.
//  Copyright © 2017年 Hbung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface AccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(UserModel *)account;

/**
 *  返回存储的账号信息
 */
+ (UserModel *)account;


@end
