//
//  WTNHotArticleTableViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import "WTNHotArticleTableViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WTNArticalTableViewCell.h"
#import "WTNArticalService.h"
#import "WTNNewsResultModel.h"
#import "ADScrollView.h"
#import "WTNADService.h"
#import "WTNArticalDetailViewController.h"
#import "WTNDrawerViewController.h"
#import "WTNDetailViewController.h"
//static NSInteger PIC_IMAGE_VIEW_TAG_PREFIX = 1222;
static NSString *identifier1 = @"cell1";
@interface WTNHotArticleTableViewController (){
    NSMutableArray *_newsArr;
    ADScrollView *_adScrollView;
    WTNStoryModel * _storyModel;
    WTNNewsResultModel *_resultModel;
    NSString * _date;
    UIGestureRecognizer *_imageTap;
    BOOL _isLoading;
    NSString *_strTime;
    NSString *_dateTime;
//    加载更多界面需要使用
    int i;
    WTNDrawerViewController * dvc;
//判断当前界面是否打开
    BOOL _isAdd;
//    添加点击手势返回  手势与界面点击有冲突 需要判断
    UITapGestureRecognizer *tapGuesture;
//    加载
   
}

@end

@implementation WTNHotArticleTableViewController
-(NSMutableArray*)newsArr{
    if (!_newsArr) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}
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
#pragma mark -
#pragma mark 初始化UI

-(void)configUI{
    [self createADScrollView];
    [self refresh];
    self.navigationItem.title = @"热门文章";
//使用图片的方式创建左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_friendattention"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonItemClicked:)];
     self.navigationItem.leftBarButtonItem = leftButton;
//    分享测试按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(rightBarButtonItemClicked:)];
   
     [self.tableView registerNib:[UINib nibWithNibName:@"WTNArticalTableViewCell" bundle:nil] forCellReuseIdentifier:identifier1];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
// 抽屉控制器
    dvc = (WTNDrawerViewController*)self.navigationController.tabBarController.parentViewController;
//    滑动返回手势
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
//    [self.view addGestureRecognizer:panGesture];
//    点击手势
   tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuesture:)];
    
    //方式1.直接在View上show
   
}
//分享
//-(IBAction)rightBarButtonItemClicked:(id)sender{
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:nil
//                                      shareText:@"你要分享的文字"
//                                     shareImage:nil
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
//                                       delegate:self];
//    
//}

//创建广告栏
-(void)createADScrollView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 180)];
    self.tableView.tableHeaderView = headerView;
    _adScrollView = [[ADScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-0, 180)];
    [_adScrollView reloadData];
    [headerView addSubview:_adScrollView]; //放在后面滚动点不出现
    //增加图片点击事件
    _imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapClicked:)];
    [headerView addGestureRecognizer:_imageTap];
    
}
//三方库刷新
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
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadMore];
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView.footer endRefreshing];
            }
        });
    }];
}
#pragma mark--点击事件
//抽屉
-(IBAction)leftBarButtonItemClicked:(id)sender{
    [dvc clickDrawerButton];
    if (dvc.isDrawOpen == YES) {
        NSLog(@"打开了 ");
        
        if (_isAdd == NO) {
            [self.view addGestureRecognizer:tapGuesture];
            _isAdd = YES;
        }
    }else{
        NSLog(@"关闭了 ");
        [self.view removeGestureRecognizer:tapGuesture];
        _isAdd =NO;
    }
    
}
//- (IBAction)panGesture:(id)sender{
//   [dvc clickDrawerButton];
//    if (dvc.isDrawOpen == YES) {
//        NSLog(@"打开了 ");
//        if (_isAdd == NO) {
//            [self.view addGestureRecognizer:tapGuesture];
//            _isAdd = YES;
//        }
//    }else{
//        NSLog(@"关闭了 ");
//        [self.view removeGestureRecognizer:tapGuesture];
//        _isAdd =NO;
//    }
//}
- (IBAction)tapGuesture:(id)sender{
    [dvc clickDrawerButton];
    if (dvc.isDrawOpen == YES) {
        NSLog(@"打开了 ");
        if (_isAdd == NO) {
            [self.view addGestureRecognizer:tapGuesture];
            _isAdd = YES;
        }
    }else{
        NSLog(@"关闭了 ");
        [self.view removeGestureRecognizer:tapGuesture];
        _isAdd =NO;
    }
}
-(IBAction)imageTapClicked:(UIGestureRecognizer *)sender{
    NSLog(@"点击了");
    WTNDetailViewController *wdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNDetailViewController"];
  //  ADvc.imageUrl = _adScrollView.imageUrl;
    wdvc.imageUrl = _adScrollView.imageUrl;
    //    view 为点击事件的对象
    [self.navigationController pushViewController:wdvc animated:YES];
    
}
#pragma mark -
#pragma mark 加载数据
-(void)loadADdata{
    [[WTNADService new]getADImageList:^(id data) {
        _adScrollView.imageArr = data;
        [_adScrollView reloadData];
    }];
    // 图片上的文字
    [[WTNADService new]getADLabelList:^(id data) {
        _adScrollView.labelArr = data;
        [_adScrollView reloadData];
    }];
    [[WTNADService new]getADdetail:^(id data) {
        // _adScrollView.imageUrlArr = data;
        _adScrollView.imageUrlArr = data;
        [_adScrollView reloadData];
    }];

}
-(void)loadData{
    i = 1;
     __weak typeof(*&self)blockSelf = self;
    _strTime = @"latest";
    _dateTime = @"?client=0";
    [[WTNArticalService new]getArticalListByTime:_strTime Date:_dateTime complete:^(id data) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        _newsArr = data;
        [blockSelf.tableView reloadData];
    }];
}
-(void)loadMore{
    
    __weak typeof(*&self)blockSelf = self;
    //创建一个时间戳对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [NSDate date];
    _strTime = @"before/";
    NSString *str1 = @"?client=0";
    //<4>以date时间为基准过了多少秒之后的时间 【掌握】
    NSDate *date1 = [NSDate  dateWithTimeInterval:-i*24*60*60 sinceDate:date];
    //把时间对象转换成字符串对象
    NSString *dateString = [formatter  stringFromDate:date1];
    _dateTime = [NSString stringWithFormat:@"%@%@",dateString,str1];
    [[WTNArticalService new]getArticalListByTime:_strTime Date:_dateTime complete:^(id data) {
        if ([self.tableView.footer isRefreshing]) {
          [self.tableView.footer endRefreshing];
        }
            [_newsArr addObjectsFromArray:data];
            [blockSelf.tableView reloadData];
            }];
    i++;
}
#pragma mark -
#pragma mark 代理

#pragma mark -
#pragma mark 业务逻辑
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _newsArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNArticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1 forIndexPath:indexPath];
    WTNStoryModel *model = _newsArr[indexPath.row];
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[model.images firstObject]] placeholderImage:[UIImage imageNamed:@"sports"]];
    cell.titleLabel.text = model.title;
    
    //创建一个时间戳对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [NSDate date];
    //把时间对象转换成字符串对象
    NSString *dateString = [formatter  stringFromDate:date];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",dateString];
    return cell;
}
//选中一行跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在sprots.storyBoard 设置 view controller继承 FootballDetailViewController  storyBoard ID 为 FootballDetailViewController
    WTNArticalDetailViewController *ADvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNArticalDetailViewController"];
    ADvc.storyModel = _newsArr[indexPath.row];
    //点击跳转到下一个页面之前 隐藏底部栏
    ADvc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:ADvc animated:YES];
}
#pragma mark -
#pragma mark 通知注册和销毁
@end
