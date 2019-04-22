//
//  AccountTable.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/3.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "FTableFrame.h"

@interface AccountTable : FSQLBaseTable <FSQLBaseTableProtocol>

+ (instancetype)shareAccountTable;

@end
