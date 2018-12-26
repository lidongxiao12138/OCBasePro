//
//  LoginModel.h
//  BookingCar
//
//  Created by mac on 2017/7/4.
//  Copyright © 2017年 LiXiaoJing. All rights reserved.
//

#import "RYBaseModel.h"

@interface LoginModel : RYBaseModel<NSCoding>
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *idTemp;
@property (nonatomic, copy) NSString *fanhuiStr;
@property (nonatomic, copy) NSString *card_number;
@property (nonatomic, copy) NSString *relname;
@property (nonatomic, copy) NSString *deptName;

@property (nonatomic, copy) NSString *employeType;//登录者身份

@property (nonatomic, copy) NSString *dispatchNO;//配载单号
@property (nonatomic, copy) NSString *TeamStatus;//车队状态
@property (nonatomic, copy) NSString *Alladdress;//全局地址


@end
