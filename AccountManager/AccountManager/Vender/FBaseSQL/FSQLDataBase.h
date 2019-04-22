//
//  FSQLDataBase.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

/**
 SQL数据库文件类
 */
@interface FSQLDataBase : NSObject

- (instancetype)initWithFileName:(NSString *)dataBaseName;

@property (nonatomic, strong, readonly) NSString *dataBaseName;
@property (nonatomic, assign, readonly) sqlite3 *dataBaseSql;


@end
