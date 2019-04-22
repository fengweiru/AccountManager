//
//  AccountDetailCell.m
//  AccountManager
//
//  Created by fengweiru on 2018/8/31.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "AccountDetailCell.h"
#import "Account.h"

@interface AccountDetailCell()<UITextFieldDelegate>

@property (nonatomic, weak) Account *account;
@property (nonatomic, assign) CellType cellType;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *functionButton;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation AccountDetailCell

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.textColor = [UIColor blackColor];
        _textField.placeholder = @"内容";
        _textField.delegate = self;
        _textField.layer.masksToBounds = true;
        _textField.layer.cornerRadius = 6;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        
        [_textField addTarget:self action:@selector(textFieldEditing) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)functionButton
{
    if (!_functionButton) {
        _functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_functionButton addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        [_functionButton setTitle:@"复制" forState:UIControlStateNormal];
        [_functionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _functionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _functionButton;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textColor = [UIColor blackColor];
    }
    return _textView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.functionButton];
    }
    return self;
}

- (void)configWithCellType:(CellType)cellType account:(Account *)account
{
    self.account = account;
    self.cellType = cellType;
    NSString *title;
    NSString *value;
    switch (cellType) {
        case cellTypeDescrib:
            title = @"名称";
            value = account.describ;
            break;
        case cellTypeUrl:
            title = @"跳转链接";
            value = account.url;
            break;
        case cellTypeName:
            title = @"账号";
            value = account.name;
            break;
        case cellTypePasswaord:
            title = @"密码";
            value = account.password;
            break;
        case cellTypeRemark:
            title = @"备注";
            value = account.remark;
            break;
            
        default:
            title = @"";
            value = @"";
            break;
    }
    
    self.titleLabel.text = title;
    self.textField.text = value;
    
}

- (void)functionClick:(UIButton *)sender
{
    NSLog(@"%f",self.titleLabel.f_width);
    NSLog(@"%f",self.textField.f_width);
    NSLog(@"%f",self.functionButton.f_width);

    NSLog(@"%f",self.titleLabel.f_width+self.textField.f_width+self.functionButton.f_width);
    NSLog(@"%f",self.contentView.f_width);
}

#pragma mark -- UITextField Target
- (void)textFieldEditing
{
    switch (self.cellType) {
        case cellTypeDescrib:
            self.account.describ = self.textField.text;
            break;
        case cellTypeUrl:
            self.account.url = self.textField.text;
            break;
        case cellTypeName:
            self.account.name = self.textField.text;
            break;
        case cellTypePasswaord:
            self.account.password = self.textField.text;
            break;
        case cellTypeRemark:
            self.account.remark = self.textField.text;
            break;
            
        default:
            break;
    }
}


- (void)layoutSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.25);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.65);
    }];
    [self.functionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.textField.mas_right);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.1);
    }];
    
}

+ (CGFloat)heightForCellType:(CellType)cellType
{
    return 70;
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
