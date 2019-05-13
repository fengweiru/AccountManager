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
#import "KeyboardButton.h"

@interface KeyboardViewController ()<UITableViewDelegate,UITableViewDataSource,AccountCellDelegate>
@property (nonatomic, strong) UIButton *nextKeyboardButton;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) KeyboardButton *passwordHiddenButton;
@property (nonatomic, strong) KeyboardButton *clearButton;
@property (nonatomic, strong) KeyboardButton *lineButton;
@property (nonatomic, strong) KeyboardButton *backButton;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <Account *>*accountArr;

@property (nonatomic, strong) NSUserDefaults *users;
@property (nonatomic, assign) BOOL isPasswordHidden;

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation KeyboardViewController

- (NSArray *)accountArr
{
    if (!_accountArr) {
        _accountArr = [Account getDataArr];
    }
    return _accountArr;
}

- (UIView *)bottomView
{
    if(!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderWidth = 0.5;
        _tableView.layer.borderColor = [[UIColor colorWithRed:0xbe/255.0 green:0xbe/255.0 blue:0xbe/255.0 alpha:1.0] CGColor];
        _tableView.bounces = false;
        _tableView.backgroundColor = [UIColor whiteColor];
//        [UIColor colorWithRed:0xd2/255.0 green:0xd2/255.0 blue:0xd2/255.0 alpha:1.0];
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)toolView
{
    if(!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.backgroundColor = [UIColor clearColor];
    }
    return _toolView;
}

- (KeyboardButton *)passwordHiddenButton
{
    if (!_passwordHiddenButton) {
        _passwordHiddenButton = [KeyboardButton createKeyboardButton];
        [_passwordHiddenButton setTitle:@"密码\n隐藏" forState:UIControlStateNormal];
        [_passwordHiddenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_passwordHiddenButton addTarget:self action:@selector(changePasswordHidden) forControlEvents:UIControlEventTouchUpInside];
        _passwordHiddenButton.titleLabel.lineBreakMode = 0;
    }
    return _passwordHiddenButton;
}

- (KeyboardButton *)clearButton
{
    if(!_clearButton) {
        _clearButton = [KeyboardButton createKeyboardButton];
        [_clearButton setTitle:@"删除" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearString) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (KeyboardButton *)lineButton
{
    if (!_lineButton) {
        _lineButton = [KeyboardButton createKeyboardButton];
        [_lineButton setTitle:@"换行" forState:UIControlStateNormal];
        [_lineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_lineButton addTarget:self action:@selector(lineString) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lineButton;
}

- (KeyboardButton *)backButton
{
    if (!_backButton) {
        _backButton = [KeyboardButton createKeyboardButton];
        [_backButton setTitle:@"收起" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (NSLayoutConstraint *)heightConstraint
{
    if (!_heightConstraint) {
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self.inputView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
        NSLog(@"inputView : %@ \n self.view : %@",self.inputView,self.view);
        _heightConstraint.priority = 999;
    }
    return _heightConstraint;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
//
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    CGFloat screenH = screenSize.height;
//    CGFloat screenW = screenSize.width;
//    BOOL isLandscape = screenH < screenW ? true : false;
//    CGFloat keyboardHeigt = isLandscape ? 200 : 250;
//    NSLog(@"keyboardHeigt : %f", keyboardHeigt);
//    if (self.heightConstraint.constant != keyboardHeigt) {
//        self.heightConstraint.constant = keyboardHeigt;
//        NSLog(@"self.heightConstraint.constant : %f",self.heightConstraint.constant);
//    }
    
    // Add custom view sizing constraints here
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
//    [self.view addConstraint:self.heightConstraint];
//    [self.view setNeedsUpdateConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.inputView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:800.0];
//    [self.view addConstraint:constraint];
    
    self.users = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
    self.isPasswordHidden = [[self.users objectForKey:@"passwordHidden"] boolValue];
    [self reloadPasswordButton];
    
    // Perform custom UI setup here
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.tableView];
    
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextKeyboardButton setBackgroundImage:[UIImage imageNamed:@"input_trigger"] forState:UIControlStateNormal];
    [self.nextKeyboardButton setBackgroundImage:[UIImage imageNamed:@"input_trigger_highlight"] forState:UIControlStateHighlighted];
    self.nextKeyboardButton.layer.masksToBounds = true;
    self.nextKeyboardButton.layer.cornerRadius = 8;
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (@available(iOS 10.0, *)) {
        [self.nextKeyboardButton addTarget:self action:@selector(handleInputModeListFromView:withEvent:) forControlEvents:UIControlEventAllTouchEvents];
    } else {
        [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventAllTouchEvents];
    }
    
    [self.bottomView addSubview:self.toolView];
    [self.toolView addSubview:self.passwordHiddenButton];
    [self.toolView addSubview:self.nextKeyboardButton];
    [self.toolView addSubview:self.clearButton];
    [self.toolView addSubview:self.lineButton];
    [self.toolView addSubview:self.backButton];
    
//    [self.nextKeyboardButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
//    [self.nextKeyboardButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

    [self addConstraint];
}

- (void)addConstraint
{
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint  *constraint2 = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f];
    NSLayoutConstraint  *constraint3 = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *constraint5 = [NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:230];
    
    
    [self.view addConstraint:constraint1];
    [self.view addConstraint:constraint2];
    [self.view addConstraint:constraint3];
    [self.view addConstraint:constraint4];
    [self.view addConstraint:constraint5];
    
}

- (void)viewWillLayoutSubviews
{
    if (@available(iOS 11.0, *)) {
        self.nextKeyboardButton.hidden = !self.needsInputModeSwitchKey;
    } else {
        // Fallback on earlier versions
    }
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-54);
    
    self.toolView.frame = CGRectMake(0, self.tableView.frame.size.height, self.view.bounds.size.width, 54);
    
    CGFloat distance = 0;
    CGFloat numSpace;
    if (self.nextKeyboardButton.hidden) {
        numSpace = (self.view.frame.size.width-44*4)/5;
        distance += numSpace;
        self.passwordHiddenButton.frame = CGRectMake(distance, 5, 44, 44);
        distance += self.passwordHiddenButton.bounds.size.width;
    } else {
        numSpace = (self.view.frame.size.width-44*5)/6;
        distance += numSpace;
        self.passwordHiddenButton.frame = CGRectMake(distance, 5, 44, 44);
        distance += self.passwordHiddenButton.bounds.size.width;

        distance += numSpace;
        self.nextKeyboardButton.frame = CGRectMake(distance, 5, 44, 44);
        distance += self.nextKeyboardButton.bounds.size.width;
    }

    distance += numSpace;
    self.clearButton.frame = CGRectMake(distance, 5, 44, 44);
    distance += self.clearButton.frame.size.width;

    distance += numSpace;
    self.lineButton.frame = CGRectMake(distance, 5, 44, 44);
    distance += self.lineButton.frame.size.width;

    distance += numSpace;
    self.backButton.frame = CGRectMake(distance, 5, 44, 44);
    distance += self.backButton.frame.size.width;

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Account *account = self.accountArr[indexPath.row];
    [cell configWithAccount:account isPasswordHidden:self.isPasswordHidden];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    headerView.backgroundColor = tableView.backgroundColor;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"名称";
    [headerView addSubview:nameLabel];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.text = @"帐号";
    [headerView addSubview:accountLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.text = @"密码";
    [headerView addSubview:passwordLabel];
    
    nameLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5, headerView.frame.size.height);
    accountLabel.frame = CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width*2/5, headerView.frame.size.height);
    passwordLabel.frame = CGRectMake(accountLabel.frame.origin.x+accountLabel.frame.size.width, 0, [UIScreen mainScreen].bounds.size.width*2/5, headerView.frame.size.height);
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0xbe/255.0 green:0xbe/255.0 blue:0xbe/255.0 alpha:0.9];
    [headerView addSubview:line];
    
    return headerView;
}

//切换隐藏密码
- (void)changePasswordHidden
{
    self.isPasswordHidden = !self.isPasswordHidden;
//    [self.users setObject:[NSNumber numberWithBool:self.isPasswordHidden] forKey:@"passwordHidden"];  //无法设置问题
    [self reloadPasswordButton];
    [self.tableView reloadData];
}
- (void)reloadPasswordButton
{
    if (self.isPasswordHidden) {
        [self.passwordHiddenButton setTitle:@"密码显示" forState:UIControlStateNormal];
    } else {
        [self.passwordHiddenButton setTitle:@"密码隐藏" forState:UIControlStateNormal];
    }
}

//换行
- (void)lineString
{
    [self.textDocumentProxy insertText:@"\n"];
}

//清除
- (void)clearString
{
    [self.textDocumentProxy deleteBackward];
}

//输入
- (void)inputString:(NSString *)string
{
    [self.textDocumentProxy insertText:string];
}

@end
