//
//  AccountTool.m
//  XieChang
//
//  Created by yons on 17/5/15.
//  Copyright © 2017年 Hbung. All rights reserved.
//

#import "AccountTool.h"
#define LSHAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LSHAccount.data"]
@implementation AccountTool
/**
 *  保存用户信息
 */
+ (void)saveAccount:(UserModel *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:LSHAccountFile];
}

/**
 *  构造方法，返回用户Model
 */
+ (UserModel *)account
{
    // 取出账号
    return [NSKeyedUnarchiver unarchiveObjectWithFile:LSHAccountFile];
}

@end
