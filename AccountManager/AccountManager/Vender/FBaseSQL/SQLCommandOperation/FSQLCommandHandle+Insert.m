//
//  FSQLCommandHandle+Insert.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle+Insert.h"

@implementation FSQLCommandHandle (Insert)

- (void)preSqlInsertToTableName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    // @"insert into eoctable values('%@', '%@')"
    self.sqlCommand = [NSMutableString string];
    
    NSMutableArray *columnKeyArr = [NSMutableArray array];
    NSMutableArray *columnValueArr = [NSMutableArray array];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if (key.length == 0) {
            NSLog(@"invalid key in preSqlInsertToTableName:columnInfo:");
        } else {
            [columnKeyArr addObject:key];
            
            NSString *valueStr = [NSString stringWithFormat:@"'%@'",obj];
            if ([obj isKindOfClass:[NSString class]] && [obj.lowercaseString isEqualToString:@"null"]) {
                valueStr = [NSString stringWithFormat:@"%@",obj];
            }
            
            [columnValueArr addObject:valueStr];
        }
        
    }];
    
    NSString *keyStructStr = [columnKeyArr componentsJoinedByString:@","];
    NSString *valueStructStr = [columnValueArr componentsJoinedByString:@","];
    [self.sqlCommand appendFormat:@"insert into %@(%@) values(%@)",tableName,keyStructStr,valueStructStr];
    
}

@end
