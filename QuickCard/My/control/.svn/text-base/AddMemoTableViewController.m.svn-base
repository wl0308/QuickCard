//
//  AddMemoTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AddMemoTableViewController.h"
#import "CellUtil.h"
#import "LabelViewController.h"
#import "AFNetworking.h"
#import "MusicTableViewController.h"

@interface AddMemoTableViewController ()

@property (nonatomic,strong) NSString *nowDate;

@end

@implementation AddMemoTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.detailLab = [[UILabel alloc] init];
    self.tableView.scrollEnabled = NO;
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"添加";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    //自定义导航栏右侧按钮
    
    self.saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 28)];
    
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    self.saveBtn.hidden = YES;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:self.saveBtn];
    
  
    self.navigationItem.rightBarButtonItem = save;
    
    
    [self viewWillAppear:YES];

}


- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)save {

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [user valueForKey:@"user_id"];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    if ((self.detailLab.text == nil) ||[self.detailLab.text isEqualToString:@""] ||[self.detailLab.text isEqualToString:@" "]) {
        
        [dict setObject:@"无" forKey:@"mem_content"];
    }
    else
    {
      [dict setObject:self.detailLab.text forKey:@"mem_content"];
        
    }
    
    if ((self.nowDate == nil) ||[self.nowDate isEqualToString:@""] ||[self.nowDate isEqualToString:@" "]) {
        [dict setObject:@"无" forKey:@"mem_datetime"];
    }
  else
  {
    [dict setObject:self.nowDate forKey:@"mem_datetime"];
      
  }
    [dict setObject:self.musicLab.text forKey:@"mem_mus"];
    
    [mgr POST:memorandum_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"----------%d",code);
            
        }
        
        else
        {
        
            NSLog(@"%d",code);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    UITableViewCell *cell = [UITableViewCell new];
   
    if (indexPath.row == 0) {
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.frame = CGRectMake(10, 0, SCREEN_W - 20, (SCREEN_H - NAVSIZE_H) / 3);
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
      
        [datePicker addTarget:self action:@selector(Change:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:datePicker];
  
    }
    
    else if (indexPath.row == 1) {
    
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.row == 2) {
    
        
        UILabel *funLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, self.height * 2 - 16)];
        funLab.text = @"标签";
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 8, SCREEN_W - 100, self.height * 2 - 16)];
        self.detailLab.textAlignment = NSTextAlignmentRight;
        
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.contentView addSubview:funLab];
        [cell.contentView addSubview:self.detailLab];
     
        
    }
    
    else if (indexPath.row == 3) {
        
        UILabel *funLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, self.height * 2 - 16)];
        funLab.text = @"铃声";
        
        self.musicLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 8, SCREEN_W - 100, self.height * 2 - 16)];
        self.musicLab.textAlignment = NSTextAlignmentRight;
        
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.contentView addSubview:funLab];
        [cell.contentView addSubview:self.musicLab];
        
    }
    
    else if (indexPath.row == 4) {
        
        
        UILabel *funLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, self.height * 2 - 16)];
        funLab.text = @"震动";
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_W - 60, 5, 40, self.height * 2 - 16)];
        
        switchView.on = YES;
        [switchView addTarget:self action:@selector(shake) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:funLab];
        [cell.contentView addSubview:switchView];
    }
    
    else
    {
    
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}


- (void)shake {
    
    
}
- (void)Change:(UIDatePicker *)datePicker {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.nowDate = [formatter stringFromDate:datePicker.date];
    NSLog(@"%@",self.nowDate);
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return (SCREEN_H - NAVSIZE_H) / 3;
        
    }

    else if (indexPath.row == 1) {
    
        return self.height;
        
    }
    else if (indexPath.row == 5) {
        
        return (SCREEN_H - NAVSIZE_H) / 3 * 2 -self.height * 7;
    
    }
    
    else
    {
    
        return self.height * 2;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 2) {
        
        UIStoryboard *storyboard = self.storyboard;
        LabelViewController *labelVC = [storyboard instantiateViewControllerWithIdentifier:@"labelID"];
        
        [self.navigationController pushViewController:labelVC animated:YES];
        
    }
    
    else if (indexPath.row == 3) {
    
        UIStoryboard *storyboard = self.storyboard;
        MusicTableViewController *musicVC = [storyboard instantiateViewControllerWithIdentifier:@"musicID"];
        
        [self.navigationController pushViewController:musicVC animated:YES];
        
    }
    
}
















@end
