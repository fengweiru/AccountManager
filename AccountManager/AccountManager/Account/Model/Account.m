//
//  Account.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/18.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "Account.h"

static NSString *accountFileName = @"accounts";

@interface Account ()<NSCoding,NSCopying>

@end

@implementation Account

- (instancetype)init
{
    if (self = [super init]) {
        self.accountId = -1;
        self.describ = @"";
        self.name = @"";
        self.password = @"";
        self.remark = @"";
        self.url = @"";
        self.addTime = [[NSDate date] timeIntervalSince1970];
        self.modifyTime = [[NSDate date] timeIntervalSince1970];
        self.lookTime = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    Account *tmp = [[Account alloc] init];
    tmp.accountId = self.accountId;
    tmp.describ = [self.describ copy];
    tmp.name = [self.name copy];
    tmp.password = [self.password copy];
    tmp.remark = [self.remark copy];
    tmp.url = [self.url copy];
    tmp.addTime = self.addTime;
    tmp.modifyTime = self.modifyTime;
    tmp.lookTime = self.lookTime;
    return tmp;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.describ = [aDecoder decodeObjectForKey:@"describ"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.password = [aDecoder decodeObjectForKey:@"password"];
    self.remark = [aDecoder decodeObjectForKey:@"remark"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.addTime = [aDecoder decodeIntegerForKey:@"addTime"];
    self.modifyTime = [aDecoder decodeIntegerForKey:@"modifyTime"];
    self.lookTime = [aDecoder decodeIntegerForKey:@"lookTime"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.describ forKey:@"describ"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeInteger:self.addTime forKey:@"addTime"];
    [aCoder encodeInteger:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeInteger:self.lookTime forKey:@"lookTime"];
}

- (BOOL)addSelf
{
    self.addTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
    self.modifyTime = self.addTime;
    self.lookTime = self.addTime;
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[Account getDataArr]];
    
    NSInteger max = 0;
    for (Account *account in arr) {
        max = (max>account.accountId?max:account.accountId);
    }
    self.accountId = max + 1;
    [arr addObject:self];
    return [Account saveDataArr:[NSArray arrayWithArray:arr]];
//    return [[AccountTable shareAccountTable] insertDataContainBinary:self];
}
- (BOOL)updateSelf
{
    self.modifyTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
//
//    NSString *tableName = [[AccountTable shareAccountTable] tableName];
//
//    NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = '%@',%@ = %lu,%@ = %ld,%@ = %ld where accountId = %ld",tableName,@"describ",self.describ,@"name",self.name,@"password",self.password,@"remark",self.remark,@"url",self.url,@"addTime",self.addTime,@"modifyTime",self.modifyTime,@"lookTime",self.lookTime,self.accountId];
    
//    return [[AccountTable shareAccountTable] sqlOperation:sqlStr];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[Account getDataArr]];
    NSInteger dataSeq = -1;
    for (NSInteger i = 0; i < arr.count; i++) {
        Account *account = arr[i];
        if (account.accountId == self.accountId) {
            dataSeq = i;
            break;
        }
    }
    if (dataSeq != -1) {  //说明存在
        arr[dataSeq] = self;
    } else {
        [arr addObject:self];
        
    }
    return [Account saveDataArr:[NSArray arrayWithArray:arr]];
}
- (BOOL)updateLookTime
{
//    NSString *tableName = [[AccountTable shareAccountTable] tableName];
//
//    NSString *sqlStr = [NSString stringWithFormat:@"update %@ set %@ = %ld where accountId = %ld",tableName,@"lookTime",self.lookTime,self.accountId];
//
//    return [[AccountTable shareAccountTable] sqlOperation:sqlStr];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[Account getDataArr]];
    NSInteger dataSeq = -1;
    for (NSInteger i = 0; i < arr.count; i++) {
        Account *account = arr[i];
        if (account.accountId == self.accountId) {
            dataSeq = i;
            break;
        }
    }
    if (dataSeq != -1) {  //说明存在
        ((Account *)arr[dataSeq]).lookTime = self.lookTime;
        return [Account saveDataArr:[NSArray arrayWithArray:arr]];
    }
    return false;
}

//保存数据
+ (BOOL)saveDataArr:(NSArray <Account *>*)dataArr
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArr];
    if (data) {
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
        [userDefaults setObject:data forKey:accountFileName];
        return true;
    }
    return false;
//    return [NSKeyedArchiver archiveRootObject:dataArr toFile:[self dataFilePath]];
}

+ (NSArray <Account *>*)getDataArr
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
    NSData *data = [userDefaults objectForKey:accountFileName];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePath]];
}

+ (NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:accountFileName];
}

@end
