//
//  Account.h
//  AccountManager
//
//  Created by fengweiru on 2018/7/18.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountTable.h"

@interface Account : FSQLBaseRecord

@property (nonatomic, assign) NSInteger accountId;
@property (nullable, nonatomic, copy) NSString *describ;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *remark;
@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger addTime;
@property (nonatomic, assign) NSUInteger modifyTime;
@property (nonatomic, assign) NSUInteger lookTime;

- (BOOL)addSelf;
- (BOOL)updateSelf;
- (BOOL)updateLookTime;

+ (BOOL)saveDataArr:(NSArray <Account *>*_Nullable)dataArr;
+ (NSArray <Account *>*_Nullable)getDataArr;

@end
