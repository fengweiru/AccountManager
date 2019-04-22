//
//  FSQLCommandHandle+Read.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle+Read.h"

@implementation FSQLCommandHandle (Read)

- (void)preSqlReadRecordTableName:(NSString *)tableName
{
    self.sqlCommand = [NSMutableString string];
    [self.sqlCommand appendFormat:@"select *from %@",tableName];
}

@end
