//
//  SCUIToolHeader.h
//  SC_Tool
//
//  Created by 段帅 on 16/9/2.
//  Copyright © 2016年 段帅. All rights reserved.
//

#ifndef SCUIToolHeader_h
#define SCUIToolHeader_h



#import "SCToolManager.h"

#define SIZEWIDTH   [[UIScreen mainScreen] bounds].size.width
#define SIZEHEIGHT  [[UIScreen mainScreen] bounds].size.height
#define Bili 0.383*SCALE6P
#define SCALE6P (SIZEWIDTH/414)
#define NormalFont(A) [UIFont systemFontOfSize:A/2]
#define Color999999 [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0f]
#define color666666 [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0f]
#define Color333333 [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0f]
#define colordbdbdb [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1.0f]
#define BGC  [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0f]

#define ScaleSize(A) 0.383*A
/**
 
 带RGBA的颜色值
 
 */
#define COLOR(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/**
 *灰色字
 */


#define COLOR_TITLE_A5A5A5 [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1]
#define COLOR_TITLE_999999 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
#define NormalFont(A) [UIFont systemFontOfSize:A/2]
#define Fone_title36 NormalFont(36)
#define Fone_title30 NormalFont(30)
#define Fone_title28 NormalFont(28)
#define Fone_title24 NormalFont(24)


//主色
#define Color_Main [UIColor colorWithRed:245/255.0 green:49/255.0 blue:41/255.0 alpha:1.0f]
//按钮高亮染色
#define Color_back_high  [UIColor colorWithRed:245/255.0 green:49/255.0 blue:41/255.0 alpha:1.0f]
//辅色
#define Color_ffea00 [UIColor colorWithRed:255/255.0 green:234/255.0 blue:0/255.0 alpha:1.0f]
//文字6种颜色
#define Color_title_black_87 [UIColor colorWithWhite:0.13 alpha:1]
#define Color_title_black_64 [UIColor colorWithWhite:0.36 alpha:1]
#define Color_title_black_26 [UIColor colorWithWhite:0.74 alpha:1]

#define Color_title_white [UIColor colorWithWhite:1 alpha:1]
#define Color_title_white70 [UIColor colorWithWhite:1 alpha:0.7]
#define Color_title_white30 [UIColor colorWithWhite:1 alpha:0.3]

//分割线颜色 背景色
#define Color_line [UIColor colorWithWhite:0.88 alpha:1]
//空白页  table的背景颜色
#define Color_background [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
//禁用状态背景颜色
#define Colord_back_band [UIColor colorWithRed:211.0/255 green:211.0/255 blue:211.0/255 alpha:1.0f]



#endif /* SCUIToolHeader_h */
