//
//  GC_BaseVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_BaseVC.h"
#import "SC_NavigationController.h"

@interface GC_BaseVC ()

@end

@implementation GC_BaseVC


- (void)dealloc
{
    if (self)
    {
        //取消延迟执行
        [[GC_BaseVC class] cancelPreviousPerformRequestsWithTarget:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SC_NavBarView *navbar = [[SC_NavBarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [SC_NavBarView barSize].width, [SC_NavBarView barSize].height)];
    _navbar = navbar;
    _navbar.viewCtrlParent = self;
    [self.view addSubview:_navbar];
    //
    [self navigationCanDragBack:YES];
    
    //设置导航栏背景颜色
    [self setNabbarBackgroundColor:Color_Main];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    //TODO:
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self setNavBarLeftBtn:nil];
        }
    }
}

//TODO:
-(void)setTitle:(NSString *)title{
    if ([title isKindOfClass:[NSString class]]) {
        [super setTitle:title];
        
        [self setNavBarTitle:title];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_navbar && !_navbar.hidden)
    {
        [self.view bringSubviewToFront:_navbar];
    }
    
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            self.tabBarController.tabBar.hidden =NO;
        }else{
             self.tabBarController.tabBar.hidden =YES;
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
- (void)bringNavBarToTopmost
{
    if (_navbar)
    {
        [self.view bringSubviewToFront:_navbar];
    }
}


// 设置NavBarView 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color
{
    if (_navbar) {
        [_navbar setBackgroundColor:color];
    }
}

// 设置nav背景
- (void)setNavBarBackImage:(UIImage *)image
{
    if (_navbar)
    {
        
    }
}

- (void)hideNavBar:(BOOL)bIsHide
{
    _navbar.hidden = bIsHide;
}

- (void)setNavBarTitle:(NSString *)strTitle
{
    if (_navbar)
    {
        [_navbar setTitle:strTitle];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        //        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}


- (void)setNavBarLeftBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setLeftBtn:btn];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        //        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}

- (void)setNavBarRightBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setRightBtn:btn];
    }
}



- (void)setNavBarRightBtn1:(UIButton *)btn1 andBut2:(UIButton *)but2{
    if (_navbar)
    {
        [_navbar setRightBtns:@[btn1,but2]];
    }
}




// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack
{
    if (self.navigationController)
    {
        if ([self.navigationController isKindOfClass:[SC_NavigationController class]]) {
            [((SC_NavigationController *)(self.navigationController)) navigationCanDragBack:canDragBack];
        }
        
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

- (void)pushVC:(NSString *)className andDictionay:(NSDictionary *)params{
    Class class = NSClassFromString(className);
    GC_BaseVC *vc = [[class alloc]init];
    vc.paramDic = params;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)createNaviUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 27, 27);
    [button setBackgroundImage:[UIImage imageNamed:@"导航栏-返回"] forState: UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.hidesBackButton = YES;
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
