//
//  UserModel.h
//  XieChang
//
//  Created by yons on 17/5/15.
//  Copyright © 2017年 Hbung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

/**
 *  登录状态
 */
@property (assign,readwrite,nonatomic) BOOL login;
/**
 *  加密的用户信息字符串-用于请求
 */
@property (copy,nonatomic) NSString * encription;
/**
 *  用户名
 */
@property (copy,nonatomic) NSString * userName;

/**
 *  用户手机号-微商城
 */
@property (copy,nonatomic) NSString * userTel;

/**
  *  用户手机号-DBS
  */
@property (copy,nonatomic) NSString * userMobile;

/**
 *  用户id
 */
@property (copy,nonatomic) NSString * userId;


/**
 *  新增用户id
 */
@property (copy,nonatomic) NSString * NewUserId;
/**
 *  用户密码
 */
@property (copy,nonatomic) NSString * password;

/**
 *  用户头像
 */
@property (copy,nonatomic) NSString * img_url;

/**
 *  用户归属地
 */
@property (copy,nonatomic) NSString * address;

/**
 *  用户公司名称
 */
@property (copy,nonatomic) NSString * companyName;


+ (instancetype)accountWithDict:(NSDictionary *)dict;


- (instancetype)initWithDict:(NSDictionary *)dict;



@end
