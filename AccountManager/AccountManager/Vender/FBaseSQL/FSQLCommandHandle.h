//
//  FSQLCommandHandle.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FSQLDataBase;

/**
 SQL基础封装
 */
@interface FSQLCommandHandle : NSObject

- (instancetype)initWithDataBaseName:(NSString *)dataBaseName;

@property (nonatomic, strong) NSString *dataBaseName;
@property (nonatomic, strong) NSMutableString *sqlCommand;
@property (nonatomic, strong) FSQLDataBase *dataBase;


/**
 写操作（创建表和增删改）
 */
- (BOOL)sqlExcuteWriteCommand;

/**
 读操作（查）
 */
- (NSArray *)sqlExcuteReadCommand;

@end
