//
//  GKQQListViewController.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKQQListViewController.h"
#import "GKQQPlayerViewController.h"
#import "GKQQListViewCell.h"

@interface GKQQListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *listTable;

@property (nonatomic, strong) NSArray *musicList;

@end

@implementation GKQQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navBackgroundColor = GKQQMainColor;
    
    self.gk_navigationItem.title = @"我的音乐";
    
    [self.view addSubview:self.listTable];
    [self.listTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    [self loadData];
}

- (void)loadData {
    self.musicList = [GKQQTools musics];
    
    [self.listTable reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GKQQListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GKQQListViewCellID forIndexPath:indexPath];
    
    cell.row = indexPath.row;
    
    cell.model = self.musicList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKQQPlayerViewController *playerVC = [GKQQPlayerViewController sharedInstance];
    
    [playerVC playMusicWithIndex:indexPath.row musicList:self.musicList];
    
    [self.navigationController pushViewController:playerVC animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)listTable {
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTable.dataSource = self;
        _listTable.delegate   = self;
        _listTable.rowHeight  = 50;
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_listTable registerNib:[UINib nibWithNibName:NSStringFromClass([GKQQListViewCell class]) bundle:nil] forCellReuseIdentifier:GKQQListViewCellID];
    }
    return _listTable;
}

@end
