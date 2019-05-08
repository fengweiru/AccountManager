//
//  Account.m
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/23.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "Account.h"
#import <sqlite3.h>

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
    self.accountId = [aDecoder decodeIntegerForKey:@"accountId"];
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
    [aCoder encodeInteger:self.accountId forKey:@"accountId"];
    [aCoder encodeObject:self.describ forKey:@"describ"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeInteger:self.addTime forKey:@"addTime"];
    [aCoder encodeInteger:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeInteger:self.lookTime forKey:@"lookTime"];
}

+ (NSArray <Account *>*)getDataArr
{
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:[Account dataFilePath]];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
    NSData *data = [userDefaults objectForKey:accountFileName];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}

+ (NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:accountFileName];
}

@end
