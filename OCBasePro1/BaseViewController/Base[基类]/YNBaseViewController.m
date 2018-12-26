//
//  YNBaseViewController.m
//  yuenow
//
//  Created by Kraig.wu on 2018/5/4.
//  Copyright © 2018年 wanhe. All rights reserved.
//

#import "YNBaseViewController.h"
#import "CRToast.h"
#import "DES3Util.h"
#import <CommonCrypto/CommonCryptor.h>
#import<CommonCrypto/CommonDigest.h>


//秘钥
#define gkey            @"123456789012345678901234"
//向量
#define gIv             @"01234567"

//空字符串
#define LocalStr_None   @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@interface YNBaseViewController ()<BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,NorIneternetViewDelegate>
{
    NSString *city;
    NSString *name;
}
@property (nonatomic,strong) UIView *nullView;

@property UILabel* alertLabel;

@end

@implementation YNBaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self Openlocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = kBGBaseColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self initBaseNaviWithBackground];
    [self CreatLocService];
}

-(void)Openlocation
{
    BOOL enable=[CLLocationManager locationServicesEnabled];
    NSInteger status=[CLLocationManager authorizationStatus];
    if(!enable || status<3)
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
        {
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
        UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"打开定位开关提供更优质的服务" message:@"定位服务未开启，请进入系统［设置］> [隐私] > [定位服务]中打开开关，并允许使用定位服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertView addAction:sureAction];
        [alertView addAction:cancelAction];
        
        [self presentViewController:alertView animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CRToastManager dismissAllNotifications:YES];
    });
}

-(void)initBaseNaviWithBackground{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
}

-(void)initBackItemNav
{

    UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = navLeft;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
}

-(void)initBaseNavi{
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = navLeft;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = kBGBaseColor;
    [self.navigationController.navigationBar setBackgroundColor:kBGBaseColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
}

-(void)showNullViewWithImage:(NSString *)imgUrl text:(NSString *)text frame:(CGRect)frame{
    if(!_nullView){
        _nullView = [[UIView alloc] initWithFrame:frame];
        _nullView.backgroundColor = kBGBaseColor;
        UIImageView *imgView = [UIImageView new];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        [_nullView addSubview:imgView];
        
        UILabel *textLab = [UILabel new];
        textLab.text = text;
        textLab.font = Thin(17);
        textLab.textColor = [UIColor grayColor];
        [textLab sizeToFit];
        [_nullView addSubview:textLab];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.nullView);
            make.width.height.mas_equalTo(100);
        }];
        
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgView);
            make.top.equalTo(imgView.mas_bottom).offset(10);
        }];
    }
    [self.view addSubview:_nullView];
}

-(void)closeNullView{
    if(_nullView.superview){
        [_nullView removeFromSuperview];
    }
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showText:(NSString *)text{
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypeCover),
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor colorWithHexString:@"#6495ED"],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    NSMutableDictionary *xoptions = [NSMutableDictionary dictionaryWithDictionary:options];
    if(winHeight < 812){
        [xoptions setObject:@(CRToastTypeCustom) forKey:kCRToastNotificationTypeKey];
        [xoptions setObject:@(44) forKey:kCRToastNotificationPreferredHeightKey];
    }
    [CRToastManager dismissAllNotifications:NO];
    [CRToastManager showNotificationWithOptions:xoptions completionBlock:nil];
}

-(void)callPhone:(NSString *)phone{
    NSString *tel = [NSString stringWithFormat:@"tel:%@",phone];
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    if(version.floatValue>=10.2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:phone message: nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSString *)getAgeWithBirth:(NSString *)birth{
    NSString *birthYear = [birth substringToIndex:4];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    NSString *currentYear = [fmt stringFromDate:currentDate];
    NSNumber *age = @(currentYear.integerValue - birthYear.integerValue);
    return age.stringValue;
}


// ALERT--自动消失 根据项目要求自定义颜色、duration
- (void)showAlertViewWithMessage:(NSString*)messageStr  {
    
    if (_alertLabel) {
        return;
    }
    _alertLabel = [[UILabel alloc]init];
    [_alertLabel setText:messageStr];
    _alertLabel.numberOfLines=0;
    _alertLabel.textAlignment= NSTextAlignmentCenter;
    _alertLabel.layer.cornerRadius=5;
    _alertLabel.clipsToBounds=YES;
    [_alertLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [_alertLabel setTextColor:[UIColor whiteColor]];
    [_alertLabel setBackgroundColor:BarTintColor];
    
    [self.view addSubview:_alertLabel];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    CGSize size=[messageStr sizeWithAttributes:attrs];
    CGFloat width = size.width > winWidth/4*3? winWidth/4*3 : size.width+20;
    
    CGFloat height =[self heightForLabel_DependingOnString:messageStr fontSize:14 andWidth:width]+4 ;
    
    [_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(width+10, height));
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-150);
        make.centerX.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_alertLabel removeFromSuperview];
        _alertLabel=nil;
    });
    
}

