//
//  AccountOperationViewController.h
//  AccountManager
//
//  Created by fengweiru on 2018/7/23.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "BaseViewController.h"

@class Account;
@interface AccountOperationViewController : BaseViewController

/**
 初始化修改账号信息页面，如果是添加直接调init
 */
- (instancetype)initWithAccount:(Account *)account;

@end
