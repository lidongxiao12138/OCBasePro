//
//  ChargePhotoView.m
//  LogisticsPro
//
//  Created by 李东晓 on 2018/9/11.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import "ChargePhotoView.h"
#define PlaceColor RGBColor(153, 153, 153)

#import <AssetsLibrary/AssetsLibrary.h>
#import "LQImgPickerActionSheet.h"
#import "JJPhotoManeger.h"
#import "CalculationTool.h"

@interface ChargePhotoView()<LQImgPickerActionSheetDelegate,UIActionSheetDelegate,JJPhotoDelegate>{
    
    NSInteger LQPhotoPicker_imgMaxCount;
    NSMutableArray * PhotoArr1;
}
//选择图片
@property (nonatomic,strong) LQImgPickerActionSheet *imgPickerActionSheet;
//图片选择器
@property (nonatomic,strong) UIViewController *showActionSheetViewController;
@property (nonatomic,strong) NSMutableArray *selectimgAssetarray;


@end

@implementation ChargePhotoView

- (instancetype)init{
    if (self = [super init]) {
        self.selectimgAssetarray = [@[]mutableCopy];
        self.selectdailibigImgDataArray = [@[]mutableCopy];
    }
    return self;
}
- (void)setImagesMarray:(NSMutableArray *)imagesMarray{
    _imagesMarray = imagesMarray;
    [self ChangeImgsUI];
}

- (void)ChangeImgsUI{
    LQPhotoPicker_imgMaxCount = self.imageCount;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int margin = 3;
    int col = 5;
    float Pwidth = ([UIScreen mainScreen].bounds.size.width - margin*(col + 1) - 30)/col;
    if (self.imagesMarray.count == 0) {
        //添加图片提示
        UILabel *addimgla = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 200, 20)];
        addimgla.text = @"  选择图片";
        addimgla.font = [UIFont systemFontOfSize:13];
        addimgla.textColor = [UIColor grayColor];
        [self addSubview:addimgla];
        self.addImgStrLabel = addimgla;
        
        
        UIImageView *Pushimgview = [[UIImageView alloc]init];
        Pushimgview.frame = CGRectMake(margin , margin ,Pwidth,Pwidth );
        Pushimgview.image = [UIImage imageNamed:@"plus"];
        Pushimgview.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:Pushimgview];
        Pushimgview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapPushimgview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNewImg)];
        [Pushimgview addGestureRecognizer:tapPushimgview];
        
        self.addImgStrLabel.frame = CGRectMake(2*margin + Pwidth, margin ,200,Pwidth );
        
        self.height = [CalculationTool rowWithcount:(self.imagesMarray.count + 1) andcol:col]*(Pwidth + 2*margin) ;
    }else{
        
        for (int i = 0; i < self.imagesMarray.count + 1; i++) {
            int page = i/col;
            int index = i%col;
            UIImageView *Pushimgview = [[UIImageView alloc]init];
            Pushimgview.frame = CGRectMake(margin + index*Pwidth + margin*index,(2*margin + Pwidth)*page + margin ,Pwidth,Pwidth );
            Pushimgview.tag = i;
            Pushimgview.contentMode = UIViewContentModeScaleToFill;
            [self addSubview:Pushimgview];
            Pushimgview.userInteractionEnabled = YES;
            if (i == self.imagesMarray.count) {
                Pushimgview.image = [UIImage imageNamed:(@"plus")];
                UITapGestureRecognizer *tapPushimgview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNewImg)];
                [Pushimgview addGestureRecognizer:tapPushimgview];
            }else{
#define mark---- 加载网络图片
                if ([self.HavePhoto isEqualToString:@"1"]) {
         
                    NSString * ImageStr = [NSString stringWithFormat:@"%@",self.imagesMarray[i]];
                    if ([ImageStr rangeOfString:@".PNG"].location !=NSNotFound) {
                        Pushimgview.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@lgs_getImageByImageName.do?imageName=%@",BaseURL,self.imagesMarray[i]]];
                    }else
                    {
                        Pushimgview.image = self.imagesMarray[i];
                    }
                    
                }else
                {
                    Pushimgview.image = self.imagesMarray[i];
                }
                
                UITapGestureRecognizer *tapbigPushimgview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapbigPushimgview:)];
                [Pushimgview addGestureRecognizer:tapbigPushimgview];
                
                UIButton *deletebuton = [[UIButton alloc]init];
                [deletebuton setImage:[UIImage imageNamed:(@"imgclose")] forState:UIControlStateNormal];
                deletebuton.tag = i;
                deletebuton.frame = CGRectMake(Pwidth - 20,0,20,20);
                [deletebuton addTarget:self action:@selector(deletebtn:) forControlEvents:UIControlEventTouchUpInside];
                [Pushimgview addSubview:deletebuton];
            }
        }
        self.height = [CalculationTool rowWithcount:(self.imagesMarray.count + 1) andcol:col]*(Pwidth + 2*margin) ;
    }
}



- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)addNewImg{
    if (self.imagesMarray.count == self.imageCount) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                             
                                                      message:[NSString stringWithFormat:@"您最多选择%ld张图片哦!",(long)self.imageCount]
                             
                                                     delegate:nil
                             
                                            cancelButtonTitle:@"知道了"
                             
                                            otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[LQImgPickerActionSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
//    self.selectimgAssetarray = self.imagesMarray;
    if (self.selectimgAssetarray) {
        _imgPickerActionSheet.arrSelected = self.selectimgAssetarray;
    }

    if (self.imageCount) {
        LQPhotoPicker_imgMaxCount =self.imageCount - self.imagesMarray.count;
    }
    NSMutableArray * PhotoArr = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < self.imagesMarray.count; i ++) {
        if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location !=NSNotFound) {
            [PhotoArr addObject:self.imagesMarray[i]];
        }
    }

    LQPhotoPicker_imgMaxCount = self.imageCount - PhotoArr.count;
    _imgPickerActionSheet.maxCount = LQPhotoPicker_imgMaxCount;
    [_imgPickerActionSheet showImgPickerActionSheetInView:self.showviewcontroller];
}

- (void)tapbigPushimgview:(UITapGestureRecognizer*)tapview{
    UIImageView *imgview = (UIImageView *)tapview.view;
    

    
    if ([self.HavePhoto isEqualToString:@"1"]) {
//        imgview.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@lgs_getImageByImageName.do?imageName=%@",BaseURL,self.selectimgAssetarray[imgview.tag]]];
        
        NSMutableArray * seleImage = [[NSMutableArray alloc]init];
        //筛选出.png后缀的字符串然后删除，从新添加
        for (int i = 0 ; i < self.imagesMarray.count; i ++) {
            if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
                [seleImage addObject:self.imagesMarray[i]];
            }
        }

        if (imgview.tag < seleImage.count) {
            PhotoArr1 = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < self.imagesMarray.count; i ++) {
                if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
                    NSString * strimages = [NSString stringWithFormat:@"%@lgs_getImageByImageName.do?imageName=%@",BaseURL,self.imagesMarray[i]];
                    [PhotoArr1 addObject:strimages];
                }
            }
            [imgview setImageURL:PhotoArr1[imgview.tag]];
            JJPhotoManeger *mg = [JJPhotoManeger maneger];
            mg.delegate = self;
            [mg showNetworkPhotoViewer:@[imgview] urlStrArr:self.imagesMarray selecImageindex:imgview.tag];
        }else
        {
//            self.selectimgAssetarray = [[NSMutableArray alloc]init];
//            for (int i = 0 ; i < self.imagesMarray.count; i ++) {
//                if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
//                    NSString * strimages = [NSString stringWithFormat:@"%@lgs_getImageByImageName.do?imageName=%@",BaseURL,self.imagesMarray[i]];
//                    [self.selectimgAssetarray addObject:strimages];
//                }else
//                {
//                    [self.selectimgAssetarray addObject:self.imagesMarray[i]];
//                }
//            }
            PhotoArr1 = [[NSMutableArray alloc]init];
            for (int i = 0 ; i < self.imagesMarray.count; i ++) {
                if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
                    NSString * strimages = [NSString stringWithFormat:@"%@lgs_getImageByImageName.do?imageName=%@",BaseURL,self.imagesMarray[i]];
                    [PhotoArr1 addObject:strimages];
                }
            }
            JJPhotoManeger *mg = [JJPhotoManeger maneger];
            mg.delegate = self;
            imgview.image = [self getBigIamgeWithALAsset:self.selectimgAssetarray[imgview.tag - PhotoArr1.count]];
            [mg showLocalPhotoViewer:@[imgview] selecImageindex:imgview.tag - PhotoArr1.count];
        }
        

    }else
    {
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        imgview.image = [self getBigIamgeWithALAsset:self.selectimgAssetarray[imgview.tag]];
        [mg showLocalPhotoViewer:@[imgview] selecImageindex:imgview.tag];

    }
}

//删除图片
-(void)requsetDeletePicByImageName:(NSString *)imageName
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
   
    [params setObject:imageName forKey:@"imageName"];

    [[LDXNetworking sharedInstance]POST:k_BASE_URL(KDeletePicByImageName) parameters:params success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);

        [XcwGifHUD HideXcwGifHUD];
    } failure:^(NSError * _Nonnull error) {
        [XcwGifHUD HideXcwGifHUD];
    }];
}

