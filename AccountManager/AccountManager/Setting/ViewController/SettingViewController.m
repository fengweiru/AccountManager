//
//  SettingViewController.m
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingSwitchCell.h"

#import <LocalAuthentication/LocalAuthentication.h>
#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingSwitchCell,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) UITextField *inputPasswordTextfield;
@property (nonatomic, weak) UITextField *comfirmPasswordTextfield;

@property (nonatomic, assign) BOOL passwordOpen;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSUserDefaults *user;

@end

@implementation SettingViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-Height_For_AppHeader) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _tableView;
}

- (NSUserDefaults *)user
{
    if (!_user) {
        _user = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    [self setupUI];
    
    
    NSLog(@"%@",[self.view superview]);

}

- (void)setData
{
    if ([self.user objectForKey:@"passwordOpen"] && [[self.user objectForKey:@"passwordOpen"] boolValue]) {
        self.passwordOpen = true;
        self.password = [self.user objectForKey:@"password"];
    } else {
        self.passwordOpen = false;
    }
}

- (void)setupUI
{
    [self setNavBar];
    self.title = @"设置";
    
    [self.view addSubview:self.tableView];
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint  *constraint2 = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f];
    NSLayoutConstraint  *constraint3 = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    [self.view addConstraint:constraint1];
    [self.view addConstraint:constraint2];
    [self.view addConstraint:constraint3];
    [self.view addConstraint:constraint4];
}

#pragma mark -- SettingSwitchCell代理
- (void)openPasswordSwitch
{
    WS(weakSelf);
    if ([self.user objectForKey:@"password"]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"是否使用上一次的密码" message:[self.user objectForKey:@"password"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.user setObject:[NSNumber numberWithBool:true] forKey:@"passwordOpen"];
            self.passwordOpen = true;
            self.password = [self.user objectForKey:@"password"];
            [self.tableView reloadData];
        }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf settingPassword];
        }];
        [vc addAction:yesAction];
        [vc addAction:noAction];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        
        [self settingPassword];
        
    }
}

- (void)reloadTableView
{
    self.passwordOpen = [[self.user objectForKey:@"passwordOpen"] boolValue];
    self.password = [self.user objectForKey:@"password"];
    [self.tableView reloadData];
}

- (void)settingPassword
{
    WS(weakSelf);
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"密码设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入密码";
        self.inputPasswordTextfield = textField;
    }];
    [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请确认密码";
        self.comfirmPasswordTextfield = textField;
    }];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([weakSelf.inputPasswordTextfield.text isEqualToString:self.comfirmPasswordTextfield.text]) {
            [weakSelf.user setObject:[NSNumber numberWithBool:true] forKey:@"passwordOpen"];
            [weakSelf.user setObject:self.comfirmPasswordTextfield.text forKey:@"password"];
            weakSelf.passwordOpen = true;
            weakSelf.password = self.comfirmPasswordTextfield.text;
            [weakSelf.tableView reloadData];
        } else {
            
        }
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.tableView reloadData];
    }];
    [vc addAction:yesAction];
    [vc addAction:noAction];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark -- UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
    //        LAContext *laContext = [[LAContext alloc] init];
    //        if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
    //
    //        }
    //    }
    if (section == 0) {
        LAContext *context = [[LAContext alloc] init];
        if (self.passwordOpen && [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            return 2;
        } else {
            return 1;
        }
    } else if (section == 1 || section == 2) {
        return 1;
    } else {
        return 3;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        static NSString *switchCellId = @"switchCellId";
        SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellId];
        if (!cell) {
            cell = [[SettingSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:switchCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.fdelegate = self;
            cell.userDefaults = self.user;
        }
        
        SwitchType switchType;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                switchType = SwitchTypePassword;
            } else {
                switchType = SwitchTypeFingerprintOrFace;
            }
        } else {
            switchType = SwitchTypePasswordHidden;
        }
        
        [cell configWithSwitchType:switchType];
        return cell;
    } else{
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSString *textString = @"";
        if (indexPath.section == 2) {
            textString = @"设置帐号助手键盘";
        } else {
            switch (indexPath.row) {
                case 0:
                    textString = @"去App Store评价";
                    break;
                case 1:
                    textString = @"分享给你的朋友";
                    break;
                case 2:
                    textString = @"反馈遇到的问题或建议";
                    break;
                    
                default:
                    break;
            }
        }
        
        cell.textLabel.text = textString;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 2) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {   //App Store评价
            NSURL *itunesUrl = [NSURL URLWithString:@""];
            [[UIApplication sharedApplication] openURL:itunesUrl];
    
        } else if (indexPath.row == 1) {   //分享
            UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[@"帐号助手 - 帐号管理快捷输入 作者是 WEIRU FENG",@"https://itunes.apple.com/app/id1"] applicationActivities:nil];
            UIPopoverPresentationController *popover = vc.popoverPresentationController;
            if (popover) {
                popover.sourceView = self.view;
                popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
            }
            [self presentViewController:vc animated:true completion:nil];
        } else if (indexPath.row == 2) {   //发邮件
            MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc]init];
            mailSender.mailComposeDelegate = self;
            [mailSender setSubject:@"帐号助手 反馈"];
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *bodyString = [NSString stringWithFormat:@"\n\n\n手机类型:%@  系统:%@\n帐号助手版本:%@",[self iphoneType],[[UIDevice currentDevice] systemVersion],[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
            
            [mailSender setMessageBody:bodyString isHTML:NO];
            [mailSender setToRecipients:[NSArray arrayWithObjects:@"245596599@qq.com", nil]];
//            [mailSender addAttachmentData:datamimeType:mimeTypefileName:fileName];
            [self presentViewController:mailSender animated:YES completion:^{
            }];
            
        }
    }
    
}

#pragma mark -- mailComposeDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    switch(result) {
        case MFMailComposeResultCancelled:
        {
            [CommonTool showMessage:@"发送取消" duration:2.0f];
            
        }
        break;
        case MFMailComposeResultSaved:
        {
            [CommonTool showMessage:@"保存成功" duration:2.0f];
            
        }
        break;
        case MFMailComposeResultSent:
        {
            [CommonTool showMessage:@"发送成功" duration:2.0f];
            
              }
        break;
        case MFMailComposeResultFailed:
        {
            [CommonTool showMessage:@"发送失败" duration:2.0f];
            
        }
        break;
            
    }
}

- (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSLog(@"deviceString:%@",deviceString);
    return deviceString;
    
}

@end
