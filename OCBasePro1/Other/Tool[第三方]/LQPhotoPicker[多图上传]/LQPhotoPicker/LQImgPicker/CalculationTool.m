//
//  CalculationTool.m
//  chuxinggaozao
//
//  Created by yons on 16/8/4.
//  Copyright © 2016年 於建光. All rights reserved.
//

#import "CalculationTool.h"
#define KImageName(s) [UIImage imageNamed:(s)]
@implementation CalculationTool

//计算文字的尺寸   text：需要计算的文字  font：文字字体  maxsize 最大字体
+ (CGSize)sizeWithText:(NSString *)text  font:(UIFont *)font  maxsize:(CGSize)maxsize{
    //字典存储属性
    NSDictionary *attrs=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}

+ (NSString *)stringWithTime:(NSString *)time{

    if(![time isEqualToString:@""] && time.length == 21){
    long time1 = [[NSString stringWithFormat:@"%@",[time substringWithRange:NSMakeRange(6, time.length - 8)]]longLongValue];
    
    //时间戳转成时间
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    
    long nowTime = [[NSString stringWithFormat:@"%f", a]integerValue];
    long reportTime = (nowTime*1000 - time1)/1000;
    NSString *intervalStr;
    if(reportTime >= 24*60*60){
        intervalStr = [NSString stringWithFormat:@"%ld天前",reportTime/(24*60*60)];
        if (reportTime >= 3*24*60*60) {
            
            NSString *jiequ = [time substringWithRange:NSMakeRange(6, 13)];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[jiequ doubleValue] / 1000];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"yyyy-MM-dd"];
            intervalStr =[objDateformat stringFromDate: date];
        }
    }
    else if(reportTime >=60*60){
        intervalStr = [NSString stringWithFormat:@"%ld小时前",reportTime/(60*60)];
    }else if(reportTime >= 60 ){
        intervalStr = [NSString stringWithFormat:@"%ld分钟前",reportTime/60];
    }else{
        intervalStr = @"刚刚";
    }
    
    return intervalStr;
    }else{
    return @"未知";
    }
}

+ (NSString *)stringWithPlaypaopaoTime:(NSString *)time{
    
    int hourNum = [time intValue]/3600;
    NSString *hour = [NSString stringWithFormat:@"%d",hourNum];
    
    int minuteNum = ([time intValue] % 3600)/60;
    NSString *minute = [NSString stringWithFormat:@"%d",minuteNum];

    int secondNum = [time intValue] % 60;
    NSString *second = [NSString stringWithFormat:@"%d",secondNum];
    
    if ([hour intValue] != 0)   time = [NSString stringWithFormat:@"%@'%@'%@'",hour,minute,second];
    else{
    if ([minute intValue] != 0)   time = [NSString stringWithFormat:@"%@'%@'",minute,second];
    else{
    time = [NSString stringWithFormat:@"%@''",second];
    }
    }
    
    
    return time;
}

+ (NSInteger)rowWithcount:(NSInteger)count andcol:(NSInteger)col{
    NSInteger scale = count/col + 1;
    NSInteger index = count%col;
    if(index == 0){
    scale = count/col;
    }
    return scale;
}

+ (NSString *)WritetoDocumentsPath:(NSString *)pathurl
{
    NSArray *componets = [pathurl componentsSeparatedByString:@"/"];
    long index = [componets count] - 1;
    NSString *Name = [componets objectAtIndex:index];
    
    NSString *FilePath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),Name];
    
    return FilePath;
}
+ (NSString *)ReadDocumentsPath:(NSString *)pathurl
{
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [dataPath stringByAppendingPathComponent:pathurl];
    return filePath;
}
// 创建一个富文本
+ (NSAttributedString *)stringWithUIImage:(NSString *)Imagestring    contentstring:(NSString *)contentstring{
    contentstring = [NSString stringWithFormat:@" %@",contentstring];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentstring];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = KImageName(Imagestring);
    attchImage.bounds = CGRectMake(0, 0, 16, 16);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    
    return attriStr;
}

