//
//  AccountOperationViewController.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/23.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "AccountOperationViewController.h"
#import "Account.h"
#import "AccountDetailCell.h"

static NSString *accountDetailCellId = @"accountDetailCellId";

@interface AccountOperationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isModify;
}

@property (nonatomic, assign) OperationType operationType;

@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) Account *preModifyAccount;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation AccountOperationViewController

- (Account *)account
{
    if (!_account) {
        _account = [[Account alloc] init];
    }
    return _account;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = Color_Background;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[AccountDetailCell class] forCellReuseIdentifier:accountDetailCellId];
    }
    return _tableView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FFontRegular(13);
        _timeLabel.textColor = FColor(0xb7, 0xb7, 0xb7);
        _timeLabel.numberOfLines = 3;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (instancetype)initWithAccount:(Account *)account
{
    if (self = [super init]) {
        _isModify = true;
        self.account = account;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self preDataOperation];
    [self setupUI];
    [self reloadView];
    [self uploadLookTime];
}

- (void)preDataOperation
{
    if (self.account.accountId != -1) {
        self.operationType = operationTypeLook;
        self.preModifyAccount = [self.account copy];
    } else {
        self.operationType = operationTypeAdd;
        self.account = [[Account alloc] init];
    }
}

- (void)setupUI
{
    [self setNavBar];
//    [self setNavLeftBackItem];
    
    self.title = self.account.describ;
    
    [self.view addSubview:self.tableView];
}

- (void)reloadView
{
    if (self.operationType == operationTypeAdd) {
        [self setNavRightItemWithTitle:@"添加"];
    }
    else if (self.operationType == operationTypeLook) {
        [self setNavRightItemWithTitle:@"保存"];
    }
    
    [self.tableView reloadData];
}

- (void)uploadLookTime
{
    self.account.lookTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
    NSLog(@"uploadLookTime:%d",[self.account updateLookTime]);
}

- (void)clickRightItem:(UIButton *)sender
{
    if (self.operationType == operationTypeLook) {
        
        if ([self.preModifyAccount updateSelf]) {
            self.operationType = operationTypeLook;
            self.account = self.preModifyAccount;
            [self reloadView];
            [CommonTool showMessage:@"保存成功!" duration:2];
        }
        
    }else if (self.operationType == operationTypeAdd) {
        if ([self.account addSelf]) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }
    
    
}

#pragma mark -- UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellType cellType;
    switch (indexPath.row) {
        case 0:
            cellType = cellTypeDescrib;
            break;
        case 1:
            cellType = cellTypeUrl;
            break;
        case 2:
            cellType = cellTypeName;
            break;
        case 3:
            cellType = cellTypePasswaord;
            break;
        case 4:
            cellType = cellTypeRemark;
            break;
            
        default:
            cellType = cellTypeDescrib;
            break;
    }
    
    return [AccountDetailCell heightForCellType:cellType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:accountDetailCellId];
    
    CellType cellType;
    switch (indexPath.row) {
        case 0:
            cellType = cellTypeDescrib;
            break;
        case 1:
            cellType = cellTypeUrl;
            break;
        case 2:
            cellType = cellTypeName;
            break;
        case 3:
            cellType = cellTypePasswaord;
            break;
        case 4:
            cellType = cellTypeRemark;
            break;
            
        default:
            cellType = cellTypeDescrib;
            break;
    }
    
    if (self.operationType == operationTypeLook) {
        [cell configWithCellType:cellType account:self.preModifyAccount operationType:self.operationType];
    } else {
        [cell configWithCellType:cellType account:self.account operationType:self.operationType];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    self.timeLabel.frame = CGRectMake((kScreenW-300)/2, 0, 300, 80);
    [footerView addSubview:self.timeLabel];
    
    if (self.operationType == operationTypeLook) {
        self.timeLabel.text = [NSString stringWithFormat:@"查看时间:%@\n修改时间:%@\n创建时间:%@",[CommonTool getChecktimeWithTimestamp:self.account.lookTime],[CommonTool getChecktimeWithTimestamp:self.account.modifyTime],[CommonTool getChecktimeWithTimestamp:self.account.addTime]];
    } else {
        self.timeLabel.text = @"";
    }
    
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
