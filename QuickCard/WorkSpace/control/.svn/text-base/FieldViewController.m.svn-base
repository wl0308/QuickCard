//
//  FieldViewController.m
//  QuickCard
//
//  Created by Destiny on 15/10/21.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "FieldViewController.h"
#import "AFNetworking.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FieldViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) UIButton *startPliot;
@property (nonatomic, strong) UIButton *endPliot;
@property (nonatomic, strong) UIButton *startFieldWork;
@property (nonatomic, strong) UITextField *endPlace;
@property (nonatomic, strong) UITextField *reason;
@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation FieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    /**
     自定义导航栏左侧按钮
     */
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    
    /**
     自定义起点text
     */
    UITextField *startPlace = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.15, SCREEN_W * 0.5, SCREEN_W * 0.1)];
    startPlace.placeholder = @"输入起点";
    
    [self.view addSubview:startPlace];
    
    /**
     自定义横线
     */
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.21, SCREEN_W * 0.5, 0.5)];
    UIColor *mycolor = [UIColor colorWithWhite:0.7 alpha:0.80]; //自定义color（浅灰色）
    v1.backgroundColor = mycolor;
    
    [self.view addSubview:v1];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.28, SCREEN_W * 0.5, 0.5)];
    v2.backgroundColor = mycolor;
    
    [self.view addSubview:v2];
    
    
    /**
     自定义的目的地text
     */
    _endPlace = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.22, SCREEN_W * 0.5, SCREEN_W * 0.1)];
    _endPlace.placeholder = @"输入目的地";

    [self.view addSubview:_endPlace];
    
    
    /**
     自定义的原由text
     */
    _reason = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.29, SCREEN_W * 0.5, SCREEN_W * 0.1)];
    _reason.placeholder = @"外勤原由";
    
    [self.view addSubview:_reason];
    
    
    /**
     自定义开始导航和结束导航按钮
     */
    _startPliot = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W *0.7, SCREEN_H * 0.29, SCREEN_W * 0.2, SCREEN_W * 0.08)];
    
    [_startPliot setTitle:@"开始导航" forState:UIControlStateNormal];
    _startPliot.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIColor *bColor = [[UIColor alloc]initWithRed:70/255.0 green:135/255.0 blue:220/255.0 alpha:0.8];
    _startPliot.backgroundColor = bColor;
    
    _startPliot.layer.cornerRadius = SCREEN_W * 0.04;
    //_startPliot.enabled = NO;
    
    [_startPliot addTarget:self action:@selector(startpliot) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_startPliot];
    
    _endPliot = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W *0.7, SCREEN_H * 0.29, SCREEN_W * 0.2, SCREEN_W * 0.08)];
    
    [_endPliot setTitle:@"结束导航" forState:UIControlStateNormal];
    _endPliot.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _endPliot.backgroundColor = bColor;
    
    _endPliot.layer.cornerRadius = SCREEN_W * 0.04;
    _endPliot.hidden = YES;
    
    [_endPliot addTarget:self action:@selector(endpliot) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_endPliot];
    
    /**
     自定义外勤按钮
     */
    _startFieldWork = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.2, SCREEN_H * 0.5, SCREEN_W * 0.6, SCREEN_W * 0.16)];
    
    _startFieldWork.backgroundColor = bColor;
    
    [_startFieldWork setTitle:@"开始外勤" forState:UIControlStateNormal];
    
    _startFieldWork.layer.cornerRadius = SCREEN_W * 0.08;
    
    [_startFieldWork addTarget:self action:@selector(startfieldwork) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_startFieldWork];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    //remove掉上个视图navgationBar上的button控件
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
}

//关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}


/**
 *  返回按钮的点击事件
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = YES;
}

/**
 *  开始导航对应的点击事件
 */
