//
//  SettingSwitchCell.m
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "SettingSwitchCell.h"

@interface SettingSwitchCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UISwitch *fswitch;

@property (nonatomic, assign) SwitchType switchType;

@end

@implementation SettingSwitchCell

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = FFontRegular(18);
    }
    return _title;
}

- (UISwitch *)fswitch
{
    if (!_fswitch) {
        _fswitch = [[UISwitch alloc] init];
        [_fswitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _fswitch;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.fswitch];
    }
    return self;
}

- (void)configWithSwitchType:(SwitchType)switchType
{
    self.switchType = switchType;
    
    BOOL switchOpen = false;
    switch (switchType) {
        case SwitchTypePassword:
            self.title.text = @"助手密码";
            switchOpen = [[self.userDefaults objectForKey:@"passwordOpen"] boolValue];
            break;
        case SwitchTypeFingerprintOrFace:
            self.title.text = @"指纹/面容解锁";
            switchOpen = [[self.userDefaults objectForKey:@"fingerprintOrFaceOpen"] boolValue];
            break;
        case SwitchTypePasswordHidden:
            self.title.text = @"密码隐藏";
            switchOpen = [[self.userDefaults objectForKey:@"passwordHidden"] boolValue];
            break;
            
        default:
            break;
    }
    
    [self.fswitch setSelected:switchOpen];
    [self.fswitch setOn:switchOpen];
}

- (void)switchChanged:(UISwitch *)sender
{
    NSLog(@"before:%d",sender.selected);
    sender.selected = !sender.selected;
    NSLog(@"after:%d",sender.selected);
    
    if (self.switchType == SwitchTypePassword) {
        if (sender.selected) {
            if ([self.fdelegate respondsToSelector:@selector(openPasswordSwitch)]) {
                [self.fdelegate openPasswordSwitch];
            }
        } else {
            [self.userDefaults setObject:[NSNumber numberWithBool:false] forKey:@"passwordOpen"];
            if ([self.fdelegate respondsToSelector:@selector(reloadTableView)]) {
                [self.fdelegate reloadTableView];
            }
        }
    } else if(self.switchType == SwitchTypeFingerprintOrFace) {
        [self.userDefaults setObject:[NSNumber numberWithBool:sender.selected] forKey:@"fingerprintOrFaceOpen"];
    } else if (self.switchType == SwitchTypePasswordHidden) {
        [self.userDefaults setObject:[NSNumber numberWithBool:sender.selected] forKey:@"passwordHidden"];
    }

}

- (void)layoutSubviews
{
    self.title.frame = CGRectMake(20, 0, 200, self.f_height);
    self.fswitch.f_y = (self.f_height-self.fswitch.f_height)/2;
    self.fswitch.f_x = kScreenW-20-self.fswitch.f_width;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
