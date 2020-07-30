//
//  GC_CateBtn.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CateBtn.h"

@implementation GC_CateBtn

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithNum:(NSString*)num{
    if (self = [super initWithFrame:frame]) {
        
        
        self.frame = frame;

        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
          text.textAlignment = NSTextAlignmentCenter;
        
        if (title.length>20) {
            title = [title substringToIndex:20];
        }
        
        NSString *str1 = [NSString stringWithFormat:@"%@ %@",title,num];
         NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:str1];
        NSRange range1=[str1 rangeOfString:[NSString stringWithFormat:@" %@",num]];
         NSRange range2=[str1 rangeOfString:title];

         [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range1];
        [hintString addAttribute:NSForegroundColorAttributeName value:Color_title_black_64 range:range1];

         [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range2];
        [hintString addAttribute:NSForegroundColorAttributeName value:Color_title_black_87 range:range2];
        text.attributedText = hintString;
        CGSize size = [text sizeThatFits:CGSizeMake(0, 30)];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, size.width+20, 30);
        text.frame = CGRectMake(0, 0, size.width+20, 28);
        
        [self addSubview:text];
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = Color_title_black_26.CGColor;
        self.layer.borderWidth = 0.5;
        [self setBackgroundImage:[UIImage imageNamed:@"点击背景色"] forState:UIControlStateHighlighted];
    }
    return self;
    
}

+(CGFloat)buttonWithtitle:(NSString *)title withNum:(NSString *)num{
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
    text.textAlignment = NSTextAlignmentCenter;
    NSString *str1 = [NSString stringWithFormat:@"%@ %@",title,num];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:str1];
    NSRange range1=[str1 rangeOfString:num];
    NSRange range2=[str1 rangeOfString:title];
    
    [hintString addAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:Color_title_black_64} range:range1];
    [hintString addAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:Color_title_black_87} range:range2];
    
    text.attributedText = hintString;
    CGSize size = [text sizeThatFits:CGSizeMake(0, 30)];
    
    return size.width+20;
    
}


-(void)createUI{
    
    
    
    
    
    
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
