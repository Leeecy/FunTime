//
//  WTNFootballViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNFootballViewController.h"
#import "WTNFootballService.h"
#import "WTNTopListModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WTNFootballTableViewCell.h"
#import "WTNFootballDetailViewController.h"

static NSString *identifier = @"cell";

@interface WTNFootballViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_footballArr;
  
}
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation WTNFootballViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
    [self loadData];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    self.tableView = nil;
    [super viewDidAppear:YES];
}

-(void)configUI{
    
     UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-108) style:UITableViewStylePlain];
  
    [tableView registerNib:[UINib nibWithNibName:@"WTNFootballTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];

    // 设置背景颜色
    tableView.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tableView.delegate = self;
    // 设置数据源代理
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

}
// 刷新
-(void)refresh{
    // 三方库刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.header isRefreshing]) {
                [self.tableView.header endRefreshing];
            }
        });
    }];
}

-(void)loadData{
    __weak typeof(*&self)blockSelf = self;
    [[WTNFootballService new]getFootballList:^(id data) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        _footballArr = data;
        [blockSelf.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _footballArr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNFootballTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    WTNTopListModel *model = _footballArr[indexPath.row];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sports" ofType:@"png"];
    [cell.footballImageIcon sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageWithContentsOfFile:path]];
    cell.footballTitleName.text = model.shortTitle;
    cell.footballUpdateTime.text = model.createtime;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//选中一行跳转

// 代码创建的tableview push到storybord的话那个方法不行 想要push到storybord拖的控制器上必须是storybord 拖的控制器

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //WTNFootballDetailViewController 为 WTNSportViewController的子视图 不能直接用self.storyboard  要先创建UIStoryboard * sportSB 否则跳转为空
    UIStoryboard * sportSB = [UIStoryboard storyboardWithName:@"Sports" bundle:nil];
    WTNFootballDetailViewController *FDvc = [sportSB instantiateViewControllerWithIdentifier:@"WTNFootballDetailViewController"];
    FDvc.topListModel = _footballArr[indexPath.row];
    //点击跳转到下一个页面之前 隐藏底部栏
    FDvc.hidesBottomBarWhenPushed = YES;
   [self.navigationController pushViewController:FDvc animated:YES];
  
   

}
@end
