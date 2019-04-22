//
//  SettingSwitchCell.h
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingSwitchCell <NSObject>

//打开密码开关
- (void)openPasswordSwitch;

//更新列表
- (void)reloadTableView;

@end

typedef enum {
    SwitchTypePassword = 1,
    SwitchTypeFingerprintOrFace
}SwitchType;

@interface SettingSwitchCell : UITableViewCell

@property (nonatomic, weak) id<SettingSwitchCell> fdelegate;
@property (nonatomic, weak) NSUserDefaults *userDefaults;

- (void)configWithSwitchType:(SwitchType)switchType;

@end

NS_ASSUME_NONNULL_END
