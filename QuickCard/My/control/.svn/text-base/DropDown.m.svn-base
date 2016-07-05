//
//  DropDown.m
//  QuickCard
//
//  Created by administrator on 15/10/13.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "DropDown.h"

@implementation DropDown

@synthesize tv,tableArray,textField;

- (id)initWithFrame:(CGRect)frame {

    if (frame.size.height < 200) {
        
        frameHeight = 155;
    }
    else
    {
    
        frameHeight = frame.size.height;
        
    }
    
    tabHeight =frameHeight - 30;
    
    frame.size.height = 30.0f;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        showList = NO; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
        tv.delegate =self;
        tv.dataSource =self;
        tv.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:0.5];
        tv.rowHeight = 25;
        tv.scrollEnabled = NO;
        tv.hidden = YES;
        [self addSubview:tv];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect; //设置文本框的边框风格
        textField.font =[UIFont systemFontOfSize:15];
        //textField.keyboardAppearance = YES;
        
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:textField];
        
    }
    
    return self;
    
}
    
- (void)dropdown {

    [textField resignFirstResponder];
    
    if (showList) {
        
        return; //如果下拉列表已显示，什么都不做
    
    }
    
    else
    {
    
        //下拉列表未显示，进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownlist 放在前面 防止下拉框被别的控件遮住
        
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES; //显示下拉框
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabHeight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = frame;
        [UIView commitAnimations];
        
     }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return tableArray.count;
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor =[UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}
    
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 35;
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    textField.text = [tableArray objectAtIndex:[indexPath row]];
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
}
    
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}
    
    
    
    

@end
