//
//  DBBaseModel.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/16.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "DBBaseModel.h"

@implementation DBBaseModel

- (BOOL)mapDataWithJson:(id)json
{
    return [self yy_modelSetWithJSON:json];
}

- (BOOL)mapDataWithDictionary:(NSDictionary *)dict
{
    return [self yy_modelSetWithDictionary:dict];
}

- (NSString *)getJsonStringWithData
{
    return [self yy_modelToJSONString];
}

- (NSDictionary *)getDictionaryWithData
{
    return [self yy_modelToJSONObject];
}

- (NSSet *)configureCreateSet {
    return [NSSet new];
}

- (NSString *)getTableName {
    return @"DBBaseModel";
}

@end
