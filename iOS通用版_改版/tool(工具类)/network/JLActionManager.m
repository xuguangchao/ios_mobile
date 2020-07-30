//
// Created by Lee on 14-2-25.
// Copyright (c) 2014 Lee. All rights reserved.
//

#import "JLActionManager.h"


@interface JLActionManager () {
    MBProgressHUD *_hud;
}

@end

@implementation JLActionManager

#define kMBProgressHUDLabelFont FONT(14)
#define FONT(A) [UIFont fontWithName:HIRAGINOFONT  size:A]
#define HIRAGINOFONT  @"HiraginoSansGB-W3"



+(instancetype)sharedInstance
{
    static JLActionManager *_sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance=[[self alloc] init];
    });

    return _sharedInstance;
}

//- (void)showAndHideHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.detailsLabelFont=kMBProgressHUDLabelFont;
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = title;
//    hud.detailsLabelText = detail;
//    hud.margin = 10.f;
//    hud.removeFromSuperViewOnHide = YES;// 隐藏时将他从父类上移除
//    [hud hide:YES afterDelay:1];
//}
//
//- (void)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    hud.detailsLabelFont=kMBProgressHUDLabelFont;
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = title;
//    hud.detailsLabelText = detail;
//    hud.margin = 10.f;
//    hud.removeFromSuperViewOnHide = YES;
//}
//
//- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.detailsLabelFont=kMBProgressHUDLabelFont;
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = title;
//    hud.detailsLabelText = detail;
//    hud.margin = 10.f;
//    hud.removeFromSuperViewOnHide = YES;
//    return hud;
//}

- (void)showHUDWithLabelText:(NSString *)text imageView:(UIImageView *)imageView inView:(UIView *)view
{
    _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _hud.detailsLabel.font=kMBProgressHUDLabelFont;
    _hud.customView.contentMode = UIViewContentModeScaleAspectFill;
    _hud.customView=imageView;
    _hud.mode=MBProgressHUDModeCustomView;
    _hud.detailsLabel.text=text;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hideAnimated:YES afterDelay:3];
}
//提示等待
- (void)showHUDLoadWithTitle:(NSString *)title  inView:(UIView *)view{
    _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _hud.detailsLabel.font=kMBProgressHUDLabelFont;
//    hud.mode = MBProgressHUDModeText;
    _hud.label.text = title;
    _hud.margin = 10.f;
   }
-(void)hideHud{
    [_hud setHidden:YES];
}

@end
