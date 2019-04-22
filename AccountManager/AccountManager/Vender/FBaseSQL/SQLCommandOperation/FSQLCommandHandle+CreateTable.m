//
//  FSQLCommandHandle+CreateTable.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle+CreateTable.h"

@implementation FSQLCommandHandle (CreateTable)

- (void)preSqlCreateTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    //  @"create table if not exists eoctable(id char, name char)"
    self.sqlCommand = [NSMutableString string];
    
    NSMutableArray *columnArr = [NSMutableArray array];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString* _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        if (key.length == 0 || obj.length == 0) {
            NSLog(@"preSqlCreateTable error");
        } else {
            NSString *columnStr = [NSString stringWithFormat:@"%@ %@",key, obj];
            [columnArr addObject:columnStr];
        }
    }];
    
    NSString *tableStructStr = [columnArr componentsJoinedByString:@","];
    [self.sqlCommand appendFormat:@"create table if not exists %@(%@)",tableName, tableStructStr];
}

@end
