//
//  FSQLBaseTable.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLBaseTable.h"
#import "FSQLCommandHandle.h"
#import "FSQLCommandHandle+CreateTable.h"

@implementation FSQLBaseTable



/**
 创建文件db 和 表
 */
- (instancetype)init
{
    if (self = [super init]) {
        
        if ([self conformsToProtocol:@protocol(FSQLBaseTableProtocol)]) {
            
            id<FSQLBaseTableProtocol> tmpSelf = (id<FSQLBaseTableProtocol>)self;
            FSQLCommandHandle *sqlCommandHandle = [[FSQLCommandHandle alloc] initWithDataBaseName:[tmpSelf dataBaseName]];
            //备注：用懒加载的方式来创建db文件 （只有涉及到sql语句执行的时候，才去创建）
            
            [sqlCommandHandle preSqlCreateTable:[tmpSelf tableName] columnInfo:[tmpSelf columnValue]];
            
            [sqlCommandHandle sqlExcuteWriteCommand];
            
        } else {
            
            NSException *exception = [NSException exceptionWithName:@"FSQLBaseTable Error" reason:@"FSQLBaseTableProtocol no conform" userInfo:nil];
            [exception raise];
            
        }
        
    }
    return self;
}

- (BOOL)sqlOperation:(NSString *)sqlStr
{
    id<FSQLBaseTableProtocol> tmpSelf = (id<FSQLBaseTableProtocol>) self;
    
    FSQLCommandHandle *sqlCommandHandle = [[FSQLCommandHandle alloc] init];
    sqlCommandHandle.dataBaseName = [tmpSelf dataBaseName];
    
    sqlCommandHandle.sqlCommand = [NSMutableString stringWithFormat:@"%@",sqlStr];
    
    return [sqlCommandHandle sqlExcuteWriteCommand];
}

@end
