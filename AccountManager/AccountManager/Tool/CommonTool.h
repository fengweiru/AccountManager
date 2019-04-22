//
//  CommonTool.h
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonTool : NSObject

//根据时间戳获取显示时间字符串
+ (NSString *)getChecktimeWithTimestamp:(NSUInteger)timestamp;

@end

NS_ASSUME_NONNULL_END
