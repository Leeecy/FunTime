//
//  WTNPersonalTableViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import "WTNPersonalTableViewController.h"
#import "WTNDrawerViewController.h"
#import "MBProgressHUD.h"
#import "SDImageCache.h"
@interface WTNPersonalTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    WTNDrawerViewController *dvc;
    __weak IBOutlet UILabel *clearCache;
    //判断当前界面是否打开
    BOOL _isAdd;
    //    添加点击手势返回  手势与界面点击有冲突 需要判断
    UITapGestureRecognizer *tapGuesture;
    UIAlertView *alert;
    float totalSize;
}

@end

@implementation WTNPersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
   
}
// 让缓存大小显示
-(void)viewWillAppear:(BOOL)animated{
    [self checkTmpSize];
//    clearCache.text =[NSString stringWithFormat:@"%.2fMB",totalSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configUI{
   [self createNavigationBar];
  //  clearCache.hidden = YES;
    // 抽屉控制器
   dvc = (WTNDrawerViewController*)self.navigationController.tabBarController.parentViewController;
    //    滑动返回手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
    //    点击手势
    tapGuesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGuesture:)];
    
    [self checkTmpSize];
//    int byteSize = (int)[SDImageCache sharedImageCache].getSize;
//    double size = byteSize /1024.0/1024.0;
    clearCache.text = [NSString stringWithFormat:@"(%.2fM)",totalSize];
    //    NSString *document = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    WTNLog(@"document==%@",document);
    
}
// 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后颜色消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section== 1 &&indexPath.row == 0){
        alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定是否清理缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        //        [[SDImageCache sharedImageCache] clearDisk];
        //
        //        int byteSize = (int)[SDImageCache sharedImageCache].getSize;
        //
        //        double size = byteSize /1024.0/1024.0;
        //
        //        clearCache.text = [NSString stringWithFormat:@"(%.2fM)",size];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self removeCache];
    }
}
-(void)removeCache{
    //===============清除缓存==============
     [[SDImageCache sharedImageCache] clearDisk];
    // 得到沙盒cache路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@", cachePath);
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSLog(@"文件数:%lu",(unsigned long)[files count]);
    for (NSString *p in files)
    {
        NSError *error;
        // 得到沙盒cache路径
        NSString *path1 = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        //        清除
        if([[NSFileManager defaultManager] fileExistsAtPath:path1])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path1 error:&error];
        }
    }
    alert = [[UIAlertView alloc]initWithTitle:@"清理缓存" message:@"清理完成!"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [self checkTmpSize];
    clearCache.text =[NSString stringWithFormat:@"(%.2fMB)",totalSize];
}

-(float)checkTmpSize{
    totalSize = 0;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    需要获得目录的内容列表
     NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator)
    {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1024.0;
    }
    clearCache.text =[NSString stringWithFormat:@"(%.2fMB)",totalSize];
    return totalSize;
}
-(IBAction)panGesture:(id)sender{
    [dvc clickDrawerButton];
    if (dvc.isDrawOpen == YES) {
       // NSLog(@"打开了 ");
        if (_isAdd == NO) {
            [self.view addGestureRecognizer:tapGuesture];
            _isAdd = YES;
        }
    }else{
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
-(void)createNavigationBar{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeview_bg"]];
    self.navigationItem.title = @"个人设置";
    _tableView.delegate = self;
}

@end
























