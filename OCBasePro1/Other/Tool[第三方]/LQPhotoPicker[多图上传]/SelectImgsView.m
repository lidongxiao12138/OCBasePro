//
//  SelectImgsView.m
//  DepthSZ
//
//  Created by yons on 16/10/31.
//  Copyright © 2016年 於建光. All rights reserved.
//

#import "SelectImgsView.h"
#define PlaceColor RGBColor(153, 153, 153)

#import <AssetsLibrary/AssetsLibrary.h>
#import "LQImgPickerActionSheet.h"
#import "JJPhotoManeger.h"
#import "CalculationTool.h"
@interface SelectImgsView()<LQImgPickerActionSheetDelegate,UIActionSheetDelegate,JJPhotoDelegate>{

    NSInteger LQPhotoPicker_imgMaxCount;
}

//选择图片
@property (nonatomic,strong) LQImgPickerActionSheet *imgPickerActionSheet;
//图片选择器
@property (nonatomic,strong) UIViewController *showActionSheetViewController;
@property (nonatomic,strong) NSMutableArray *selectimgAssetarray; 



@end

@implementation SelectImgsView

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
            UILabel * lab = [[UILabel alloc]init];
            lab.frame = CGRectMake(0, 0, 10, 10);
            lab.backgroundColor = kRedColor;
//            [Pushimgview addSubview:lab];
            
            if (i == self.imagesMarray.count) {
                Pushimgview.image = [UIImage imageNamed:(@"plus")];
                UITapGestureRecognizer *tapPushimgview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNewImg)];
                [Pushimgview addGestureRecognizer:tapPushimgview];
            }else{
#define mark---- 加载网络图片
                Pushimgview.image = self.imagesMarray[i];
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
    if (self.imagesMarray.count == LQPhotoPicker_imgMaxCount) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                             
                                                      message:[NSString stringWithFormat:@"您最多选择%ld张图片哦!",(long)LQPhotoPicker_imgMaxCount]
                             
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
    
    if (self.selectimgAssetarray) {
        _imgPickerActionSheet.arrSelected = self.selectimgAssetarray;
    }
    if (self.imageCount) {
        LQPhotoPicker_imgMaxCount =self.imageCount;
    }
    _imgPickerActionSheet.maxCount = LQPhotoPicker_imgMaxCount;
    [_imgPickerActionSheet showImgPickerActionSheetInView:self.showviewcontroller];
}

- (void)tapbigPushimgview:(UITapGestureRecognizer*)tapview{
    UIImageView *imgview = (UIImageView *)tapview.view;
    imgview.image = [self getBigIamgeWithALAsset:self.selectimgAssetarray[imgview.tag]];

    JJPhotoManeger *mg = [JJPhotoManeger maneger];
    mg.delegate = self;
    [mg showLocalPhotoViewer:@[imgview] selecImageindex:imgview.tag];

}

- (void)deletebtn:(UIButton *)sender{

    typeof (self) __weak  weakself = self;
    
    [weakself.imagesMarray removeObjectAtIndex:sender.tag];
    [weakself.selectimgAssetarray removeObjectAtIndex:sender.tag];
    [weakself.selectdailibigImgDataArray removeObjectAtIndex:sender.tag];

    [weakself ChangeImgsUI];
    
    if (_Valuechangeblock) {
        _Valuechangeblock();
    }
}

- (void)DidValuechangeblock:(SelectImgsViewblock)block{
    _Valuechangeblock = block;
}

#pragma mark - LQImgPickerActionSheetDelegate (返回选择的图片：缩略图，压缩原长宽比例大图)
- (void)getSelectImgWithALAssetArray:(NSArray*)ALAssetArray thumbnailImgImageArray:(NSArray*)thumbnailImgArray{

        //（ALAsset）类型 Array
        self.selectimgAssetarray = [NSMutableArray arrayWithArray:ALAssetArray];
    
    for (int i = 0 ; i < thumbnailImgArray.count; i ++) {
        UIImage * image = thumbnailImgArray[i];
        NSString * strTime = [NSString getCurrentTimes];
        LoginModel * login = [LoginDataModel sharedManager].loginInModel;
        image = [self addressnormalizedImage:image withText:[NSString stringWithFormat:@"姓名：%@ \n %@ \n %@",login.relname,login.Alladdress,strTime] waterImageRect:CGRectMake(0, 0, 30 * 5, 30 * 5)];
        [self.imagesMarray addObject:image];
    }
        //正方形缩略图 Array
//        self.imagesMarray = [NSMutableArray arrayWithArray:thumbnailImgArray];
    NSMutableArray * PngArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < thumbnailImgArray.count; i ++) {
        [PngArr addObject:thumbnailImgArray[i]];
    }
    [self setImagesMarray:PngArr];

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.selectdailibigImgDataArray removeAllObjects];
            for (int i = 0; i < self.selectimgAssetarray.count; i++) {
                UIImage * imageAsset = [self getBigIamgeWithALAsset:self.selectimgAssetarray[i]];
//图片or文字
//                imageAsset  = [self jx_WaterImageWithImage:imageAsset waterImage:[UIImage imageNamed:@"HeadPhoto"] waterImageRect:CGRectMake(300 * 5, 300 * 5, 300 * 5, 300 * 5)];
                NSString * strTime = [NSString getCurrentTimes];
                LoginModel * login = [LoginDataModel sharedManager].loginInModel;
                imageAsset = [self normalizedImage:imageAsset withText:[NSString stringWithFormat:@" 姓名：%@ \n %@ \n %@",login.relname,login.Alladdress,strTime] waterImageRect:CGRectMake(0, 0, 800 * 5, 500 * 5)];
                NSData * imageData = [self image_TransForm_Data:imageAsset];
                [self.selectdailibigImgDataArray addObject:imageData];
            }
        });
    if (_Valuechangeblock) {
        _Valuechangeblock();
    }

}

- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset
{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
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

// 给图片添加图片水印
- (UIImage *)jx_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.获取图片
    
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


- (UIImage *)normalizedImage:(UIImage*)image withText:(NSString *)text waterImageRect:(CGRect)ImageRect{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    //    绘制文字
    [[UIColor blackColor] set];
    CGRect rect = ImageRect;
    //这里设置了字体，和倾斜度，具体其他参数
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:30 * 5],
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
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor redColor]};
    [text drawInRect:rect withAttributes:dic];
    
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}



@end
