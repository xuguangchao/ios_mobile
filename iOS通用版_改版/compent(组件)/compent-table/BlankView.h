//
//  BlankView.h
//  dangxiao_new
//
//  Created by 段帅 on 16/9/28.
//  Copyright © 2016年 newfuture. All rights reserved.
// 空白页  全部用一个

#import <UIKit/UIKit.h>

@interface BlankView : UIView




/**
 空白页提示信息
 */
@property (nonatomic,strong) UILabel *label;

/**
 空白页图片
 */
@property (nonatomic,strong) UIImageView *icon;

//-(void)adjustGapWithFrame:(CGRect)frame;//用于笔记和讨论页面的调整
//-(void)adjustGapWithHeight:(CGFloat)height;
@end
