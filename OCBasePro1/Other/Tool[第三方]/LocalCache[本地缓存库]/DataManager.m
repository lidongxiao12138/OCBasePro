//
//  DataManager.m
//  MNN-Demo
//
//  Created by yons on 16/4/11.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "DataManager.h"
#import "FMDB.h"
#import "Model.h"
#import "XHToast.h"
 

@implementation DataManager
{
    
    FMDatabase* _database;
}

+ (instancetype)sharedInstance {

    static DataManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareInstance == nil) {
            shareInstance = [[DataManager alloc]init];
        }
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self createDatabase];
    }
    return self;
}

// 创建数据库
- (void)createDatabase{
    
    NSString *dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/data.db"];
   
    NSLog(@"dbpath ----%@",dbPath);
    _database = [[FMDatabase alloc] initWithPath:dbPath];
    [_database open];
    
    if ([_database open]) {
        
    /**
     字段名称

     @param TEXT 机编号
     @param TEXT 经度
     @param TEXT 纬度
     @param TEXT 出发时间
     @param TEXT 码表数
     @param TEXT 我的照片
     @param TEXT 开始/结束
     @return
     */
    NSString*sql =@"create table if not exists REQUIRED (goods_id TEXT, volume TEXT, category_id TEXT, title TEXT, img_url TEXT ,pknum TEXT, price TEXT, sell_price TEXT , quantity TEXT, selected TEXT , stock_quantity TEXT ,son_id TEXT , isMaintenance TEXT , DeviceName TEXT , EQMFSN TEXT , Smu TEXT, dispatchNO TEXT, lat TEXT, lng TEXT, goCarTime TEXT, MaBiaoNum TEXT ,MyPrice TEXT, GoOrEnd TEXT)";
        BOOL res = [_database executeUpdate:sql];
        if (!res) {
            
            NSLog(@"@REQUIRED创建失败");
        }
        
        else{
            
            NSLog(@"@REQUIRED创建成功");
        }

        if (![_database columnExists:@"addTime" inTableWithName:@"REQUIRED"]){
            NSLog(@"添加新字段");
            NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",@"REQUIRED",@"addTime"];
            BOOL res = [_database executeUpdate:alertStr];
            if(res){
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
        }
   }

    [_database close];
}

//在数据库中插入数据--在插入前需要先查询是否有重复
- (void) insertDataToDataBase:(id)model{

    Model* myModel =(Model*)model;


    if ([self isExistForDispatchInDataBase:myModel.dispatchNO]==YES && [self isExistForGoOrEndInDataBase:myModel.GoOrEnd]==YES) {
        [self deleteMyStatusDispatchNo:myModel.dispatchNO GoandEnd:myModel.GoOrEnd];
    }
    
    
    if ([_database open]){

        NSString* insertSQL =[NSString stringWithFormat:@"insert into REQUIRED (goods_id, volume, category_id, title, img_url,pknum , price , sell_price , quantity , selected ,stock_quantity , son_id ,isMaintenance , DeviceName , EQMFSN , Smu , addTime , dispatchNO , lat , lng , goCarTime , MaBiaoNum , MyPrice , GoOrEnd) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@' ,'%@','%@','%@','%@','%@','%@','%@','%@', '%@','%@','%@','%@','%@','%@')",myModel.goods_id,myModel.volume,myModel.category_id,myModel.title,myModel.img_url,myModel.pknum,myModel.price,myModel.sell_price,myModel.quantity,myModel.selected,myModel.stock_quantity,myModel.son_id,myModel.isMaintenance,myModel.DeviceName,myModel.EQMFSN,myModel.Smu,myModel.addTime,myModel.dispatchNO,myModel.lat,myModel.lng,myModel.goCarTime,myModel.MaBiaoNum,myModel.MyPrice,myModel.GoOrEnd];
        
        BOOL res = [_database executeUpdate:insertSQL];

        if (!res){

             NSLog(@"插入数据失败");
        }
         else {
             NSLog(@"插入数据成功");
         }
    }
    [_database close];
}


// required duplicate check
- (BOOL) isExistForDispatchInDataBase:(NSString*)dispatch{
    
    if ([_database open]){
        NSString* sql =@"select * from REQUIRED WHERE dispatchNO = ?";
        FMResultSet*resultSet=[_database executeQuery:sql,dispatch];
        
        if ([resultSet next]) {
            NSLog(@"dispatchNO首选有重复");
            
            [_database close];
            return YES;
            
        }else
        {NSLog(@"dispatchNO首选没有重复");
            [_database close];
            return NO;
        }
    }
    return NO;
}


- (BOOL) isExistForGoOrEndInDataBase:(NSString*)goOrend{

    if ([_database open]){
        NSString* sql =@"select * from REQUIRED WHERE GoOrEnd = ?";
        FMResultSet*resultSet=[_database executeQuery:sql,goOrend];

        if ([resultSet next]) {
            NSLog(@"goOrend首选有重复");
     
            [_database close];
            return YES;

        }else
        {NSLog(@"goOrend首选没有重复");
            [_database close];
            return NO;
        }
    }
    return NO;
}

- (BOOL) isExistForItemsInDataBase:(NSString *)Items{
    
    if ([_database open]){
        NSString* sql =@"select * from REQUIRED WHERE title = ?";
        FMResultSet*resultSet=[_database executeQuery:sql,Items];
        
        if ([resultSet next]) {
            NSLog(@"已存在该保养包");
            
            [_database close];
            return YES;
            
        }else
        {NSLog(@"未存在该保养包");
            [_database close];
            return NO;
        }
    }
    return NO;
}


- (BOOL) isExistForMaintenanceInDataBase:(NSString *)isMaintenance{

    if ([_database open]){
        NSString* sql =@"select * from REQUIRED WHERE isMaintenance = ?";
        FMResultSet*resultSet=[_database executeQuery:sql,isMaintenance];

        if ([resultSet next]) {
            NSLog(@"已存在该保养包");

            [_database close];
            return YES;

        }else
        {NSLog(@"未存在该保养包");
            [_database close];
            return NO;
        }
    }
    return NO;
}




- (BOOL) isExistAnyDataThatSelectedPropertyIsEqual:(NSString *)selected{

    if ([_database open]){
        NSString* sql =@"select * from REQUIRED WHERE selected = ?";
        FMResultSet*resultSet=[_database executeQuery:sql,selected];

        if ([resultSet next]) {
            NSLog(@"存在");

            [_database close];
            return YES;

        }else
        {NSLog(@"不存在");
            [_database close];
            return NO;
        }
    }
    return NO;
}

// 从本地数据库查询 首选数据

- (NSArray*)queryDataBase {
     NSMutableArray*array=[[NSMutableArray alloc]init];
    if ([_database open]) {

    NSString* sql =@"select * from REQUIRED";
    FMResultSet*resultSET=[_database executeQuery:sql];
    while (resultSET.next) {
        Model*model=[[Model alloc]init];
        model.goods_id      = [resultSET stringForColumn:@"goods_id"];
        model.volume        = [resultSET stringForColumn:@"volume"];
        model.category_id    = [resultSET stringForColumn:@"category_id"];
        model.title         = [resultSET stringForColumn:@"title"];
        model.img_url       = [resultSET stringForColumn:@"img_url"];
        model.pknum         = [resultSET stringForColumn:@"pknum"];
        model.price         = [resultSET stringForColumn:@"price"];
        model.sell_price    = [resultSET stringForColumn:@"sell_price"];
        model.quantity      = [resultSET stringForColumn:@"quantity"];
        model.selected      = [resultSET stringForColumn:@"selected"];
        model.stock_quantity = [resultSET stringForColumn:@"stock_quantity"];
        model.son_id        = [resultSET stringForColumn:@"son_id"];
        model.isMaintenance  = [resultSET stringForColumn:@"isMaintenance"];
        model.DeviceName    = [resultSET stringForColumn:@"DeviceName"];
        model.EQMFSN       = [resultSET stringForColumn:@"EQMFSN"];
        model.Smu          = [resultSET stringForColumn:@"Smu"];
        model.addTime          = [resultSET stringForColumn:@"addTime"];
       
        //发车···结束
        model.dispatchNO = [resultSET stringForColumn:@"dispatchNO"];
        model.lat = [resultSET stringForColumn:@"lat"];
        model.lng = [resultSET stringForColumn:@"lng"];
        model.goCarTime = [resultSET stringForColumn:@"goCarTime"];
        model.MaBiaoNum = [resultSET stringForColumn:@"MaBiaoNum"];
        model.MyPrice = [resultSET stringForColumn:@"MyPrice"];
        model.GoOrEnd = [resultSET stringForColumn:@"GoOrEnd"];
        [array addObject:model];
    }
        
    [_database close];
    }
    return array;

}


// 精确查询某个属性，返回数组
- (NSArray*)queryDataBaseWhereProperty:(NSString *)property IsEqual:(NSString *)value {
    NSMutableArray*array=[[NSMutableArray alloc]init];
    if ([_database open]) {

        NSString* sql =[NSString stringWithFormat:@"select * from REQUIRED WHERE %@ = '%@'",property,value];
        FMResultSet*resultSET=[_database executeQuery:sql];
        while (resultSET.next) {
            Model*model=[[Model alloc]init];
            model.goods_id     = [resultSET stringForColumn:@"goods_id"];
            model.volume       = [resultSET stringForColumn:@"volume"];
            model.category_id  = [resultSET stringForColumn:@"category_id"];
            model.title        = [resultSET stringForColumn:@"title"];
            model.img_url      = [resultSET stringForColumn:@"img_url"];
            model.pknum        = [resultSET stringForColumn:@"pknum"];
            model.price        = [resultSET stringForColumn:@"price"];
            model.sell_price   = [resultSET stringForColumn:@"sell_price"];
            model.quantity     = [resultSET stringForColumn:@"quantity"];
            model.selected     = [resultSET stringForColumn:@"selected"];
            model.stock_quantity= [resultSET stringForColumn:@"stock_quantity"];
            model.son_id        = [resultSET stringForColumn:@"son_id"];
            model.isMaintenance = [resultSET stringForColumn:@"isMaintenance"];
            model.DeviceName    = [resultSET stringForColumn:@"DeviceName"];
            model.EQMFSN        = [resultSET stringForColumn:@"EQMFSN"];
            model.Smu           = [resultSET stringForColumn:@"Smu"];
            model.addTime          = [resultSET stringForColumn:@"addTime"];

            [array addObject:model];
        }
        
        [_database close];
    }
    return array;
    
}

// 一键全部修改表中某个参数
- (void) updateRequired: (NSString*)coloumID to:(NSString*)changedValue {
    if ([_database open]) {
        NSString *updateSql = [NSString stringWithFormat:@"update REQUIRED set %@ ='%@' ",coloumID,changedValue];
        BOOL res = [_database executeUpdate:updateSql];

        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [_database close];
    }

}

//修改单条数据
- (void) updateRequired: (NSString*)coloumID to:(NSString*)changedValue where_goods_id:(NSString*)goods_id son_id:(NSString *)son_id isMaintenance:(NSString *)isMaintenance{
    if ([_database open]) {
        NSString *updateSql = [NSString stringWithFormat:@"update REQUIRED set %@ ='%@' where goods_id= '%@' and son_id= '%@' and isMaintenance= '%@'",coloumID,changedValue,goods_id,son_id,isMaintenance];
        BOOL res = [_database executeUpdate:updateSql];
        
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [_database close];
    }
    
}
//从本地数据库删除数据

- (void) deleteSingleDataByGoods_id:(NSString*)goods_id son_id:(NSString *)son_id isMaintenance:(NSString *)isMaintenance{
    if ([_database open]) {
     
    NSString* deleteSQL =[NSString stringWithFormat: @"delete from REQUIRED WHERE goods_id = '%@' and son_id= '%@' and isMaintenance= '%@'",goods_id,son_id,isMaintenance];
    BOOL res  = [_database executeUpdate:deleteSQL];
    if (!res) {
        NSLog(@"required删除失败");
        
    }
    else {
        NSLog(@"required删除成功");
        
    }
    }
    [_database close];
}

//删除单条状态数据
-(void)deleteMyStatusDispatchNo:(NSString *)dispatch GoandEnd:(NSString * )goandend
{
    if ([_database open]) {
        NSString * deleteSQL = [NSString stringWithFormat:@"delete from REQUIRED WHERE dispatchNO = '%@' and GoOrEnd= '%@'",dispatch,goandend];
        BOOL res  = [_database executeUpdate:deleteSQL];
        if (!res) {
            NSLog(@"required删除失败");
            
        }
        else {
            NSLog(@"required删除成功");
            
        }
    }
    [_database close];
}


  // 从本地数据库删除表中所有数据

- (void) deleteAllDataInRequired{
    if ([_database open]) {

    BOOL res = [_database executeUpdate:@"DELETE FROM REQUIRED"];
    if (!res) {
        NSLog(@"REQUIRED全部删除失败");

    }
    else {
        NSLog(@"REQUIRED全部删除成功");
        
    }

   }
    [_database close];

}


 @end
