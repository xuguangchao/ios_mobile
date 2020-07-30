//
//  LoadFaildView.m
//  BOSS-SOOC
//
//  Created by 段帅 on 16/10/22.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import "LoadFaildView.h"
#import "SCToolManager.h"
#import "SCUIToolHeader.h"
#define SIZEWIDTH   [[UIScreen mainScreen] bounds].size.width
#define SIZEHEIGHT  [[UIScreen mainScreen] bounds].size.height
#define NormalFont(A) [UIFont systemFontOfSize:A/2]
#define Color_title_black_26 [UIColor colorWithWhite:0.74 alpha:1]
#define Color_background [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]

#define Color_High [UIColor colorWithRed:226/255.0 green:45/255.0 blue:37/255.0 alpha:1]
#define Color_normal [UIColor colorWithRed:245/255.0 green:49/255.0 blue:41/255.0 alpha:1]
@implementation LoadFaildView



+(instancetype)shareInstance{
    
    static LoadFaildView *sharedAccountManagerInstance = nil;  
    static dispatch_once_t predicate;  
    dispatch_once(&predicate, ^{  
        sharedAccountManagerInstance = [[self alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];   
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 64)];
        backView.backgroundColor = Color_Main;
        [sharedAccountManagerInstance addSubview:backView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SIZEWIDTH, 44)];

        label.font = [UIFont systemFontOfSize:18];
        label.text = @"提示";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [backView addSubview:label];
       
        
    });  
//    LoadFaildView *sharedAccountManagerInstance = [[LoadFaildView alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64)];
    return sharedAccountManagerInstance;  
    
    
    
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
    
    
    
    
}
-(void)createUI{
    
    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(SIZEWIDTH/2-48, SIZEHEIGHT/3, 96, 88)];
    iconImage.image = [SCToolManager imageWithName:@"空白页-网络连接失败" InBundle:@"ToolImage" className:[self class]];
    [self addSubview:iconImage];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImage.frame)+25, SIZEWIDTH, 20)];
    label.font = NormalFont(36);
    label.textColor = Color_title_black_26;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"网络连接失败,请重试"; 
    [self addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SIZEWIDTH/2-75, CGRectGetMaxY(label.frame)+20, 150, 40);
    [button setTitle:@"重试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:Color_Main] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:Color_Main] forState:UIControlStateHighlighted];
    
    
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    [self addSubview:button];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.backgroundColor = Color_background;
    //初始化请求队列
    _request_queue = [NSMutableArray array];
    
    
    
    
}
-(void)clickButton{
    if (_reloadRequest) {
        self.reloadRequest();
    }
    
    
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
