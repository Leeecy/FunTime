//
//  WTNSportVideoViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNSportVideoViewController.h"
#import "WTNFootballService.h"
#import "WTNSportVideoResultModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WTNFootballTableViewCell.h"
#import "WTNSportDetailViewController.h"

static NSString *identifier1 = @"cell1";
@interface WTNSportVideoViewController ()<UITableViewDataSource,UITableViewDelegate>{
      NSMutableArray *_newsArr;
    NSMutableArray *_newsResultArr;
    WTNSportVideoResultModel *_videoResultModel;
    UITableView *tableView1;
    

    
}
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation WTNSportVideoViewController

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
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -108) style:UITableViewStylePlain];
    [tableView1 registerNib:[UINib nibWithNibName:@"WTNFootballTableViewCell" bundle:nil] forCellReuseIdentifier:identifier1];
        // 设置背景颜色
    tableView1.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tableView1.delegate = self;
    // 设置数据源代理
    tableView1.dataSource = self;
    [self.view addSubview:tableView1];
    self.tableView = tableView1;
}

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
    [[WTNFootballService new]getSportVideo:^(id data) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        _newsArr = data;
        [blockSelf.tableView reloadData];
        
    }];
    [[WTNFootballService new]getSportBackground:^(id data) {
        _newsResultArr = data;
        //创建头视图
        // 创建整个tableView的头视图
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        //三方库导入图片
        [image sd_setImageWithURL:[NSURL URLWithString:[_newsResultArr firstObject]]];
        [headerView addSubview:image];
        tableView1.tableHeaderView = headerView;

    [blockSelf.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsArr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNFootballTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
   WTNRootVideoModel *model = _newsArr[indexPath.row];
   NSString *path = [[NSBundle mainBundle] pathForResource:@"sports" ofType:@"png"];
  [cell.footballImageIcon sd_setImageWithURL:[NSURL URLWithString:[model.images firstObject]]  placeholderImage:[UIImage imageWithContentsOfFile:path]];
   cell.footballTitleName.text = model.title;
   
    //创建一个时间戳对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    formatter.dateFormat = @"yyyy/MM/dd";
     NSDate *date = [NSDate date];
    //把时间对象转换成字符串对象
    NSString *dateString = [formatter  stringFromDate:date];
    cell.footballUpdateTime.text = dateString;
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //WTNFootballDetailViewController 为 WTNSportViewController的子视图 不能直接用self.storyboard  要先创建UIStoryboard * sportSB 否则跳转为空
    UIStoryboard * sportSB = [UIStoryboard storyboardWithName:@"Sports" bundle:nil];
    WTNSportDetailViewController *SDvc = [sportSB instantiateViewControllerWithIdentifier:@"WTNSportDetailViewController"];
    SDvc.sportModel= _newsArr[indexPath.row];
    //点击跳转到下一个页面之前 隐藏底部栏
    SDvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:SDvc animated:YES];
    
}


@end