- (void)deletebtn:(UIButton *)sender{
    
    typeof (self) __weak  weakself = self;
    
    [weakself.imagesMarray removeObjectAtIndex:sender.tag];
    if ([self.HavePhoto isEqualToString:@"1"]) {
        NSMutableArray * PhotoArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.imagesMarray.count; i ++) {
            if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
                [PhotoArray addObject:self.imagesMarray[i]];
            }
        }
        
        if (weakself.selectimgAssetarray.count > 0) {
            [weakself.selectimgAssetarray removeObjectAtIndex:sender.tag - PhotoArray.count];
            [self requsetDeletePicByImageName:weakself.selectimgAssetarray[sender.tag - PhotoArray.count]];
        }
    }else
    {
        [weakself.selectimgAssetarray removeObjectAtIndex:sender.tag];
        [weakself.selectdailibigImgDataArray removeObjectAtIndex:sender.tag];
    }
    [weakself ChangeImgsUI];
    
    if (_Valuechangeblock) {
        _Valuechangeblock();
    }
}

- (void)DidValuechangeblock:(ChargePhotoViewblock)block{
    _Valuechangeblock = block;
}

#pragma mark - LQImgPickerActionSheetDelegate (返回选择的图片：缩略图，压缩原长宽比例大图)
- (void)getSelectImgWithALAssetArray:(NSArray*)ALAssetArray thumbnailImgImageArray:(NSArray*)thumbnailImgArray{
    
    //（ALAsset）类型 Array
    self.selectimgAssetarray = [NSMutableArray arrayWithArray:ALAssetArray];
   
    if ([self.HavePhoto isEqualToString:@"1"]) {
        //筛选出.png后缀的字符串然后删除，从新添加
        NSMutableArray * PngArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.imagesMarray.count; i ++) {
            if ([[NSString stringWithFormat:@"%@",self.imagesMarray[i]] rangeOfString:@".PNG"].location != NSNotFound) {
                [PngArr addObject:self.imagesMarray[i]];
            }
        }
        

        for (int i = 0; i < thumbnailImgArray.count; i ++) {
            [PngArr addObject:thumbnailImgArray[i]];
        }
        [self setImagesMarray:PngArr];

    }else
    {
        //正方形缩略图 Array
        self.imagesMarray = [NSMutableArray arrayWithArray:thumbnailImgArray];
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.selectdailibigImgDataArray removeAllObjects];
        for (int i = 0; i < self.selectimgAssetarray.count; i++) {
//            NSData *imageData = [self getBigIamgeDataWithALAsset:self.selectimgAssetarray[i]];
            UIImage * imageAsset = [self getBigIamgeWithALAsset:self.selectimgAssetarray[i]];

            NSString * strTime = [NSString getCurrentTimes];
            LoginModel * login = [LoginDataModel sharedManager].loginInModel;
            imageAsset = [self normalizedImage:imageAsset withText:[NSString stringWithFormat:@" 姓名：%@ \n 地址：%@ \n %@",login.relname,login.Alladdress,strTime] waterImageRect:CGRectMake(0, 0, 800 * 5, 500 * 5)];
            NSData * imageData = [self image_TransForm_Data:imageAsset];
            [self.selectdailibigImgDataArray addObject:imageData];
        }
    });
    if (_Valuechangeblock) {
        _Valuechangeblock();
    }
    
}

#pragma mark - 选择图片 防止崩溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (NSData*)getBigIamgeDataWithALAsset:(ALAsset*)set{
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    
    return UIImageJPEGRepresentation(img, 0.5);
}

- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    NSData *imageData = [self getBigIamgeDataWithALAsset:set];
    return [UIImage imageWithData:imageData];
}


- (NSData *)image_TransForm_Data:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    //几乎是按0.5图片大小就降到原来的一半
    return imageData;
    
}

- (UIImage *)normalizedImage:(UIImage*)image withText:(NSString *)text waterImageRect:(CGRect)ImageRect{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    //    绘制文字
    [[UIColor blackColor] set];
    CGRect rect = ImageRect;
    //这里设置了字体，和倾斜度，具体其他参数
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30 * 5],
                          NSForegroundColorAttributeName:[UIColor whiteColor]};
    [text drawInRect:rect withAttributes:dic];
    
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (UIImage *)addressnormalizedImage:(UIImage*)image withText:(NSString *)text waterImageRect:(CGRect)ImageRect{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    //    绘制文字
    [[UIColor redColor] set];
    CGRect rect = ImageRect;
    //这里设置了字体，和倾斜度，具体其他参数
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    [text drawInRect:rect withAttributes:dic];
    
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
