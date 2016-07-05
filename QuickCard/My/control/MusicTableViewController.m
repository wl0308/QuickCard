//
//  MusicTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MusicTableViewController.h"
#import "CellUtil.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AddMemoTableViewController.h"
@interface MusicTableViewController ()

{

    //创建音乐播放对象
    AVAudioPlayer *player;
    
}

@property (nonatomic,assign) float height;
@property (nonatomic,copy) NSString *musicName;

@end


@implementation MusicTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //cell高度的划分
    
    float height = (SCREEN_H - NAVSIZE_H) / 25;
    self.height = height;
    
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"铃声";
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


}

// 返回

- (void)goBack {
    
    AddMemoTableViewController *addMemoVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
    addMemoVC.musicLab.text = self.musicName;
    
       addMemoVC.saveBtn.hidden = NO;
    
    [self.navigationController popToViewController:addMemoVC animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
        
    }
    
    else if (section == 1) {
    
        return 4;
        
    }
    
    else if (section == 2) {
        
        return 1;
        
    }
    
    else
    {
        
        return 2;
        
    }
  
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    
    if (indexPath.section == 0) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
   else if (indexPath.section == 1) {
       
    if (indexPath.row == 0) {
           
        [self cellShow:cell musicName:@"星语心愿 (默认)"];
        
    }

   else if (indexPath.row == 1) {
        
        [self cellShow:cell musicName:@"给自己的情书"];
       
    }
    
   else if (indexPath.row == 2) {
       
       [self cellShow:cell musicName:@"晨雾"];
       
   }
    
   else if (indexPath.row == 3) {
       
       [self cellShow:cell musicName:@"巴比伦的山"];
       
   }
  
}
   else if (indexPath.section == 2) {
       
       [CellUtil fillcolor:cell high:self.height];
       
   }
    
   else if (indexPath.section == 3) {
       
       if (indexPath.row == 0) {
          
     
        [self cellShow:cell musicName:@"无"];
  
    }
    
   else if (indexPath.row == 1){
   
       [CellUtil fillcolor:cell high:SCREEN_H - NAVSIZE_H -self.height * 12];
       
   }
}
    return cell;
}

- (void)cellShow:(UITableViewCell *)cell musicName:(NSString *)str {

    UILabel *musicLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 150, self.height * 2 - 16)];
    musicLab.text = str;
    
    [cell.contentView addSubview:musicLab];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        
        return self.height;
        
    }
    
    else if (indexPath.section == 1) {
    
        return self.height * 2;
        
    }
    
    else if (indexPath.section == 2)
    {
    
        return self.height;
        
    }
    else
    {
    
        if (indexPath.row == 0) {
            
            return self.height * 2;
            
        }
        
        else
        {
        
            return SCREEN_H - NAVSIZE_H -self.height * 12;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        [self playMusic:@"星语心愿"];
        self.musicName = @"星语心愿";
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    }
    
    else if (indexPath.row == 1) {
    
        [self playMusic:@"给自己的情书"];
         self.musicName = @"给自己的情书";
        
         [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    }
    
    else if (indexPath.row == 2) {
        
        [self playMusic:@"晨雾"];
           self.musicName = @"晨雾";
         [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    }
    
    else if (indexPath.row == 3) {
        
        [self playMusic:@"巴比伦的山"];
           self.musicName = @"巴比伦的山";
         [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {


    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    
    return indexPath;
}

//音乐播放

- (void)playMusic:(NSString *)musicName {

    NSString *name = [[NSBundle mainBundle] pathForResource:musicName ofType:@"m4r"];
    NSLog(@"%@",musicName);
    NSURL *url = [NSURL fileURLWithPath:name];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    [player play];
    
}









@end
