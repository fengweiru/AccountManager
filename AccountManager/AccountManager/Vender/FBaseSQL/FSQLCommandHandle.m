//
//  FSQLCommandHandle.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle.h"
#import "FSQLDataBase.h"

@implementation FSQLCommandHandle

- (instancetype)initWithDataBaseName:(NSString *)dataBaseName
{
    if (self = [super init]) {
        self.dataBaseName = dataBaseName;
    }
    return self;
}

- (BOOL)sqlExcuteWriteCommand
{
    if (!self.sqlCommand || self.sqlCommand.length == 0) {
        NSLog(@"sqlCommand is not exists");
        return false;
    }
    
    sqlite3_stmt *stmt;
    int status = sqlite3_prepare_v2(self.dataBase.dataBaseSql, [self.sqlCommand UTF8String], -1, &stmt, 0);
    if (status != SQLITE_OK) {
        NSLog(@"sqlite3_prepare_v2 fail");
        return false;
    } else {
        status = sqlite3_step(stmt);
        if (status != SQLITE_DONE) {
            NSLog(@"sqlite3_step fail");
            return false;
        }
    }
    sqlite3_finalize(stmt);
    return true;
}

- (NSArray *)sqlExcuteReadCommand
{
    if (!self.sqlCommand || self.sqlCommand.length == 0) {
        NSLog(@"sqlCommand is not exists");
        return nil;
    }
    
    sqlite3_stmt *stmt;
    int status = sqlite3_prepare_v2(self.dataBase.dataBaseSql, [self.sqlCommand UTF8String], -1, &stmt, 0);
    
    NSMutableArray *recordArr = nil;
    if (status != SQLITE_OK) {
        NSLog(@"sqlite3_prepare_v2 fail");
    } else {
        
        recordArr = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int columns = sqlite3_column_count(stmt);
            NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i < columns; i++) {
                int type = sqlite3_column_type(stmt, i);
                NSString *keyStr = [NSString stringWithCString:sqlite3_column_name(stmt, i) encoding:NSUTF8StringEncoding];
                if (type == SQLITE_TEXT) {
                    NSString *valueStr = [NSString stringWithCString:(const char *)sqlite3_column_text(stmt, i) encoding:NSUTF8StringEncoding];
                    
                    [infoDict setObject:valueStr forKey:keyStr];
                } else if (type == SQLITE_INTEGER) {
                    NSNumber *valueNum = [NSNumber numberWithInt:sqlite3_column_int(stmt, i)];
                    
                    [infoDict setObject:valueNum forKey:keyStr];
                } else if (type == SQLITE_FLOAT) {
                    NSNumber *valueNum = [NSNumber numberWithFloat:sqlite3_column_double(stmt, i)];
                    
                    [infoDict setObject:valueNum forKey:keyStr];
                } else if (type == SQLITE_BLOB) {
                    int bytes = sqlite3_column_bytes(stmt, i);
                    Byte *value = (Byte *)sqlite3_column_blob(stmt, i);
                    if (bytes != 0 && value != NULL) {
                        NSData *data = [NSData dataWithBytes:value length:bytes];
                        [infoDict setObject:data forKey:keyStr];
                    } else {
                        [infoDict setObject:[NSData data] forKey:keyStr];
                    }
                } else {
                    //其它数据类型
                }
                
            }
            [recordArr addObject:infoDict];
            
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return recordArr;
}

- (FSQLDataBase *)dataBase
{
    if (!_dataBase) {
        _dataBase = [[FSQLDataBase alloc] initWithFileName:self.dataBaseName];
    }
    return _dataBase;
}

@end
