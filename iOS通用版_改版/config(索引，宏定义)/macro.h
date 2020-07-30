//
//  macro.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#ifndef macro_h
#define macro_h

//在release下  nslog被释放
#ifdef DEBUG
#define SCLog(...) NSLog(__VA_ARGS__);
#else
# define SCLog(...);
#endif

#define kIsFirstTimeLogin @"isFirstTimeLogin"//是否第一次登陆

#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)

#define NavBar_Title_Width                  SCREEN_WIDTH - 160.0f - 16.0f           //标题宽度

#define NavBar_Title_Height                 40.0f             //标题高度

#define NavBar_BarButton_Width              40.0f             //按钮宽度
#define NavBar_BarButton_Height             40.0f             //按钮高度

#define NavBar_BarButton_Right_Width        8.0f

#define NaviBar_H                           44.0f

#define StatusBar_H                         [UIApplication sharedApplication].statusBarFrame.size.height    //状态栏的高度


#define SafeAreaTopHeight ([UIApplication sharedApplication].statusBarFrame.size.height+44)


/*底部安全距离*/
#define SC_BottomSafe_Height (CGFloat)(SafeAreaTopHeight > 64?(34.0):(0.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(SafeAreaTopHeight > 64?(83.0):(49.0))


//主色
#define Color_Main [UIColor colorWithRed:242/255.0 green:76/255.0 blue:0/255.0 alpha:1.0f]
#define Color(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0f]
#define hex_color(str) [UIColor sc_colorWithHexString:str]
#define Img(str) [UIImage imageNamed:str]


//文字6种颜色
#define Color_title_black_87 [UIColor colorWithWhite:0.13 alpha:1]
#define Color_title_black_64 [UIColor colorWithWhite:0.36 alpha:1]
#define Color_title_black_46 [UIColor colorWithWhite:0.54 alpha:1]
#define Color_title_black_26 [UIColor colorWithWhite:0.74 alpha:1]

#define Color_title_white [UIColor colorWithWhite:1 alpha:1]
#define Color_title_white70 [UIColor colorWithWhite:1 alpha:0.7]
#define Color_title_white30 [UIColor colorWithWhite:1 alpha:0.3]

#define MESSAGE_CENTER [SCUDUtil sharedInstance]
#define SCRootControl [UIApplication sharedApplication].keyWindow.rootViewController


//成功或者失败的提示
#define SucceedImage [[UIImageView alloc]initWithImage:[SCToolManager imageWithName:@"提示成功" InBundle:@"ToolImage" className:[SCToolManager class]]]
#define FailImage [[UIImageView alloc]initWithImage:[SCToolManager imageWithName:@"提示失败" InBundle:@"ToolImage" className:[SCToolManager class]]]

#define ALERT_SUCESS(string) [[JLActionManager sharedInstance]showHUDWithLabelText:string imageView:nil inView:self.view];
#define ALERT_FAIL(string) [[JLActionManager sharedInstance]showHUDWithLabelText:string imageView:nil inView:self.view];

#define POST_SUCCEED(string) [[JLActionManager sharedInstance]showHUDWithLabelText:string imageView:SucceedImage inView:self.view];
#define POST_FAIL(string) [[JLActionManager sharedInstance]showHUDWithLabelText:string imageView:FailImage inView:self.view];

#define NormalFont(A) [UIFont systemFontOfSize:A/2]
#define Fone_title36 NormalFont(36)
#define Fone_title30 NormalFont(30)
#define Fone_title28 NormalFont(28)
#define Fone_title24 NormalFont(24)

#define LoginSucceed @"loginSucceed"//登录成功通知标识
#define LoginRequest @"Loginrequest" //保存登陆 请求信息  用于自动登录
#define isIOS(a) [[[UIDevice currentDevice]systemVersion] floatValue] == a
#define VideoHeight SIZEWIDTH*9/16
#define Bili 0.383*SCALE6P
/**
 字体-冬青黑体简体
 */
#define HIRAGINOFONT  @"HiraginoSansGB-W3"
#define FONT(A) [UIFont fontWithName:HIRAGINOFONT  size:A]

/**
 保存本地信息
 */
#define MESSAGE_CENTER [SCUDUtil sharedInstance]//用户的token 节点信息


#endif /* macro_h */
