//
//  PasswordInputViewController.m
//  AccountManager
//
//  Created by fengweiru on 2019/5/8.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "PasswordInputViewController.h"
#import "HomePageViewController.h"

#import <LocalAuthentication/LocalAuthentication.h>

@interface PasswordInputViewController ()

@property (nonatomic, strong) UITextField *inputPasswordTextField;

@property (nonatomic, strong) NSUserDefaults *user;

@end

@implementation PasswordInputViewController

- (UITextField *)inputPasswordTextField
{
    if (!_inputPasswordTextField) {
        _inputPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 40)];
        _inputPasswordTextField.font = [UIFont systemFontOfSize:16];
        _inputPasswordTextField.backgroundColor = [UIColor whiteColor];
        _inputPasswordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        _inputPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputPasswordTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        _inputPasswordTextField.rightViewMode = UITextFieldViewModeAlways;
        _inputPasswordTextField.secureTextEntry = true;
        _inputPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _inputPasswordTextField;
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
    
    [self setNavBar];
    [self setNavRightItemWithTitle:@"确认"];
    self.title = @"请输入密码";
    
    [self.view addSubview:self.inputPasswordTextField];
    
    [self judgeFingerprintOrFaceOpen];
}

- (void)judgeFingerprintOrFaceOpen
{
    WS(weakSelf);
    BOOL fingerprintOrFaceOpen = [[self.user objectForKey:@"fingerprintOrFaceOpen"] boolValue];
    if (fingerprintOrFaceOpen) {
        LAContext *context = [[LAContext alloc] init];
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证以确认您的身份" reply:^(BOOL success, NSError * _Nullable error) {
                NSLog(@"error : %@",error);
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        HomePageViewController *vc = [[HomePageViewController alloc] init];
                        [weakSelf.navigationController pushViewController:vc animated:true];
                    });
                } else {
                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf judgeFingerprintOrFaceOpen];
                    }];
                    [vc addAction:retryAction];
                    [self presentViewController:vc animated:true completion:nil];
                }
            }];
        } else {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"系统密码关闭" message:@"请输入助手密码进入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [vc addAction:retryAction];
            [self presentViewController:vc animated:true completion:nil];
        }
        
    }
}

- (void)clickRightItem:(UIButton *)sender
{
    BOOL isVerify = false;
    
    NSString *password = [self.user objectForKey:@"password"];
    isVerify = [self.inputPasswordTextField.text isEqualToString:password];
    
    if (isVerify) {
        HomePageViewController *vc = [[HomePageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}

@end
