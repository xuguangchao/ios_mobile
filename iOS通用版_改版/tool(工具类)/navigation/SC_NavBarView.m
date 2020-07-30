
//
//  SC_NavBarView.m
//  BOSS-SOOC
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import "SC_NavBarView.h"

@interface SC_NavBarView()

@property (nonatomic, strong) UIButton *backBtn;              //返回按钮
@property (nonatomic, strong) UILabel *titleLabel;            //标题
@property (nonatomic, strong) UIButton *leftBtn;              //左侧按钮
@property (nonatomic, strong) UIButton *rightBtn;             //右侧按钮



@end

@implementation SC_NavBarView

+ (CGRect)rightBtnFrame
{

    return CGRectMake((SCREEN_WIDTH - NavBar_BarButton_Width - NavBar_BarButton_Right_Width), StatusBar_H, NavBar_BarButton_Width, NavBar_BarButton_Height);

}

+ (CGSize)barBtnSize
{
    return CGSizeMake(NavBar_BarButton_Width, NavBar_BarButton_Height);
}

+ (CGSize)barSize
{
    return CGSizeMake(SCREEN_WIDTH, StatusBar_H+44);
}

+ (CGRect)titleViewFrame
{
    return CGRectMake(fabs((SCREEN_WIDTH - NavBar_Title_Width)/2), StatusBar_H, NavBar_Title_Width, NavBar_Title_Height);
}


// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [[self class] createImgNaviBarBtnByImgNormal:nil imgHighlight:nil target:target action:action];
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [[self class] label:btn.titleLabel setMinFontSize:14.0f numberOfLines:1];
    
    return btn;
}

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg
                                imgHighlight:(NSString *)strImgHighlight
                                      target:(id)target
                                      action:(SEL)action
{
    return [[self class] createImgNaviBarBtnByImgNormal:strImg
                                           imgHighlight:strImgHighlight
                                            imgSelected:strImgHighlight
                                                 target:target
                                                 action:action];
}


+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg
                                imgHighlight:(NSString *)strImgHighlight
                                 imgSelected:(NSString *)strImgSelected
                                      target:(id)target
                                      action:(SEL)action
{
    UIImage *imgNormal =[SC_NavBarView imageWithName:strImg InBundle:@"navigation" className:[self class]] ;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[SC_NavBarView imageWithName:(strImgHighlight ? strImgHighlight : strImg) InBundle:@"navigation" className:[self class]] forState:UIControlStateHighlighted];
    [btn setImage:[SC_NavBarView imageWithName:(strImgSelected ? strImgSelected : strImg) InBundle:@"navigation" className:[self class]] forState:UIControlStateSelected];
    
    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}


// label设置最小字体大小
+ (void)label:(UILabel *)label setMinFontSize:(CGFloat)minSize numberOfLines:(NSInteger)lines
{
    if (label)
    {
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = minSize/label.font.pointSize;
        
        if ((lines != 1) && ([UIDevice currentDevice].systemVersion.floatValue < 7.0f))
        {
            label.adjustsFontSizeToFitWidth = YES;
        }
        
    }
}


- (void)dealloc
{
    if (_viewCtrlParent) {
        [_viewCtrlParent willMoveToParentViewController:nil];
        [_viewCtrlParent.view removeFromSuperview];
        [_viewCtrlParent removeFromParentViewController];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
    UIImageView *navImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav"]];
    navImg.frame = self.frame;
    [self addSubview:navImg];
    
    
    //线条
    UILabel *lineV = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5)];
    [lineV setBackgroundColor:[UIColor grayColor]];
   // [self addSubview:lineV];
    
    _titleLabel = [[UILabel alloc] initWithFrame:[[self class] titleViewFrame]];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //标题
    [self addSubview:_titleLabel];
    
    
    // 默认左侧显示返回按钮
    _backBtn = [[self class] createImgNaviBarBtnByImgNormal:@"返回icon" imgHighlight:@"返回icon" target:self action:@selector(btnBack:)];
    // 返回按钮
    [self setLeftBtn:_backBtn];
   
   
    
}


- (void)setTitle:(NSString *)strTitle
{
    [_titleLabel setText:strTitle];
}


- (void)setLeftBtn:(UIButton *)btn
{
    if (_leftBtn)
    {
        [_leftBtn removeFromSuperview];
        
        _leftBtn = nil;
    }
    
    _leftBtn = btn;
    
    if (_leftBtn)
    {
        _leftBtn.frame = CGRectMake(0, StatusBar_H, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [self addSubview:_leftBtn];
    }
}

- (void)setRightBtn:(UIButton *)btn
{
    if (_rightBtn)
    {
        [_rightBtn removeFromSuperview];
        _rightBtn = nil;
    }
    
    _rightBtn = btn;
    
    if (_rightBtn)
    {
        _rightBtn.frame = CGRectMake((SCREEN_WIDTH -15-btn.frame.size.width), StatusBar_H+(44-btn.frame.size.height)/2, btn.frame.size.width, btn.frame.size.height);
        [self addSubview:_rightBtn];
    }
}
- (void)setRightBtns:(NSArray *)btns
{
   
    for (int i=0;i<btns.count;i++) {
        UIButton *but = btns[i];
//<<<<<<< HEAD
//        but.frame = CGRectMake((SCREEN_WIDTH - but.frame.size.width - NavBar_BarButton_Right_Width-5)-i*(but.frame.size.width+10), StatusBar_H, but.frame.size.width, but.frame.size.height);
        
//=======
//        but.frame = CGRectMake((SCREEN_WIDTH - but.frame.size.width - NavBar_BarButton_Right_Width-5)-i*(but.frame.size.width+10), StatusBar_H+9, but.frame.size.width, but.frame.size.height);
        but.frame = CGRectMake((SCREEN_WIDTH - NavBar_BarButton_Width*(i+1) - NavBar_BarButton_Right_Width), StatusBar_H, NavBar_BarButton_Width, NavBar_BarButton_Height);
//>>>>>>> 5aa0c1d2ffadb29d75155bf6f6cdf6d4b7f77cc0
        [self addSubview:but];
    }
   
}

// 设置右侧按钮标题
- (void)setRightBtnTitle:(NSString *)strTitle{
    if (_rightBtn)
    {
        [_rightBtn setTitle:strTitle forState:UIControlStateNormal];
    }
}


- (void)btnBack:(id)sender
{
    if (self.viewCtrlParent)
    {
        if (self.BackBlock!=NULL) {
            self.BackBlock();
        }else{
            [self.viewCtrlParent.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        NSLog(@"APP_ASSERT_STOP");
        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
        
    }
}


#pragma mark -
-(void)hideLeftButton:(BOOL)hide{
    _leftBtn.hidden = hide;
}
- (void)hideOriginalBarItem:(BOOL)bIsHide
{
    if (_leftBtn)
    {
        _leftBtn.hidden = bIsHide;
    }
    
    if (_backBtn)
    {
        _backBtn.hidden = bIsHide;
    }
    
    if (_rightBtn)
    {
        _rightBtn.hidden = bIsHide;
    }
    
    if (_titleLabel)
    {
        _titleLabel.hidden = bIsHide;
    }
}

+(UIImage *)imageWithName:(NSString *)name  InBundle:(NSString *)bundle className:(Class)classss{
    NSBundle *bundle1 = [NSBundle bundleForClass:classss];
    NSURL *url = [bundle1 URLForResource:bundle withExtension:@"bundle"];
    if (url == nil) {
        return nil;
    }
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
    
    return image;
    
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

@end
