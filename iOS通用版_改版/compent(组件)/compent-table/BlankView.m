//
//  BlankView.m
//  dangxiao_new
//
//  Created by 段帅 on 16/9/28.
//  Copyright © 2016年 newfuture. All rights reserved.
//

#import "BlankView.h"
#define SIZEWIDTH   [[UIScreen mainScreen] bounds].size.width

@interface BlankView ()

@end

@implementation BlankView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        _icon = [[UIImageView alloc]init];
        _icon.image = Img(@"空白页");
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_icon];
        _icon.whc_Center(0, 0).whc_Size(68, 84);
        
        _label = [[UILabel alloc]init];
        _label.font = Fone_title30;
        _label.textColor = Color_title_black_87;
        _label.text = @"暂无课程";
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        self.backgroundColor = Color_background;
        
        _label.whc_CenterX(0).whc_TopSpaceToView(15, _icon).whc_HeightAuto().whc_WidthAuto();
    }
    return self;
    
}

-(void)createUI{
    
    
    
}

//-(void)adjustGapWithFrame:(CGRect)frame{
//    _icon.frame = CGRectMake(SIZEWIDTH/2-30, frame.size.height/2-129/2, 68, 84);
//    _label.frame = CGRectMake(0, CGRectGetMaxY(_icon.frame)+25, SIZEWIDTH, 20);
//}
//-(void)adjustGapWithHeight:(CGFloat)height{
//    _icon.frame = CGRectMake(SIZEWIDTH/2-34, height/2-129/2, 68, 84);
//    _label.frame = CGRectMake(0, CGRectGetMaxY(_icon.frame)+25, SIZEWIDTH, 20);
//}


@end