// 创建一个富文本
//+ (NSAttributedString *)stringWithUIImageLine:(NSString *)Imagestring    contentstring:(NSString *)contentstring{
//    contentstring = [NSString stringWithFormat:@"丨  %@",contentstring];
//    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentstring];
//    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
//    attchImage.image = KImageName(Imagestring);
//    attchImage.bounds = CGRectMake(0, 0, 16, 16);
//    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
//    [attriStr insertAttributedString:stringImage atIndex:2];
//    
//    [attriStr addAttribute:NSFontAttributeName value:HiraginoBigFONT range:NSMakeRange(0, 1)];
//    [attriStr addAttribute:NSForegroundColorAttributeName value:BackgrayColor range:NSMakeRange(0, 1)];
//    
//    return attriStr;
//}
//
//+ (NSURL *)Urlwithimgurl:(NSString *)imgurl{
//    NSURL *url;
//    imgurl = [NSString stringWithFormat:@"%@",imgurl];
//    if (![imgurl isEqualToString:@""]) {
//    if ([imgurl hasPrefix:@"http:"]) {
//    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgurl]];
//    }else{
//    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadURL,imgurl]];
//    }
//    }
//    return url;
//}
//+ (NSAttributedString *)stringWithMustchoosestring:(NSString *)choosestring{
//    choosestring = [NSString stringWithFormat:@"* %@",choosestring];
//    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:choosestring];
//    NSRange redRange = NSMakeRange(0, 1);
//    [noteStr addAttribute:NSForegroundColorAttributeName value:BackredColor range:redRange];
//    return noteStr;
//}


//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)floatisPureInt:(float)num{
    if (num != 0) {
        int x;
        float z;
        x = num;
        z = num - x;
        if (z == 0) return YES;
        else return NO;
    }else{
        return YES;
    }
}
//表情转义
+ (NSAttributedString*)transferredAction:(NSString *)inputString{
    inputString = [NSString stringWithFormat:@"%@",inputString];
//    NSLog(@"inputString==%@",inputString);
    if (![inputString isEqualToString:@""]) {
    inputString = [inputString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!inputString) {
     inputString = @"未知";
    }
//    NSLog(@"inputString==%@",inputString);
    //加载plist文件中的数据
    NSBundle *bundle = [NSBundle mainBundle];
    //寻找资源的路径
    NSString *path = [bundle pathForResource:@"emojiPlist" ofType:@"plist"];
    //获取plist中的数据
    NSArray *face = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:inputString];
    //正则匹配要替换的文字的范围
    //正则表达式
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    //通过正则表达式来匹配字符串
    NSArray *resultArray = [re matchesInString:inputString options:0 range:NSMakeRange(0, inputString.length)];
    //用来存放字典，
    NSMutableArray *imageArray1 = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原中括号中对应的值
        NSString *subStr = [inputString substringWithRange:range];
        for (int i = 0; i < face.count; i ++)
        {
            if ([face[i][@"chs"] isEqualToString:subStr])
            {
                //新建文字附件来存放我们的图片
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                UIImage *image1 = [UIImage imageNamed:face[i][@"png"]];
                textAttachment.image = image1;
                textAttachment.bounds = CGRectMake(textAttachment.bounds.origin.x, textAttachment.bounds.origin.y-2.5, 15, 15);
                //把附件转换成可变字符串，用于替换源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray1 addObject:imageDic];
                
            }
        }
    }
    
    //从后往前attributeString进行替换
    for (long i = imageArray1.count - 1; i >= 0; i--)
    {
        NSRange range;
        [imageArray1[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:[imageArray1[i]objectForKey:@"image"]];
    }
    // NSLog(@"attributeString----%@",attributeString);
    
    [attributeString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} range:NSMakeRange(0, attributeString.length)];
    
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithAttributedString:attributeString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary *attribs = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:paragraphStyle};
    [paragraphStyle setLineSpacing:8];
    [attributed addAttributes:attribs range:NSMakeRange(0, [attributeString length])];
     
    return attributed;
    }else
    return [[NSMutableAttributedString alloc]initWithString:@""];
}
+ (CAEmitterLayer *)LayerInview:(UIView *)Layerview AndcaELayer:(CAEmitterLayer *)caELayer{
  
    // 发射源
    caELayer.emitterPosition   = CGPointMake(Layerview.frame.size.width / 2, Layerview.frame.size.height - 50);
    // 发射源尺寸大小
    caELayer.emitterSize       = CGSizeMake(50, 0);
    // 发射源模式
    caELayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    caELayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    caELayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    caELayer.velocity          = 1;
    // 随机产生粒子
    caELayer.seed              = (arc4random() % 100) + 1;
    
    // cell
    CAEmitterCell *cell             = [CAEmitterCell emitterCell];
    // 速率
    cell.birthRate                  = 1.0;
    // 发射的角度
    cell.emissionRange              = 0.11 * M_PI;
    // 速度
    cell.velocity                   = 300;
    // 范围
    cell.velocityRange              = 150;
    // Y轴 加速度分量
    cell.yAcceleration              = 75;
    // 声明周期
    cell.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents                   = (id)
    [[UIImage imageNamed:@"FFRing"] CGImage];
    // 缩放比例
    cell.scale                      = 0.2;
    // 粒子的颜色
    cell.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange                  = 1.0;
    // 子旋转角度范围
    cell.spinRange                  = M_PI;
    
    // 爆炸
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 125;
    // 360 deg//周围发射角度
    spark.emissionRange             = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration             = 75;
    //粒子生命周期
    spark.lifetime                  = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents                  = (id)
    [[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    spark.scaleSpeed                = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.25;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    
    caELayer.emitterCells = [NSArray arrayWithObject:cell];
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    
    return caELayer;
}

+ (NSMutableAttributedString *)TextSpcestring:(NSString *)str{
    str = [NSString stringWithFormat:@"%@",str];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str];
   
    if (![str isEqualToString:@""]) {
    if (str.length>=2) {
    //建立行间距模型
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle1 setLineSpacing:5.f];
    paragraphStyle1.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle1.alignment = NSTextAlignmentLeft;
    //把行间距模型加入NSMutableAttributedString模型
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
    [attrStr addAttribute:NSKernAttributeName value:@(1.0) range:NSMakeRange(0, attrStr.length-2)];
    }
    }
    return attrStr;
}
+ (CGFloat)GetSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    /** 行高 */
    
    paraStyle.lineSpacing = 5;
    
