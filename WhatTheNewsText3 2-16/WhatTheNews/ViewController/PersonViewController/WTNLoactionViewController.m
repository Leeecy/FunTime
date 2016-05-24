//
//  WTNLoactionViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNLoactionViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
// 需要在info.plist 配置NSLocationWhenInUseUsageDescription
@interface WTNLoactionViewController ()<MKMapViewDelegate>{
    
    __weak IBOutlet MKMapView *myMapView;
    CLLocationManager * manager;
}

@end

@implementation WTNLoactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//解决内存外泄
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
}
#if 1
-(void)configUI{
    // 判断是否允许使用定位
    if ([CLLocationManager locationServicesEnabled]) {
        manager = [CLLocationManager new];
        // 向用户申请定位权限
        [manager requestWhenInUseAuthorization];
        myMapView.delegate = self;
        // 显示当前用户的位置
        myMapView.showsUserLocation = YES;
        // 添加一个长按事件
        UIGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [myMapView addGestureRecognizer:longPressGesture];
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按");
        // 得到屏幕上长按的坐标
        CGPoint point = [recognizer locationInView:myMapView];
        NSLog(@"%f-%f", point.x, point.y);
      [self addPinView:point];
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        NSLog(@"松手");
    }
}
-(void)addPinView:(CGPoint)point{
    CLLocationCoordinate2D coordinate = [myMapView convertPoint:point toCoordinateFromView:myMapView];
    NSLog(@"%f-%f", coordinate.latitude, coordinate.longitude);
    // 创建遮盖物
    MKPointAnnotation * annotation = [MKPointAnnotation new];
    // 设置经纬度
    annotation.coordinate = coordinate;
    // 反编码
    [self reverseGeocode:coordinate annotion:annotation];
    annotation.subtitle = @"当前位置";
    // 添加大头针
    [myMapView addAnnotation:annotation];
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 以用户位置为中心点，地图放大(1000是方圆1000米)
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 1000, 1000);
        [mapView setRegion:region animated:YES];
    });
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString * identifier = @"myPinView";
    MKPinAnnotationView * pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.pinColor = MKPinAnnotationColorPurple;// 设置大头针颜色
        pinView.animatesDrop = YES;// 设置是否有掉落动画
        pinView.draggable = YES;// 设置是否可以拖动
        // 显示信息
        pinView.canShowCallout = YES;
        // 创建右边视图
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        pinView.rightCalloutAccessoryView = btn;
        // 创建左边视图
        UIImageView * view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingwei"]];
        pinView.leftCalloutAccessoryView = view;
    }else{
        pinView.annotation = annotation;
    }
    return pinView;
}

-(IBAction)btnClicked:(id)sender{
    NSLog(@"按钮被点击");
}

//反编码
-(void)reverseGeocode:(CLLocationCoordinate2D) coordinate annotion:(MKPointAnnotation *)annotion{
    CLLocationDegrees longitude = coordinate.longitude;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocation *location =[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder * geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error || placemarks.count == 0) {
            NSLog(@"没有找到");
        }else{
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
                NSLog(@"%.2f---%.2f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
                annotion.title = placemark.name;
            }
        }
    }];
}
#endif

@end
