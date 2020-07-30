//
//  SC_NavBarView.h
//  BOSS-SOOC
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIConstants.h"

@interface SC_NavBarView : UIView

@property (nonatomic, weak) UIViewController *viewCtrlParent;

+(CGRect)rightBtnFrame;
+(CGSize)barBtnSize;
+(CGSize)barSize;

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action;

// 用自定义的按钮和标题替换默认内容
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)strTitle;

// 设置右侧按钮标题
- (void)setRightBtnTitle:(NSString *)strTitle;
-(void)hideLeftButton:(BOOL)hide;
+(UIImage *)imageWithName:(NSString *)name  InBundle:(NSString *)bundle className:(Class)classss;

@property (nonatomic, copy) void(^BackBlock)(void);
- (void)setRightBtns:(NSArray *)btns;


@end
