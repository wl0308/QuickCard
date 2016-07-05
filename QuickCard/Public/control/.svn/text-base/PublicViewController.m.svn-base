//
//  PublicViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PublicViewController.h"
#import "PublicMissingViewController.h"
#import "PublicContnent.h"
#import "AFNetworking.h"
#define myWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height
#define myHeight [UIScreen mainScreen].bounds.size.height/4
#define myHead [UIScreen mainScreen].bounds.size.height/6-[UIScreen mainScreen].bounds.size.height/18
@interface PublicViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    //    UITableView *_tableView;
    UIScrollView *_publicScrollView;
    UIImageView *_headImage;
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    UIPageControl *_pageControl;
    //    NSMutableDictionary *_imageData;
    UILabel *_titleSections;
    int _currentImageIndex;
    int _imageCount;
    int _depCount;
    NSArray *depArr;
    NSDictionary *dict1;

}
//@property (weak, nonatomic) IBOutlet UITableView *publicTableView;
@property (strong,nonatomic) UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UIScrollView *publicScrollView;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic)NSArray *imageData;
@property(strong,nonatomic)NSMutableArray *notArr;
@property(strong,nonatomic)NSMutableArray *contestArr;


//@property(weak,nonatomic)UILabel *lbl;
@end


@implementation PublicViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImageData];
    [self addScrollView];
    [self addImageViews];
    [self setSrollerDerImage];
    [self addPageControl];
    [self addTimer];
    
    [self clipExtraCellLina:_tableView];
    [self addNavImage];
    
    self.view.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
    
    _notArr=[NSMutableArray array];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
    _contestArr=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 请求的序列化
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 回复序列化
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer=[[AFJSONResponseSerializer alloc]init];
    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    // 执行请求
    [manager POST:notice_show
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *dict=(NSDictionary *)responseObject;
              
              NSArray *dataArr=[dict valueForKey:@"data"];
              
              int code=[[dict valueForKey:@"code"]intValue];
              if (code == 200) {
                  for (dict1 in dataArr) {
                      PublicContnent *notText=[PublicContnent PublicContentWithDictionary:dict1];
                      NSLog(@"23333%@",[dict1 valueForKey:@"not_contnent"]);
                      [_notArr addObject:notText];
                      
                      [self addTableView];
                  }
                
              }
              [self.tableView reloadData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"%@",error);
          }];
    
    
}


-(void)loadImageData{
    if (_imageData==nil) {
        _imageData=[NSArray array];
        _imageData=@[@"0.png",@"1.png",@"2.png"];
    }
    
    _imageCount=(int)_imageData.count;
}
-(void)addNavImage{
    UIImage *backgrouImage=[UIImage imageNamed:@"nav_bg"];
    [self.navigationController.navigationBar setBackgroundImage:backgrouImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.topItem.title =@"通告";
    
    
}

-(void)addScrollView{
    _publicScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, myHead+10, myWidth, myHeight)];
    _publicScrollView.delegate=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [_publicScrollView setContentOffset:CGPointMake(myWidth, 0)animated:NO];
    _publicScrollView.pagingEnabled=YES;
    _publicScrollView.showsHorizontalScrollIndicator=NO;
    _publicScrollView.contentSize=CGSizeMake(myWidth*3, 0);
//    [self.view addSubview:_publicScrollView];
}
-(void)addImageViews{
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, myWidth , myHeight)];
    _leftImageView.contentMode=UIViewContentModeScaleToFill;
    _leftImageView.userInteractionEnabled=YES;
  
    [_publicScrollView addSubview:_leftImageView];
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(myWidth, 0, myWidth, myHeight)];
    _centerImageView.contentMode=UIViewContentModeScaleToFill;
    _centerImageView.userInteractionEnabled=YES;
    [_publicScrollView addSubview:_centerImageView];
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*myWidth, 0, myWidth, myHeight)];
    _rightImageView.contentMode=UIViewContentModeScaleToFill;
    _rightImageView.userInteractionEnabled=YES;
    [_publicScrollView addSubview:_rightImageView];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, myWidth, myHeight)];
    [_centerImageView addSubview:btn];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

