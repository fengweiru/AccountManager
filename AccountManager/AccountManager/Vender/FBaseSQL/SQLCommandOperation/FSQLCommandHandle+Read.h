//
//  FSQLCommandHandle+Read.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle.h"

@interface FSQLCommandHandle (Read)

- (void)preSqlReadRecordTableName:(NSString *)tableName;

@end
