//
//  DataManager.h
//  MNN-Demo
//
//  Created by yons on 16/4/11.
//  Copyright © 2016年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (instancetype)sharedInstance;
- (instancetype)init;

- (void)createDatabase;

- (void) insertDataToDataBase:(id)model;

- (BOOL) isExistForGoods_idInDataBase:(NSString*)goods_id;

- (BOOL) isExistAnyDataThatSelectedPropertyIsEqual:(NSString *)selected;

- (void) updateRequired: (NSString*)coloumID to:(NSString*)changedValue;

- (NSArray*)queryDataBase;

// 根据某条属性修改全部数据
- (NSArray*)queryDataBaseWhereProperty:(NSString *)property IsEqual:(NSString *)value;

// 修改单条数据
- (void) updateRequired: (NSString*)coloumID to:(NSString*)changedValue where_goods_id:(NSString*)goods_id son_id:(NSString *)son_id isMaintenance:(NSString *)isMaintenance;

// 删除单条数据
- (void) deleteSingleDataByGoods_id:(NSString*)goods_id son_id:(NSString *)son_id isMaintenance:(NSString *)isMaintenance;

//删除单条状态数据
-(void)deleteMyStatusDispatchNo:(NSString *)dispatch GoandEnd:(NSString * )goandend;

- (void) deleteAllDataInRequired;





@end
