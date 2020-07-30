//
//  RatingView.m
//  MovieTheater
//
//  Created by ios on 15-3-31.
//  Copyright (c) 2015年 文轩阁. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView
{
    UIView *_grayView; // 灰色星星视图
    UIView *_yellowView; // 金色星星视图
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
         [self _initRatingView:frame];
    }
    return self;
}
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
//   
//}


- (void)_initRatingView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    UIImage *grayImage = [UIImage imageNamed:@"评价-课程"];
    UIImage *yellowImage = [UIImage imageNamed:@"评价-课程-pass"];
    
    CGFloat imageWidth = grayImage.size.width;
    CGFloat imageHeight = grayImage.size.height;
    
    //1、创建灰色星星视图
    _grayView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, imageWidth * 5, imageHeight)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    
    [self addSubview:_grayView];
    
    //2、创建金色星星视图
    _yellowView = [[UIView alloc] initWithFrame:_grayView.bounds];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:_yellowView];
    
    
    // 3、修改评分视图的大小
    float scale = self.frame.size.width / _grayView.frame.size.width;
    CGAffineTransform newTransform  = CGAffineTransformMakeScale(scale,scale);
    _yellowView.transform = newTransform;
    _grayView.transform = newTransform;
    
    
    
    //4.设置视图的坐标
    self.frame = _grayView.frame;
    
    _grayView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _yellowView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


- (void)setRating:(float)rating
{
    _rating = rating;
    
    //4、根据评分改变金色星星视图的宽度
    _yellowView.frame = CGRectMake(0, 0, self.frame.size.width* _rating / 10.0, self.frame.size.height);
    
}




@end
