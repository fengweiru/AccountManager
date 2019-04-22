//
//  AccountDetailCell.h
//  AccountManager
//
//  Created by fengweiru on 2018/8/31.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    cellTypeDescrib = 1,
    cellTypeUrl,
    cellTypeName,
    cellTypePasswaord,
    cellTypeRemark
}CellType;

typedef enum {
    operationTypeAdd = 1,
    operationTypeLook,
    operationTypeModify
}OperationType;

@protocol AccountDetailCell <NSObject>

- (void)modifyCellType:(CellType)cellType value:(NSString *)value;

@end

@class Account;
@interface AccountDetailCell : UITableViewCell

- (void)configWithCellType:(CellType)cellType account:(Account *)account;

+ (CGFloat)heightForCellType:(CellType)cellType;

@end
