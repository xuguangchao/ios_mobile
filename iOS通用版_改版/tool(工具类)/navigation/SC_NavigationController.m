//
//  SC_NavigationController.m
//  BOSS-SOOC
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import "SC_NavigationController.h"

@interface SC_NavigationController ()

@end

@implementation SC_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使导航条有效
    [self setNavigationBarHidden:NO];
    
    // 隐藏导航条，但由于导航条有效，系统的返回按钮页有效，所以可以使用系统的右滑返回手势。
    [self.navigationBar setHidden:YES];

}

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack
{
    self.interactivePopGestureRecognizer.enabled = canDragBack;
}


@end
