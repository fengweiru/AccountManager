//
//  FSQLBaseTable+Insert.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLBaseTable+Insert.h"
#import "FSQLBaseRecord.h"
#import "FSQLCommandHandle+insert.h"

@implementation FSQLBaseTable (Insert)

- (BOOL)insertDataContainBinary:(id<FSQLBaseRecordProtocol>)object
{
    id<FSQLBaseTableProtocol> tmpSelf = (id<FSQLBaseTableProtocol>) self;
    
    FSQLCommandHandle *sqlCommandHandle = [[FSQLCommandHandle alloc] init];
    sqlCommandHandle.dataBaseName = [tmpSelf dataBaseName];
    
    NSDictionary *columnDict = [object dictFromObjectProAndMatchTableColumn:tmpSelf];
    
    [sqlCommandHandle preSqlInsertToTableName:[tmpSelf tableName] columnInfo:columnDict];
    
    return [sqlCommandHandle sqlExcuteWriteCommand];
    
}

@end