//-(void)click{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Public" bundle:nil];
//    PublicMissingViewController *gVC = [storyboard instantiateViewControllerWithIdentifier:@"goodsVC"];
//    
//    _titleSections.text=@"重要通知";
//    gVC.mytitle=_titleSections.text;
//    [self.navigationController pushViewController:gVC animated:YES];
//}
-(void)setSrollerDerImage{
    _leftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_imageCount-1]];
    _centerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",0]];
    _rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",1]];
    _currentImageIndex=0;
    _pageControl.currentPage=_currentImageIndex;
    
}
-(void)addPageControl{
    _pageControl=[[UIPageControl alloc]init];
    CGSize size=[_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(myWidth/2, myHeight+myHeight/2);
    _pageControl.numberOfPages=_imageCount;
    [self.view addSubview:_pageControl];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    [_publicScrollView setContentOffset:CGPointMake(myWidth, 0)animated:NO];
    _pageControl.currentPage=_currentImageIndex;
}
-(void)reloadImage{
    int leftImageIndex,rightImageIndex;
    CGPoint offset=[_publicScrollView contentOffset];
    if (offset.x>myWidth/2) {
        _currentImageIndex=(_currentImageIndex+1)%_imageCount;
    }else if(offset.x<myWidth/2){
        _currentImageIndex=(_currentImageIndex+_imageCount-1)%_imageCount;
    }
    _centerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",_currentImageIndex]];
    leftImageIndex=(_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex=(_currentImageIndex+1)%_imageCount;
    _leftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",leftImageIndex]];
    _rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",rightImageIndex]];
}
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage{
    NSInteger page = _pageControl.currentPage;
    page++;
    if (page == 3) {
        page = 0;
    }
    CGPoint point = CGPointMake(myWidth * page, 0);
    [_publicScrollView setContentOffset:point animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / myWidth +0.5;
    _pageControl.currentPage = page ;
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 25;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
// 当视图将要拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
//当视图停止拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        [self addTimer];
    });
}
- (void)removeTimer{
    [self.timer invalidate];
//    self.timer = nil;
}
-(void)addTableView{
     _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, myHead+10, myWidth,mainHeight-myHead+10)];
     _tableView.dataSource=self;
     _tableView.delegate=self;
     [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    for (NSDictionary *dict in self.notArr) {
        depArr=[dict valueForKey:@"dep_department"];
//        NSLog(@"2333%@",depArr);
//        if (depArr.count!=0) {
//            return depArr.count;
//        }
    }
    
    
    return self.notArr.count;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    PublicContnent *publicContnent=self.notArr[indexPath.section];
    cell.textLabel.text=publicContnent.not_contnent;
    cell.textLabel.numberOfLines=0;
    
    self.tableView.tableHeaderView=_publicScrollView;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 21;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _titleSections=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 21)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(myWidth-60, 0, 60, 21)];
    lbl.font=[UIFont systemFontOfSize:10];
    UIView *headerView=[[UIView alloc]init];
    headerView.userInteractionEnabled=YES;
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0];

    UIImageView *HD=[[UIImageView alloc]initWithFrame:CGRectMake(myWidth/64, 21, myWidth-myWidth/32, 0.5)];
    HD.backgroundColor=[UIColor blackColor];
    [headerView addSubview:HD];
    
    UIImageView *HD1=[[UIImageView alloc]initWithFrame:CGRectMake(myWidth/64, 0, myWidth-myWidth/32, 0.5)];
    HD1.backgroundColor=[UIColor blackColor];
    [headerView addSubview:HD1];
   
    PublicContnent *publicContnent=self.notArr[section];
    _titleSections.text=publicContnent.dep_department;
    lbl.text=publicContnent.not_date;
    

    
    [headerView addSubview:_titleSections];
    [headerView addSubview:lbl];
    
    return headerView;
}

-(void)clipExtraCellLina:(UITableView *)tableView{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Public" bundle:nil];
    PublicMissingViewController *gVC = [storyboard instantiateViewControllerWithIdentifier:@"goodsVC"];
    PublicContnent *publicContnent=self.notArr[indexPath.section];
    _titleSections.text=publicContnent.dep_department;
    gVC.mytitle=_titleSections.text;
    gVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:gVC animated:YES];
    
}
@end

