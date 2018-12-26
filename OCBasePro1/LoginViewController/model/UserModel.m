//
//  UserModel.m
//  XieChang
//
//  Created by yons on 17/5/15.
//  Copyright © 2017年 Hbung. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{

    [encoder encodeObject:self.encription forKey:@"encription"];
    [encoder encodeBool:self.login forKey:@"login"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.userTel forKey:@"userTel"];
    [encoder encodeObject:self.userMobile forKey:@"userMobile"];
    [encoder encodeObject:self.img_url forKey:@"img_url"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.companyName forKey:@"companyName"];


}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {

        self.encription = [decoder decodeObjectForKey:@"encription"];
        self.login =[decoder decodeBoolForKey:@"login"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.userTel = [decoder decodeObjectForKey:@"userTel"];
        self.userMobile = [decoder decodeObjectForKey:@"userMobile"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.img_url = [decoder decodeObjectForKey:@"img_url"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.companyName = [decoder decodeObjectForKey:@"companyName"];

    }
    return self;
}



@end
