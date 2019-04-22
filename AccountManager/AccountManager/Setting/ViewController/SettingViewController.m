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

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingSwitchCell>

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
    }
    return _tableView;
}

- (NSUserDefaults *)user
{
    if (!_user) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    [self setupUI];
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
}

#pragma mark -- SettingSwitchCell代理
- (void)openPasswordSwitch
{
    WS(weakSelf);
    if ([self.user objectForKey:@"password"]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"是否使用上一次的密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
    //        LAContext *laContext = [[LAContext alloc] init];
    //        if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
    //
    //        }
    //    }
    if (self.passwordOpen) {
        return 2;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SettingSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.fdelegate = self;
        cell.userDefaults = self.user;
    }
    
    SwitchType switchType;
    if (indexPath.row == 0) {
        switchType = SwitchTypePassword;
    } else {
        switchType = SwitchTypeFingerprintOrFace;
    }
    
    [cell configWithSwitchType:switchType];
    
    return cell;
}


@end
