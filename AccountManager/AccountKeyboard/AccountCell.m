//
//  AccountCell.m
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/25.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "AccountCell.h"
#import "Account.h"
#import "KeyboardButton.h"

@interface AccountCell ()

@property (nonatomic, weak) Account *account;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) KeyboardButton *accountButton;
@property (nonatomic, strong) UILabel *accountDescLabel;
@property (nonatomic, strong) KeyboardButton *passwordButton;
@property (nonatomic, strong) UILabel *passwordDescLabel;


@end

@implementation AccountCell

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 2;
        _nameLabel.minimumScaleFactor = 0.4;
        _nameLabel.adjustsFontSizeToFitWidth = true;
//        _nameLabel.layer.borderWidth = 1;
//        _nameLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return _nameLabel;
}

- (KeyboardButton *)accountButton
{
    if (!_accountButton) {
        _accountButton = [KeyboardButton createKeyboardButton];
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

- (KeyboardButton *)passwordButton
{
    if(!_passwordButton) {
        _passwordButton = [KeyboardButton createKeyboardButton];
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
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.accountButton];
//        [self.accountButton addSubview:self.accountDescLabel];
        [self.contentView addSubview:self.passwordButton];
//        [self.passwordButton addSubview:self.passwordDescLabel];
        
    }
    return self;
}

- (void)configWithAccount:(Account *)account isPasswordHidden:(BOOL)isPasswordHidden
{
    self.account = account;
    
    self.nameLabel.text = account.describ;
    [self.accountButton setTitle:account.name forState:UIControlStateNormal];
    
    NSString *passwordString;
    if (isPasswordHidden) {
        NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:@"\\w|\\W{1}" options:NSRegularExpressionCaseInsensitive error:nil];
        passwordString = [regExp stringByReplacingMatchesInString:account.password options:NSMatchingReportProgress range:NSMakeRange(0, account.password.length) withTemplate:@"*"];
    } else {
        passwordString = account.password;
    }
    
    [self.passwordButton setTitle:passwordString forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    self.nameLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5, self.contentView.frame.size.height);
    self.accountButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/5+20, 5, [UIScreen mainScreen].bounds.size.width*2/5-40, self.contentView.frame.size.height-10);
    self.passwordButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*3/5+20, 5, [UIScreen mainScreen].bounds.size.width*2/5-40, self.contentView.frame.size.height-10);
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
