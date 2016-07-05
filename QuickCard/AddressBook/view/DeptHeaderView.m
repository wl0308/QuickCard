//
//  DeptHeaderView.m
//  QuickCard
//
//  Created by administrator on 10/14/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "DeptHeaderView.h"
#import "Department.h"

@interface DeptHeaderView ()
@property (nonatomic, weak) UIButton *nameView;
@end

@implementation DeptHeaderView

+ (id)deptHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    DeptHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[DeptHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nameView.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        //设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置按钮的内边距
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置按钮点击事件
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        nameView.imageView.clipsToBounds = NO;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
    }
    return self;
}

/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.nameView.frame = self.bounds;
}

- (void)setDept:(Department *)dept
{
    _dept = dept;
    
    //设置按钮名字（通讯录部门名）
    [self.nameView setTitle:dept.department forState:UIControlStateNormal];
    
    self.nameView.titleLabel.font = [UIFont systemFontOfSize:16];
}

/**
 *  监听组名被点击的事件
 */
- (void)nameViewClick
{
    //修改组模型的标记，状态取反
    self.dept.opened = !self.dept.opened;
    
    //刷新表格
    if ([self.delegate respondsToSelector:@selector(deptHeaderViewDidClickedNameView)])
    {
        [self.delegate deptHeaderViewDidClickedNameView];
    }
}
@end
