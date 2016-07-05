//
//  PersonTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PersonTableViewController.h"
#import "CellUtil.h"
#import "MyCodeViewController.h"
#import "FamilyAddressViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MyTableViewController.h"

@interface PersonTableViewController ()

@property (nonatomic,assign) float height;
@property (nonatomic,strong)  UIImageView *imgView;
@property (nonatomic,strong) NSString *imageStr;


@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //cell高度的划分
    
    float height = (SCREEN_H - NAVSIZE_H) / 25;
    self.height = height;
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"个人信息";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //设置tableview不可滑动
    
    self.tableView.scrollEnabled = NO;
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = back;
    
    self.tableView.separatorStyle = YES;
    
    [self viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    
   
    
}




- (void)viewWillAppear:(BOOL)animated {


    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.detailLab.text = [user valueForKey:@"user_address"];
    
    
}

// 返回

- (void)goBack {
    
    MyTableViewController *mytableVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath,@"/image.png"];
    
    
    mytableVC.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];

    [self.navigationController popToViewController:mytableVC animated:YES];
     self.tabBarController.tabBar.hidden =NO;
    
    
    
    
}

//返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    return 10;
    
}

//


//cell信息展示

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //从沙盒获取数据
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_name = [user valueForKey:@"user_name"];
    NSString *user_number = [user valueForKey:@"user_number"];
    NSString *user_sex = [user valueForKey:@"user_sex"];
    NSString *user_mobile = [user valueForKey:@"user_mobile"];
    NSString *user_address = [user valueForKey:@"user_address"];
    
    //cell重用
    
    NSString *perCellID = @"perID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:perCellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:perCellID];
        
    }
    
    if (indexPath.row == 0) {
        
        [CellUtil fillcolor:cell high:self.height]; //调用灰色填充的类方法
        
    }
    
    else if (indexPath.row == 1) {
    
        UILabel *imgLab = [[UILabel alloc]initWithFrame:CGRectMake(15, (self.height * 3 - 30) / 2, 50, 30)];
        imgLab.text = @"头像";
        
        [cell.contentView addSubview:imgLab];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
       self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - self.height * 4 , 7, self.height * 3 - 14, self.height * 3 - 14)];
        
        NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath,@"/image.png"];
      
 
        self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];

   
        
        [cell.contentView addSubview:self.imgView];
        
    }
    
    else if (indexPath.row == 2) {
    
        [self showCell:cell functionName:@"姓名" detailinfos:user_name];
        
        
        
        
        
    }
    
    else if (indexPath.row == 3) {
    
        [self showCell:cell functionName:@"员工号" detailinfos:user_number];
        
    }
    
    else if (indexPath.row == 4) {
        
        [self showCell:cell functionName:@"性别" detailinfos:user_sex];
        
    }
    
    else if (indexPath.row == 5) {
        
        [self showCell:cell functionName:@"手机" detailinfos :user_mobile];
        
    }
    
    else if (indexPath.row == 6) {
        
        UILabel *codeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, (self.height * 2 - 30) / 2, 100, 30)];
        codeLab.text = @"我的二维码";
        
        [cell.contentView addSubview:codeLab];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    }
    
    else if (indexPath.row == 7) {
        
        [CellUtil fillcolor:cell high:self.height]; //调用灰色填充的类方法
        
    }
    
    else if (indexPath.row == 8) {
        
        cell.userInteractionEnabled = YES;
        UILabel *functionLab = [[UILabel alloc]initWithFrame:CGRectMake(15, (self.height * 2 - 30) / 2, 80, 30)];
        functionLab.text = @"家庭住址";
        
        [cell.contentView addSubview:functionLab];
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W - self.height * 10, (self.height * 2 - 30) / 2, self.height * 8 , 30)];
        
        self.detailLab.text = user_address;
        self.detailLab.textAlignment = NSTextAlignmentRight;
        
        [cell.contentView addSubview:self.detailLab];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        

        
    }
    
    else
    {
    
        [CellUtil fillcolor:cell high:self.height * 8];
        
    }
    
    
    return cell;
    
}

//自定义cell 显示信息

- (void)showCell:(UITableViewCell *)cell functionName:(NSString *)funName detailinfos:(NSString *)infos {

    UILabel *functionLab = [[UILabel alloc]initWithFrame:CGRectMake(15, (self.height * 2 - 30) / 2, 150, 30)];
    functionLab.text = funName;
    
    cell.userInteractionEnabled = NO;
    [cell.contentView addSubview:functionLab];
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W - self.height * 9, (self.height * 2 - 30) / 2, self.height * 8, 30)];
    
    detailLab.text = infos;
    detailLab.textAlignment = NSTextAlignmentRight;
    
    [cell.contentView addSubview:detailLab];
    
}

//设置行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0 || indexPath.row == 7) {
        
        return self.height;
        
    }
    
    else if (indexPath.row == 1) {
    
        return self.height * 3;
    }
    
    else if (indexPath.row == 9) {
    
        return self.height * 8;
        
    }
    
    else
        
    {
        
        return self.height * 2;
    }
    
}

//对所选行进行操作

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 1) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
      
        [actionSheet showInView:self.view];
        
    }
    
   else if (indexPath.row == 6) {
        
        UIStoryboard *storyboard = self.storyboard;
        
        MyCodeViewController *myCodeVC = [storyboard instantiateViewControllerWithIdentifier:@"mycodeID"];
        
        [self.navigationController pushViewController:myCodeVC animated:YES];
        
    }
    
    else if (indexPath.row == 8) {
        
        UIStoryboard *storyboard = self.storyboard;
        
       FamilyAddressViewController *familyAddressVC = [storyboard instantiateViewControllerWithIdentifier:@"familyaddressID"];
        
        [self.navigationController pushViewController:familyAddressVC animated:YES];
        
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //打开拾取器
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }

    else if (buttonIndex == 1) {
    
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate =self;
        imagePicker.allowsEditing =YES;
        imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 1.0);
            
        }
        
        else
        {
        
            data = UIImagePNGRepresentation(image);
        }
        
        NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[documentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
       
        NSString *filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath,@"/image.png"];
        
        self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
        
    }
    
   
    
     [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
    
}





@end
