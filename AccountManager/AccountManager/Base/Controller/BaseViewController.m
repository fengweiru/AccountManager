//
//  BaseViewController.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/13.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBar];
}

- (void)setNavBar
{
    self.view.backgroundColor = Color_Background;
}

- (void)setNavLeftBackItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickForBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)setNavLeftItemWithTitle:(NSString *)title
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setNavLeftItemWithImage:(UIImage *)image
{
    
}

- (void)setNavRightItemWithTitle:(NSString *)title
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setNavRightItemWithImage:(UIImage *)image
{
    
}

- (void)clickForBack:(UIButton *)sender
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:true];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)clickLeftItem:(UIButton *)sender
{
    
}

- (void)clickRightItem:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
