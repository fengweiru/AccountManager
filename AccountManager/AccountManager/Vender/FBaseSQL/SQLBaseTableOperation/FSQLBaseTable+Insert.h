//
//  FSQLBaseTable+Insert.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FSQLBaseTable.h"

@protocol FSQLBaseRecordProtocol;

@interface FSQLBaseTable (Insert)

- (BOOL)insertDataContainBinary:(id<FSQLBaseRecordProtocol>)object;

@end
