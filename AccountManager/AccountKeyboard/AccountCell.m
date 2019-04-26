//
//  AccountCell.m
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/25.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "AccountCell.h"
#import "Account.h"

@interface AccountCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *accountButton;
@property (nonatomic, strong) UILabel *accountDescLabel;
@property (nonatomic, strong) UIButton *passwordButton;
@property (nonatomic, strong) UILabel *passwordDescLabel;


@end

@implementation AccountCell

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.layer.borderWidth = 1;
//        _nameLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return _nameLabel;
}

- (UIButton *)accountButton
{
    if (!_accountButton) {
        _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _accountButton.layer.borderWidth = 1;
//        _accountButton.layer.borderColor = [[UIColor blackColor] CGColor];
        [_accountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_accountButton addTarget:self action:@selector(inputString:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountButton;
}

- (UILabel *)accountDescLabel
{
    if(!_accountDescLabel) {
        _accountDescLabel = [[UILabel alloc] init];
        _accountDescLabel.textAlignment = NSTextAlignmentCenter;
        _accountDescLabel.font = [UIFont systemFontOfSize:14.0];
        _accountDescLabel.textColor = [UIColor colorWithRed:0xbe/255.0 green:0xbe/255.0 blue:0xbe/255.0 alpha:1.0];
        _accountDescLabel.backgroundColor = [UIColor clearColor];
    }
    return _accountDescLabel;
}

- (UIButton *)passwordButton
{
    if(!_passwordButton) {
        _passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _passwordButton.layer.borderWidth = 1;
//        _passwordButton.layer.borderColor = [[UIColor blackColor] CGColor];
        [_passwordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_passwordButton addTarget:self action:@selector(inputString:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordButton;
}

- (UILabel *)passwordDescLabel
{
    if(!_passwordDescLabel) {
        _passwordDescLabel = [[UILabel alloc] init];
        _passwordDescLabel.textAlignment = NSTextAlignmentCenter;
        _passwordDescLabel.font = [UIFont systemFontOfSize:14.0];
        _passwordDescLabel.textColor = [UIColor colorWithRed:0xbe/255.0 green:0xbe/255.0 blue:0xbe/255.0 alpha:1.0];
        _passwordDescLabel.backgroundColor = [UIColor clearColor];
    }
    return _passwordDescLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.accountButton];
        [self.accountButton addSubview:self.accountDescLabel];
        [self.contentView addSubview:self.passwordButton];
        [self.passwordButton addSubview:self.passwordDescLabel];
        
    }
    return self;
}

- (void)configWithAccount:(Account *)account
{
    self.nameLabel.text = account.describ;
    [self.accountButton setTitle:account.name forState:UIControlStateNormal];
    [self.passwordButton setTitle:account.password forState:UIControlStateNormal];
    self.accountDescLabel.text = @"点击输入账户";
    self.passwordDescLabel.text = @"点击输入密码";
}

- (void)layoutSubviews
{
    self.nameLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5, self.contentView.frame.size.height);
    self.accountButton.frame = CGRectMake(self.nameLabel.frame.origin.x+self.nameLabel.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width*2/5, self.contentView.frame.size.height);
    self.passwordButton.frame = CGRectMake(self.accountButton.frame.origin.x+self.accountButton.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width*2/5, self.contentView.frame.size.height);
    self.accountDescLabel.frame = CGRectMake(0, self.accountButton.frame.size.height/2, self.accountButton.frame.size.width, self.accountButton.frame.size.height/2);
    self.passwordDescLabel.frame = CGRectMake(0, self.passwordButton.frame.size.height/2, self.passwordButton.frame.size.width, self.passwordButton.frame.size.height/2);
}

- (void)inputString:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputString:)]) {
        [self.delegate inputString:sender.titleLabel.text];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