//根据字符串的的长度来计算UITextView的高度
- (float)heightForLabel_DependingOnString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    float height =[ [NSString stringWithFormat:@"%@\n",value] boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    
    return height;
}

//获取地理位置
-(void)CreatLocService
{
    //初始化定位
    self.locService = [[BMKLocationService alloc] init];
    //设置代理
    self.locService.delegate = self;
    //开启定位
    [self.locService startUserLocationService];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"latitude === %f",userLocation.location.coordinate.latitude);
    NSLog(@"longitude === %f",userLocation.location.coordinate.longitude);
    [self.locService stopUserLocationService];
    [self BMKBaiDuMapAddresslat:userLocation.location.coordinate.latitude long:userLocation.location.coordinate.longitude];
}

-(void)BMKBaiDuMapAddresslat:(double)latitude long:(double)longitude
{
    BMKGeoCodeSearch * geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    geocodesearch.delegate = self;//设置代理为self
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){latitude, longitude};//初始化
    BMKReverseGeoCodeSearchOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeSearchOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.location = pt;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        NSLog(@"showmeg === %@",showmeg);
        self.AddressStr = showmeg;
        LoginModel * login = [LoginDataModel sharedManager].loginInModel;
        login.Alladdress = showmeg;
        [self.locService stopUserLocationService];
    }
}




-(NSString *)addressCitylat:(double)lat lng:(double)lng
{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:lat longitude:lng];
    //根据经纬度获取省份城市
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;//地址的所有信息
            NSString *state=[addressDic objectForKey:@"State"];//省。直辖市  江西省
            self->city=[addressDic objectForKey:@"City"];//市  丰城市
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];//区
            //            NSString *street=[addressDic objectForKey:@"Street"];//街道
            NSLog(@"%@=====%@-----%@=====%@",addressDic,state,self->city,subLocality);
        }
    }];
    return city;
}


- (NSString *)imageToString:(NSData *)image {
    
    NSString *image64 = [image base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}
//图片选择
- (SelectImgsView *)baseSelectimgsview{
    if (_baseSelectimgsview == nil) {
        _baseSelectimgsview = [[SelectImgsView alloc]init];
        _baseSelectimgsview.frame = CGRectMake(12, 0, winWidth, 200);
        _baseSelectimgsview.imageCount = 6;
        _baseSelectimgsview.showviewcontroller = self;
        _baseSelectimgsview.imagesMarray = [@[] mutableCopy];
    }
    return _baseSelectimgsview;
}
//现在的时间
-(NSString *)timeNow{
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [NSDate date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    return dateString;
}

# pragma mark  - getter
//无网络
-(NorIneternetView *)internetView
{
    if (nil == _internetView) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"NorIneternetView" owner:self options:nil];
        _internetView = [nibs lastObject];
        //无网络
        _internetView.frame = CGRectMake(0, 0, winWidth, winHeight);
        _internetView.delegate = self;
        _internetView.hidden = YES;
    }
    return _internetView;
}


//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

//网络地址转图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}















// 加密方法
- (NSString*)encrypt:(NSString*)plainText {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [self base64EncodedStringFrom:myData];
    return result;
}
- (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

// 解密方法
- (NSString*)decrypt:(NSString*)encryptText {
    NSData *encryptData = [self dataWithBase64EncodedString:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    return result;
}

- (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

#pragma mark -- 数组排序方法（降序）
- (NSArray *)arraySortDESC:(NSMutableArray *)array{
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1]; //降序
    }];
    NSLog(@"result=%@",result);
    return result;
}





@end
