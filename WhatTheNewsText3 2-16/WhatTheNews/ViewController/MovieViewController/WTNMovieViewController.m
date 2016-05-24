//
//  WTNMovieViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNMovieViewController.h"

#import "WTNMovieService.h"
#import "WTNMovieCollectionViewCell.h"
#import "WTNMovieNewsTableViewCell.h"
#import "WTNListModel.h"
#import "WTNMovieListModel.h"
#import "WTNMovieNewsModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "WTNMovieDetailViewController.h"
#import "ADScrollView.h"
#import "WTNMovieNewsDetailViewController.h"
#import "WTNDrawerViewController.h"
@interface WTNMovieViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UISegmentedControl *_segmentControl;
    NSMutableArray *_movieArr;
    WTNMovieListModel *model;
    UIScrollView *_adScrollView;
     NSMutableArray *_movieNewsArr;
    WTNDrawerViewController * dvc;
    int _index;
    
    //判断当前界面是否打开
    BOOL _isAdd;
    //    添加点击手势返回  手势与界面点击有冲突 需要判断
    UITapGestureRecognizer *tapGuesture;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UITableView *tableView;
@end
static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifier1 = @"Cell1";

@implementation WTNMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadMore];
    [self loadDataNews];
    [self configUI];
    [self refresh];
}
-(void)viewWillAppear:(BOOL)animated{
//     [self.collectionView reloadData];
   // _segmentControl.selectedSegmentIndex = 0;//默认选中的按钮索引
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 初始化UI

-(void)configUI{
   // self.automaticallyAdjustsScrollViewInsets = NO;
    //创建流式布局对象
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动的方法(Vertical竖向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    //创建tableView大小
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStylePlain)];
        [_segmentControl addTarget:self action:@selector(valueChange:) forControlEvents:(UIControlEventValueChanged)];
//    [self.view addSubview:_TVCollectionView];
   // 4、代理授权并添加至视图。
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WTNMovieCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
    
    [self.view addSubview:self.collectionView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WTNMovieNewsTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier1];
  
    // 抽屉控制器
    dvc = (WTNDrawerViewController*)self.navigationController.tabBarController.parentViewController;
    //    滑动返回手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
    //    点击手势
    tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuesture:)];
}

#pragma mark -
#pragma mark 事件
- (IBAction)panGesture:(id)sender{
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

//-(IBAction)panGesture:(id)sender{
//     [dvc clickDrawerButton];
//}
// 刷新
-(void)refresh{
    // 三方库刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.collectionView.header isRefreshing]) {
                [self.collectionView.header endRefreshing];
            }
        });
    }];
    //影讯刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView.footer endRefreshing];
            }
        });
    }];
}
#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    __weak typeof(*&self)blockSelf = self;
    [[WTNMovieService new]getMovieList:^(id data) {
        if ([self.collectionView.header isRefreshing]) {
            [self.collectionView.header endRefreshing];
        }
        _movieArr = data;
        [blockSelf.collectionView reloadData];
    }];
}
//获取影讯的数据
-(void)loadDataNews{
    _index = 0;
    __weak typeof(*&self)blockSelf = self;
    [[WTNMovieService new]getMovieNewsByIndex:_index complete:^(id data) {
        _movieNewsArr= data;
        [blockSelf.tableView reloadData];
    }];
}
-(void)loadMore{
    _index = _index+10;
    __weak __typeof(*&self) blockSelf = self;
    [[WTNMovieService new]getMovieNewsMoreByIndex:_index complete:^(id data) {
        //加载下一个页面 这段代码是加载所有数据
        [_movieNewsArr addObjectsFromArray:data];
        [blockSelf.tableView reloadData];
    }];
}

-(IBAction)valueChange:(UISegmentedControl*)sender{
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
    int Index = (int)sender.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [self firstSegment];//调用firstsegment方法
            break;
        case 1:
            [self secondSegment];//
            break;
        default:
            break;
    }
}
- (void)firstSegment{
    
    [self.view addSubview:self.collectionView];
     self.collectionView.hidden = NO;
    self.tableView.hidden = YES;
}

- (void)secondSegment{
    [self.view addSubview:self.tableView];
    self.tableView.hidden = NO;
    self.collectionView.hidden = YES;

}
// 设置元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //   NSArray *arr =  ((NSArray *)[_movieArr[0]lastObject]);
    // NSArray *arr = model.listArr;
    return _movieArr.count;
}
#pragma mark -
#pragma mark 业务逻辑
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _movieNewsArr.count;
}
//返回单元格的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    return CGSizeMake((SCREEN_WIDTH - 30) / 2, (SCREEN_WIDTH - 20) / 2);
    return CGSizeMake((SCREEN_WIDTH - 30) / 2,240);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTNMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //    model = _movieArr[indexPath.row];
    cell.contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
    WTNListModel *lmodel = _movieArr[indexPath.row];
    cell.movieName.text = lmodel.programname;
    cell.movieDescription.text = lmodel.craw;
    [cell.movieImageIcon sd_setImageWithURL:[NSURL URLWithString:lmodel.vthumburl]];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WTNMovieDetailViewController *MDvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNMovieDetailViewController"];
    MDvc.listModel = _movieArr[indexPath.row];
//    NSLog(@"22222=%@",MDvc.listModel.listId);
    //点击跳转到下一个页面之前 隐藏底部栏
    MDvc.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:MDvc animated:YES];
}
/*****************影讯代码**************/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNMovieNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1 forIndexPath:indexPath];
    //    model = _movieArr[indexPath.row];
    WTNFilmNewsListModel *lmodel = _movieNewsArr[indexPath.row];
    cell.movieName.text = lmodel.filmName;
    cell.movieTime.text = lmodel.shortIntro;
    //cell.movieNation.text = [NSString stringWithFormat:@"上映地区:%@",lmodel.nation]  ;
//上映时间
    NSString *str = [NSString stringWithFormat:@"%@",lmodel.firstPlayTime];
    NSRange range = {0,10};
    lmodel.firstPlayTime = [str substringWithRange:range];
    double date1 = (double)[lmodel.firstPlayTime intValue];
    NSDate * date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    //<4>以date时间为基准过了多少秒之后的时间 【掌握】
    NSDate *date3 = [NSDate  dateWithTimeInterval:8*60*60 sinceDate:date2];
    //创建一个时间戳对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    formatter.dateFormat = @"yyyy年MM月dd日上映";
    //把时间对象转换成字符串对象
    NSString *dateString = [formatter  stringFromDate:date3];
    cell.movieNation.text = [NSString stringWithFormat:@"上映时间:%@",dateString];
    cell.movieType.text = [NSString stringWithFormat:@"类型:%@",lmodel.category]  ;
    cell.movieScore.text = lmodel.grade;
    
    [cell.movieImageIcon sd_setImageWithURL:[NSURL URLWithString:lmodel.minposterAddress]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WTNMovieNewsDetailViewController *MNDvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNMovieNewsDetailViewController"];
    MNDvc.newsListModel = _movieNewsArr[indexPath.row];
    //点击跳转到下一个页面之前 隐藏底部栏
//    NSLog(@"self.navigationController======%@",self.navigationController);
    MNDvc.hidesBottomBarWhenPushed  = YES;
   [self.navigationController pushViewController:MNDvc animated:YES];
 
}

@end
