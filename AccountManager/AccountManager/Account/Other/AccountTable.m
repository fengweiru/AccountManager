//
//  AccountTable.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/3.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "AccountTable.h"
#import "Account.h"

@implementation AccountTable

+ (instancetype)shareAccountTable
{
    static AccountTable *accountTable = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountTable = [[AccountTable alloc] init];
    });
    return accountTable;
}

- (NSString *)dataBaseName
{
    return @"account.db";
}

- (NSString *)tableName
{
    return @"account";
}

- (NSDictionary *)columnValue
{
    return @{@"accountId":@"integer primary key autoincrement",
             @"describ":@"char",
             @"name":@"char",
             @"password":@"char",
             @"remark":@"char",
             @"url":@"char",
             @"addTime":@"integer",
             @"modifyTime":@"integer",
             @"lookTime":@"integer"
             };
}

- (Class)recordClass
{
    return [Account class];
}

@end
