//
//  WTNBasketballViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNBasketballViewController.h"
#import "WTNFootballService.h"
#import "WTNNBAResultModel.h"
#import "WTNNBAVideoModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WTNFootballTableViewCell.h"
#import "WTNBasketballDetailViewController.h"
#import "WTNBasketDetailViewController.h"
#import "ADScrollView.h"
#import "WTNADSportService.h"
static NSString *identifier1 = @"cell1";
@interface WTNBasketballViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_basketballArr;
    ADScrollView *_adScrollView;
    UIGestureRecognizer *_imageTap;
}
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation WTNBasketballViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    [self loadADdata];
    
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
    [tableView registerNib:[UINib nibWithNibName:@"WTNFootballTableViewCell" bundle:nil] forCellReuseIdentifier:identifier1];
    
    // 设置背景颜色
    tableView.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tableView.delegate = self;
    // 设置数据源代理
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self refresh];
    [self createADScrollView];
   
    
}
//创建广告栏
-(void)createADScrollView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 180)];
    // self.tableView.tableHeaderView = headerView;
    self.tableView.tableHeaderView = headerView;
    _adScrollView = [[ADScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 180-10)];
    [_adScrollView reloadData];
    [headerView addSubview:_adScrollView]; //放在后面滚动点不出现
    //增加图片点击事件
    _imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapClicked:)];
    [headerView addGestureRecognizer:_imageTap];
    
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
-(IBAction)imageTapClicked:(UIGestureRecognizer *)sender{
    // 代码创建的tableview push到storybord的话那个方法不行 想要push到storybord拖的控制器上必须是storybord 拖的控制器,会出现 Application tried to push a nil view controller on target <UINavigationController: 0x7fb8c5031e00>.
    UIStoryboard * sportSB = [UIStoryboard storyboardWithName:@"Sports" bundle:nil];
    WTNBasketDetailViewController *bdvc = [sportSB instantiateViewControllerWithIdentifier:@"WTNBasketDetailViewController"];
    bdvc.imageUrl = _adScrollView.imageUrl;
    //    view 为点击事件的对象
    
    [self.navigationController pushViewController:bdvc animated:YES];
}

#pragma mark -
#pragma mark 加载数据
-(void)loadADdata{
    [[WTNADSportService new]getADImageList:^(id data) {
        NSRange range ={0,5};
        _adScrollView.imageArr = [data subarrayWithRange:range];
        [_adScrollView reloadData];
    }];
    // 图片上的文字
    [[WTNADSportService new]getADLabelList:^(id data) {
        NSRange range ={0,5};
        _adScrollView.labelArr = [data subarrayWithRange:range];
        [_adScrollView reloadData];
    }];
    [[WTNADSportService new]getADdetail:^(id data) {
        NSRange range ={0,5};
        _adScrollView.imageUrlArr = [data subarrayWithRange:range];
        [_adScrollView reloadData];
    }];
}

-(void)loadData{
    __weak typeof(*&self)blockSelf = self;
    [[WTNFootballService new]getNBAList:^(id data) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        _basketballArr = data;
        [blockSelf.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _basketballArr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNFootballTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
    WTNNBAVideoModel *model = _basketballArr[indexPath.row];
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
    //在sprots.storyBoard 设置 view controller继承 FootballDetailViewController  storyBoard ID 为 FootballDetailViewController
    UIStoryboard * sportSB = [UIStoryboard storyboardWithName:@"Sports" bundle:nil];
   WTNBasketballDetailViewController *Bbvc = [ sportSB instantiateViewControllerWithIdentifier:@"WTNBasketballDetailViewController"];
    Bbvc.NBAVideoModel = _basketballArr[indexPath.row];
    //点击跳转到下一个页面之前 隐藏底部栏
    Bbvc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:Bbvc animated:YES];
}
@end
