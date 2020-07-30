//
//  GC_BaseVC.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHC_AutoLayout.h"
#import "SC_NavBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_BaseVC : UIViewController

@property (nonatomic, weak) SC_NavBarView *navbar;

// 设置导航栏在最上层
- (void)bringNavBarToTopmost;

// 是否隐藏导航栏
- (void)hideNavBar:(BOOL)bIsHide;

// 设置NavBarView 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color;

// 设置标题
- (void)setNavBarTitle:(NSString *)strTitle;

// 设置导航栏左按钮
- (void)setNavBarLeftBtn:(UIButton *)btn;

// 设置导航栏右按钮
- (void)setNavBarRightBtn:(UIButton *)btn;

// 设置导航栏右按钮
- (void)setNavBarRightBtn1:(UIButton *)btn1 andBut2:(UIButton *)but2;

// 字典转json字符串方法
-(NSString *)convertToJsonData:(NSDictionary *)dict;

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack;

- (void)pushVC:(NSString *)className andDictionay:(NSDictionary *)params;

//引导页block
@property (nonatomic, copy) void (^firstViewController)(void);

//===========《缓存区》========
//课程信息
@property (nonatomic, strong) NSDictionary *info;

- (UIImage *)imageWithColor:(UIColor *)color;

-(void)createNaviUI;

@property(nonatomic,strong)NSDictionary *paramDic;

@end

NS_ASSUME_NONNULL_END
