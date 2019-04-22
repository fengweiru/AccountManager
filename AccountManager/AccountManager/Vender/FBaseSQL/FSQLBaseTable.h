//
//  FSQLBaseTable.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSQLBaseTableProtocol <NSObject>

@required

/** db文件名 */
- (NSString *)dataBaseName;

/** 表名 */
- (NSString *)tableName;

/** 表结构 */
- (NSDictionary *)columnValue;


/** 用于读数据， 数据类型Class，如果是nil，那么就是dict */
- (Class)recordClass;

@end

@interface FSQLBaseTable : NSObject

- (BOOL)sqlOperation:(NSString *)sqlStr;

@end
