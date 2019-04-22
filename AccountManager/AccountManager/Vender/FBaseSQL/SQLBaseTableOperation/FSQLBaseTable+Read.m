//
//  FSQLBaseTable+Read.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLBaseTable+Read.h"
#import "FSQLCommandHandle+Read.h"
#import "FSQLBaseRecord.h"

@implementation FSQLBaseTable (Read)

- (NSArray *)getAllRecordFromTable
{
    id<FSQLBaseTableProtocol> tmpSelf = (id<FSQLBaseTableProtocol>)self;
    
    FSQLCommandHandle *sqlCommandHandle = [[FSQLCommandHandle alloc] initWithDataBaseName:[tmpSelf dataBaseName]];
    
    [sqlCommandHandle preSqlReadRecordTableName:[tmpSelf tableName]];
    
    NSArray *tableRecordArr = [sqlCommandHandle sqlExcuteReadCommand];
    
    if (tmpSelf.recordClass) {
        NSMutableArray *baseRecordArr = [NSMutableArray array];
        for (int i = 0; i < tableRecordArr.count; i++) {
            
            FSQLBaseRecord *recordClass = [[tmpSelf.recordClass alloc] init];
            
            NSDictionary *infoDict = tableRecordArr[i];
            [infoDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [recordClass setRecordProValue:obj property:key];
            }];
            
            [baseRecordArr addObject:recordClass];
        }
        
        return [NSMutableArray arrayWithArray:baseRecordArr];
    } else {
     
        return tableRecordArr;
        
    }
    
}

@end