//    paraStyle.hyphenationFactor = 1.0;
//    
//    paraStyle.firstLineHeadIndent = 0.0;
//    
//    paraStyle.paragraphSpacingBefore = 0.0;
//    
//    paraStyle.headIndent = 0;
//    
//    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}
+ (NSString *)StringwithPrice:(float)price{
    NSString *pricestring;
    if (price >= 1000) {
        pricestring = [NSString stringWithFormat:@"%.1f",price];
        if (price >= 10000) {
        pricestring = [NSString stringWithFormat:@"%.1f万",price/10000];
        }
    }else{
        pricestring = [NSString stringWithFormat:@"%.2f",price];
        if (price == 0) {
        pricestring = [NSString stringWithFormat:@"免费"];
        }
    }
    return pricestring;
}

//+ (void)AvatarImgWith:(UIImageView *)Imgview AndavatarimgSmallurl:(NSString *)avatarimgSmallurl Andavatarurl:(NSString *)avatarurl{
// 
//    [Imgview sd_setImageWithURL:[CalculationTool Urlwithimgurl:avatarimgSmallurl] placeholderImage:KDefaultPlaceImageName];
//    if (![[SDWebImageManager sharedManager] diskImageExistsForURL:[CalculationTool Urlwithimgurl:avatarimgSmallurl]]) {
//        [Imgview sd_setImageWithURL:[CalculationTool Urlwithimgurl:avatarurl] placeholderImage:KDefaultPlaceImageName];
//    }
//}

+ (NSMutableArray *)ArrayWithString:(NSString *)string{
    NSArray *array = [string componentsSeparatedByString:@"|"];
    NSMutableArray *Marray = [NSMutableArray arrayWithArray:array];
    for (NSString *str in Marray) {
        if ([str isEqualToString:@""]) {
            [Marray removeObject:str];
        }
    }
    return Marray;
}
@end
