//
//  MyTakeOffTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/11/7.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MyTakeOffTableViewController.h"
#import "MyTakeOff.h"
#import "AFNetworking.h"
#import "MyTakeOffTableViewCell.h"
@interface MyTakeOffTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSString *user_id;
    MyTakeOffTableViewCell *cell;
}
@property(strong,nonatomic)NSMutableArray *myTakeOffArr;
@end

@implementation MyTakeOffTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    _myTakeOffArr=[NSMutableArray array];
    NSMutableDictionary *absDict=[NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    user_id=[userDefaults objectForKey:@"user_id"];
    [absDict setValue:user_id forKey:@"user_id"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 请求的序列化
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 回复序列化
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer=[[AFJSONResponseSerializer alloc]init];
    // 设置回复内容信息

    // 执行请求
    [manager POST:@"http://10.110.5.119:8888/QuickCard/absence.php?action=show_my"
       parameters:absDict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *dict=(NSDictionary *)responseObject;
              
              NSArray *dataArr=[dict valueForKey:@"data"];
              
              int code=[[dict valueForKey:@"code"]intValue];
              if (code == 200) {
                  for (NSDictionary *dict in dataArr) {
                      MyTakeOff *MyTakeOffText=[MyTakeOff MytakeOffWithDictionary:dict];
                      
                      [_myTakeOffArr addObject:MyTakeOffText];
                      
                      [self addTableView];
                  }
                  
              }
              [_tableView reloadData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"%@",error);
          }];
    


}
-(void)addTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_W,SCREEN_H-63)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _myTakeOffArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_H/6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID=@"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[MyTakeOffTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    MyTakeOff *myTakeOff=_myTakeOffArr[indexPath.row];
    cell.myTakeOff=myTakeOff;
    
    [cell myTakeOffShow];
    return cell;
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.navigationBar.hidden = YES;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
