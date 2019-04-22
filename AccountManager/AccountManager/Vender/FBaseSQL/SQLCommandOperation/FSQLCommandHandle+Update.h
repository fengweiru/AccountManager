//
//  FSQLCommandHandle+Update.h
//  AccountManager
//
//  Created by fengweiru on 2019/4/10.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "FSQLCommandHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSQLCommandHandle (Update)

- (void)preSqlUpdateRecordTableName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;

@end

NS_ASSUME_NONNULL_END