- (void)startpliot
{
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, SCREEN_H * 0.35, SCREEN_W, SCREEN_H * 0.65)];
    
    [self.view addSubview:_mapView];
    
    _mapView.delegate = self;
    
    //_mapView.showsUserLocation = YES;
    
    [_mapView setMapType:MKMapTypeStandard];
    
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    [_mapView setRotateEnabled:YES];
    
    //120.61764,31.336032
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(31.336032, 120.61764), MKCoordinateSpanMake(0.1, 0.1));
    [_mapView setRegion:[_mapView regionThatFits:region]];
    
    //获取输入位置的经纬度
    CLGeocoder *geo = [CLGeocoder new];
    [geo geocodeAddressString:self.endPlace.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks firstObject];
        float longitude = mark.location.coordinate.longitude;
        float latitude = mark.location.coordinate.latitude;
        NSLog(@"%lf,%lf",longitude,latitude);
        //设置目的地的地图标注
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
        
        //标注
        MKPointAnnotation *pointAnntation = [[MKPointAnnotation alloc]init];
        [pointAnntation setTitle:@"目的地位置"];
        [pointAnntation setSubtitle:self.endPlace.text];
        [pointAnntation setCoordinate:coordinate2D];
        
        [_mapView addAnnotation:pointAnntation];
    }];
    
    locationManager = [[CLLocationManager alloc]init];
    
    if(![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"定位服务尚未打开，请打开!");
        return;
    }
    
    //如果没有授权则请求用户授权
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [locationManager requestWhenInUseAuthorization];
        
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        locationManager.delegate =self;
        
        //设置定位精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        CLLocationDistance distance = 10.0; // 十米定位一次
        locationManager.distanceFilter = distance;
        NSLog(@"启动跟踪定位");
        
        //启动跟踪定位
        [locationManager startUpdatingLocation];
    }
    
    _startPliot.hidden = YES;
    _endPliot.hidden = NO;
}

#pragma mark - CoreLocation delegate

//跟踪定位代理方法，位置发生变化都会执行
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate; //位置坐标
    NSLog(@"%f,%f",coordinate.longitude,coordinate.latitude);
    
    //设置地图标注
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    
    //标注
    MKPointAnnotation *pointAnntation = [[MKPointAnnotation alloc]init];
    [pointAnntation setTitle:@"当前位置"];
    
    [pointAnntation setCoordinate:coordinate2D];
    
    [_mapView addAnnotation:pointAnntation];

    //不需要实时定位时，使用完即关闭定位服务
    [locationManager stopUpdatingLocation];
}


/**
 *  结束导航对应的点击事件
 */
- (void)endpliot
{
    _startPliot.hidden = NO;
    _endPliot.hidden = YES;
    
    [_mapView removeFromSuperview];
}

/**
 *  外勤对应的点击事件
 */
- (void)startfieldwork
{
    
    /**
     从本地获取数据
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [userDefaults objectForKey:@"user_id"];
    
    
    if ([_startFieldWork.titleLabel.text isEqualToString:@"开始外勤"])
    {
        
        if ([_endPlace.text isEqualToString:@""] && [_reason.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
            
        }else{
            
            
            /**
             外勤数据存入数据库
             */
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:user_id forKey:@"user_id"];
            [dict setValue:self.endPlace.text forKey:@"fie_destination"];
            [dict setValue:self.reason.text forKey:@"fie_reason"];
            [dict setValue:@"开始外勤" forKey:@"fie_type"];

            manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
            
            [manager POST:fieldwork_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dict= (NSDictionary *)responseObject;
                
                int code = [[dict valueForKey:@"code"]intValue];
                
                if (code == 200) {
                    [_startFieldWork setTitle:@"结束外勤" forState:UIControlStateNormal];
                    _startPliot.enabled = YES;
                }
                
            
            } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
                NSLog(@"错误%@",error);
            }];
            
        }
        
    }else{
        
        if ([_endPlace.text isEqualToString:@""] && [_reason.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
            
        }else{
            
            
            /**
             外勤数据存入数据库
             */
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:user_id forKey:@"user_id"];
            [dict setValue:self.endPlace.text forKey:@"fie_destination"];
            [dict setValue:self.reason.text forKey:@"fie_reason"];
            [dict setValue:@"结束外勤" forKey:@"fie_type"];
            
            manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
            
            [manager POST:fieldwork_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dict= (NSDictionary *)responseObject;
                
                int code = [[dict valueForKey:@"code"]intValue];
                
                if (code == 200)
                {
                    [_startFieldWork setTitle:@"开始外勤" forState:UIControlStateNormal];
                    _startPliot.enabled = NO;
                }
                
            } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
                NSLog(@"错误%@",error);
            }];
        }
    }
    
}
@end
