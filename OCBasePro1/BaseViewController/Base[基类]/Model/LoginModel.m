//
//  LoginModel.m
//  BookingCar
//
//  Created by mac on 2017/7/4.
//  Copyright © 2017年 LDX. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.relname forKey:@"relname"];
    [aCoder encodeObject:self.employeType forKey:@"employeType"];
    [aCoder encodeObject:self.idTemp forKey:@"id"];

    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.relname = [aDecoder decodeObjectForKey:@"relname"];
        self.employeType = [aDecoder decodeObjectForKey:@"employeType"];
        self.idTemp = [aDecoder decodeObjectForKey:@"id"];

    }
    return self;
}

@end
