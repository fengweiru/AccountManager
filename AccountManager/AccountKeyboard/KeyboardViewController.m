//
//  KeyboardViewController.m
//  AccountKeyboard
//
//  Created by fengweiru on 2019/4/23.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Account.h"
#import "AccountCell.h"

@interface KeyboardViewController ()<UITableViewDelegate,UITableViewDataSource,AccountCellDelegate>
@property (nonatomic, strong) UIButton *nextKeyboardButton;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <Account *>*accountArr;

@end

@implementation KeyboardViewController

- (NSArray *)accountArr
{
    if (!_accountArr) {
        _accountArr = [Account getDataArr];
    }
    return _accountArr;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderWidth = 0.5;
        _tableView.layer.borderColor = [[UIColor colorWithRed:0xbe/255.0 green:0xbe/255.0 blue:0xbe/255.0 alpha:1.0] CGColor];
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.inputView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:800.0];
//    [self.view addConstraint:constraint];
    
    // Perform custom UI setup here
    [self.view addSubview:self.tableView];
    
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextKeyboardButton setBackgroundImage:[UIImage imageNamed:@"input_trigger"] forState:UIControlStateNormal];
    [self.nextKeyboardButton setBackgroundImage:[UIImage imageNamed:@"input_trigger_highlight"] forState:UIControlStateHighlighted];
    self.nextKeyboardButton.layer.masksToBounds = true;
    self.nextKeyboardButton.layer.cornerRadius = 8;
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:self.nextKeyboardButton];
    
//    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
//    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)viewWillLayoutSubviews
{
    if (@available(iOS 11.0, *)) {
        self.nextKeyboardButton.hidden = !self.needsInputModeSwitchKey;
    } else {
        // Fallback on earlier versions
    }
    self.tableView.frame = self.view.bounds;
    self.nextKeyboardButton.frame = CGRectMake(54, self.view.bounds.size.height-54, 44, 44);
    [super viewWillLayoutSubviews];
    NSLog(@"=========:%f",self.view.bounds.size.height);
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark -- UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.delegate = self;
    }
    
    Account *account = self.accountArr[indexPath.row];
    [cell configWithAccount:account];
    
    return cell;
}

- (void)inputString:(NSString *)string
{
    [self.textDocumentProxy insertText:string];
}

@end
