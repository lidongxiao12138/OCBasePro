//
//  Model.h
//  WLHT-Merchant
//
//  Created by yons on 16/7/19.
//  Copyright © 2016年 Hbung. All rights reserved.
//

#import "JSONModel.h"

@interface Model : JSONModel

// 产品ID- 可以设为主键
@property (nonatomic, copy) NSString<Optional> *goods_id;
// 容量
@property (nonatomic, copy) NSString<Optional> *volume;
// 类别ID
@property (nonatomic, copy) NSString<Optional> *category_id;
// 产品title
@property (nonatomic, copy) NSString<Optional> *title;
// 产品图片
@property (nonatomic, copy) NSString<Optional> *img_url;
// 库存数量
@property (nonatomic, copy) NSString<Optional> *pknum ;
// 原价
@property (nonatomic, copy) NSString<Optional> *price;
// 现价
@property (nonatomic, copy) NSString<Optional> *sell_price;
// 产品的子分类id
@property (copy,nonatomic)  NSString <Optional> *son_id;

/*
 *   for 购物车
 */

// 用户购买的数量
@property (copy,nonatomic) NSString <Optional>* quantity;

// 自行添加的一个标识，用于判断该商品是否被选中，十分重要
@property (copy,nonatomic) NSString <Optional> *selected;

// 库存数量--在购物车处用以限制最大数量
@property (copy,nonatomic) NSString <Optional> * stock_quantity;

// 保养包标识
@property (copy,nonatomic) NSString <Optional> * isMaintenance;

// 需要保养的设备名称
@property (copy,nonatomic) NSString <Optional> * DeviceName;

// 需要保养的设备机编号
@property (copy,nonatomic) NSString <Optional> * EQMFSN;

// 需要保养的设备总小时数
@property (copy,nonatomic) NSString <Optional> * Smu;

// 加入到购物车的时间
@property (copy,nonatomic) NSString <Optional> * addTime;

//状态
@property (copy,nonatomic) NSString <Optional> * goods_Type;

//限购数量
@property (copy,nonatomic) NSString <Optional> * goodsLimit;

//真实价格
@property (copy,nonatomic) NSString <Optional> * realTimePrice;


//发车And结束
@property (copy,nonatomic) NSString <Optional> * dispatchNO;//机编号
@property (copy,nonatomic) NSString <Optional> * lat;//经度
@property (copy,nonatomic) NSString <Optional> * lng;//纬度
@property (copy,nonatomic) NSString <Optional> * goCarTime;//出发时间
@property (copy,nonatomic) NSString <Optional> * MaBiaoNum;//码表数
@property (copy,nonatomic) NSString <Optional> * MyPrice;//照片
@property (copy,nonatomic) NSString <Optional> * GoOrEnd;//开始或者结束






- (id)initWithRYDict:(NSDictionary *)dict;


@end
