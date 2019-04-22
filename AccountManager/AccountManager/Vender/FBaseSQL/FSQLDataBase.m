//
//  FSQLDataBase.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLDataBase.h"

@implementation FSQLDataBase

- (instancetype)initWithFileName:(NSString *)dataBaseName
{
    if (self = [super init]) {
        
        _dataBaseName = dataBaseName;
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *fDBFile = [filePath stringByAppendingPathComponent:dataBaseName];
        
        int status = sqlite3_open_v2([fDBFile UTF8String], &_dataBaseSql, SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX | SQLITE_OPEN_READWRITE, NULL);
        
        if (status != SQLITE_OK) {
            NSLog(@"sqlite3_open_v2 fail");
        }
        
    }
    return self;
}

@end
