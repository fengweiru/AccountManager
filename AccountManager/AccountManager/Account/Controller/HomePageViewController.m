//
//  HomePageViewController.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/13.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "HomePageViewController.h"
#import "Account.h"

#import "AccountOperationViewController.h"
#import "SettingViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<Account *> *dataArr;

@end

@implementation HomePageViewController

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.f_width, self.view.f_height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        _tableView.estimatedRowHeight = 50;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupData
{
//    NSMutableArray <Account *>* dataArr = [[NSMutableArray alloc] initWithCapacity:5];
//    for (NSInteger i = 0; i < 5; i++) {
//        Account *account = [[Account alloc] init];
//        account.describ = [NSString stringWithFormat:@"说明%ld",i];
//        account.name = [NSString stringWithFormat:@"名字%ld",i];
//        account.password = [NSString stringWithFormat:@"密码%ld",i];
//        account.remark = [NSString stringWithFormat:@"备注%ld",i];
//        account.url = [NSString stringWithFormat:@"链接%ld",i];
//        account.addTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
//        account.modifyTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
//        account.lookTime = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] unsignedIntegerValue];
//        [dataArr addObject:account];
//        [[AccountTable shareAccountTable] insertDataContainBinary:account];
//    }
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[Account getDataArr]];
    [self.dataArr sortUsingComparator:^NSComparisonResult(Account*  _Nonnull obj1, Account*  _Nonnull obj2) {
        if (obj1.lookTime > obj2.lookTime) {
            return NSOrderedAscending;
        } else if (obj1.lookTime < obj2.lookTime) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    [self.tableView reloadData];
}

- (void)setupUI
{
    [self setNavBar];
    [self setNavLeftItemWithTitle:@"设置"];
    [self setNavRightItemWithTitle:@"添加"];
    self.title = @"帐号列表";
    
    [self.view addSubview:self.tableView];
}

- (void)clickLeftItem:(UIButton *)sender
{
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)clickRightItem:(UIButton *)sender
{
    AccountOperationViewController *vc = [[AccountOperationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.detailTextLabel.font = FFontRegular(12);

    }
    
    Account *account = self.dataArr[indexPath.row];
    cell.textLabel.text = account.describ;
    cell.detailTextLabel.text = account.password;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Account *account = self.dataArr[indexPath.row];
    AccountOperationViewController *vc = [[AccountOperationViewController alloc] initWithAccount:account];
    [self.navigationController pushViewController:vc animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
