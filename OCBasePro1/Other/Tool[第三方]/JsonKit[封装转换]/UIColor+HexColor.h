//
//  UIColor+HexColor.h
//  yuenow
//
//  Created by Kraig.wu on 2018/5/7.
//  Copyright © 2018年 wanhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
