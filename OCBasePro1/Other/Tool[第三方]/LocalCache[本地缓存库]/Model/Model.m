//
//  Model.m
//  WLHT-Merchant
//
//  Created by yons on 16/7/19.
//  Copyright © 2016年 Hbung. All rights reserved.
//

#import "Model.h"

@implementation Model
// 防止奔溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)initWithRYDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        for(__strong NSString *key in [dict allKeys])
        {
            NSString *value = [dict objectForKey:key];
            if ([key isEqualToString:@"id"]) {
                key = @"idTemp";
            }
            if([value isKindOfClass:[NSNumber class]])
                value = [NSString stringWithFormat:@"%@",value];
            else if([value isKindOfClass:[NSNull class]])
                value = @"";
            @try {
                [self setValue:value forKey:key];
            }
            @catch (NSException *exception) {
                NSLog(@"试图添加不存在的key:%@到实例:%@中.",key,NSStringFromClass([self class]));
            }
        }
    }
    return self;
}


//+ (JSONKeyMapper *)keyMapper {
//
//    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"goods_id"}];
//}
@end
