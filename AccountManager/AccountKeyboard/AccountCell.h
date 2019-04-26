//
//  AccountCell.h
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/25.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AccountCellDelegate <NSObject>

- (void)inputString:(NSString *)string;

@end

@class Account;
@interface AccountCell : UITableViewCell

@property (nonatomic, weak) id<AccountCellDelegate> delegate;

- (void)configWithAccount:(Account *)account;

@end

NS_ASSUME_NONNULL_END
