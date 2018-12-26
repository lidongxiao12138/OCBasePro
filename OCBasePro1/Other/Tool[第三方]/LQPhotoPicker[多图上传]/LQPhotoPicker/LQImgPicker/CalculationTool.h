//
//  CalculationTool.h
//  chuxinggaozao
//
//  Created by yons on 16/8/4.
//  Copyright © 2016年 於建光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalculationTool : NSObject

+ (CGSize)sizeWithText:(NSString *)text  font:(UIFont *)font  maxsize:(CGSize)maxsize;

+ (NSString *)stringWithTime:(NSString *)time;

+ (NSString *)stringWithPlaypaopaoTime:(NSString *)time;

+ (NSInteger)rowWithcount:(NSInteger)count andcol:(NSInteger)col;

+ (NSString *)WritetoDocumentsPath:(NSString *)pathurl;

+ (NSString *)ReadDocumentsPath:(NSString *)pathurl;

+ (NSAttributedString *)stringWithUIImage:(NSString *)Imagestring    contentstring:(NSString *)contentstring;

+ (NSAttributedString *)stringWithUIImageLine:(NSString *)Imagestring    contentstring:(NSString *)contentstring;

+ (NSURL *)Urlwithimgurl:(NSString *)imgurl;

+ (NSAttributedString *)stringWithMustchoosestring:(NSString *)choosestring;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureFloat:(NSString*)string;

+ (BOOL)floatisPureInt:(float)num;

+ (NSAttributedString*)transferredAction:(NSString *)inputString;

+ (CAEmitterLayer *)LayerInview:(UIView *)Layerview AndcaELayer:(CAEmitterLayer *)caELayer;

+ (NSMutableAttributedString *)TextSpcestring:(NSString *)str;

+ (CGFloat)GetSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;

+ (NSString *)StringwithPrice:(float)price;

+ (void)AvatarImgWith:(UIImageView *)Imgview AndavatarimgSmallurl:(NSString *)avatarimgSmallurl Andavatarurl:(NSString *)avatarurl;

+ (NSMutableArray *)ArrayWithString:(NSString *)string;
@end
