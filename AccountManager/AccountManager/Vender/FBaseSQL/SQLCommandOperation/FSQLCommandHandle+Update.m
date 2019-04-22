//
//  FSQLCommandHandle+Update.m
//  AccountManager
//
//  Created by fengweiru on 2019/4/10.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle+Update.h"

@implementation FSQLCommandHandle (Update)

- (void)preSqlUpdateRecordTableName:(NSString *)tableName columnInfo:(nonnull NSDictionary *)columnInfo
{
    self.sqlCommand = [NSMutableString string];
    
    NSMutableArray *columnKeyArr = [NSMutableArray array];
    NSMutableArray *columnValueArr = [NSMutableArray array];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        if (key.length == 0) {
            NSLog(@"invalid key in preSqlUpdateToTableName:columnInfo:");
        } else {
            [columnKeyArr addObject:key];
        }
        
    }];
}

@end
