//
//  Account.h
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/23.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property (nonatomic, assign) NSInteger accountId;
@property (nullable, nonatomic, copy) NSString *describ;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger addTime;
@property (nonatomic, assign) NSUInteger modifyTime;
@property (nonatomic, assign) NSUInteger lookTime;

+ (NSArray <Account *>*_Nullable)getDataArr;

@end

NS_ASSUME_NONNULL_END
