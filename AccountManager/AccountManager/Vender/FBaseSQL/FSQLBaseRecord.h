//
//  FSQLBaseRecord.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/2.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSQLBaseTableProtocol;

@protocol FSQLBaseRecordProtocol <NSObject>

- (NSDictionary *)dictFromObjectProAndMatchTableColumn:(id<FSQLBaseTableProtocol>)table;
- (void)setRecordProValue:(id)propertyValue property:(NSString *)propertyName;

@end

@interface FSQLBaseRecord : NSObject<FSQLBaseRecordProtocol>

@end
