//
//  UIColor+SC_Hex.h
//  Catagery
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SC_Hex)

/**
*  RGB生成颜色
*
*  @param red   宏
*  @param green 绿
*  @param blue  蓝
*
*  @return 最终的颜色
*/
+ (UIColor *)sc_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/**
 *  从十六进制字符串获取颜色,默认alpha为1
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @return 最终的颜色
 */
+ (UIColor *)sc_colorWithHexString:(NSString *)color;

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 透明度
 *
 *  @return 最终的颜色
 */
+ (UIColor *)sc_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end
