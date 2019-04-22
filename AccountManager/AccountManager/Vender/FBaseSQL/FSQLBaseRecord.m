//
//  FSQLBaseRecord.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLBaseRecord.h"
#import "FSQLBaseTable.h"
#import <objc/runtime.h>

@implementation FSQLBaseRecord

- (NSDictionary *)dictFromObjectProAndMatchTableColumn:(id<FSQLBaseTableProtocol>)table
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        NSString *keyStr = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        NSString *valueStr = [self valueForKey:keyStr];
        
        if (valueStr == nil) {
            [dict setObject:[NSNull null] forKey:keyStr];
        } else {
            [dict setObject:valueStr forKey:keyStr];
        }

    }
    free(properties);
    
    NSMutableDictionary *columnDict = [NSMutableDictionary dictionary];
    [table.columnValue enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([dict objectForKey:key]) {
            if (![obj.lowercaseString containsString:@"primary key autoincrement"]) {
                [columnDict setObject:[dict objectForKey:key] forKey:key];
            } else {
                [columnDict setObject:@"NULL" forKey:key];
            }
        } else {
            [columnDict setObject:@"" forKey:key];
        }
    }];
    
    return [NSDictionary dictionaryWithDictionary:columnDict];
}

- (void)setRecordProValue:(id)propertyValue property:(NSString *)propertyName
{
    if (!propertyName || propertyName.length == 0) {
        return;
    }
    
    NSString *setterSEL = [NSString stringWithFormat:@"set%@%@:",[[propertyName substringToIndex:1] capitalizedString],[propertyName substringFromIndex:1]];
    
    if ([self respondsToSelector:NSSelectorFromString(setterSEL)]) {
        
        [self setValue:propertyValue forKey:propertyName];
        
    } else {
        
        NSLog(@"%@ has not the property of %@",NSStringFromClass([self class]),propertyName);
        
    }
}

@end
