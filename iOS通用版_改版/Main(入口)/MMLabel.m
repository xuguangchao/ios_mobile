//
//  MMLabel.m
//  MMLabel
//
//  Created by 鸟不拉屎大王 on 15/11/22.
//  Copyright © 2015年 com.iScarlett.com. All rights reserved.
//

#import "MMLabel.h"

@implementation MMLabel
@synthesize keyWordColor=_keyWordColor,keyWord=_keyWord,keyWordFont=_keyWordFont;






-(void)renderKeyWord
{
    if(!super.text||[super.text isEqualToString:@""])
        return;
    NSRange range = [super.text rangeOfString:_keyWord];
    if(range.location == NSNotFound)
        return;
    else
    {
        NSMutableArray *rangeArray=[NSMutableArray new];
        NSString *tmpString=super.text;
        [self searchRange:tmpString withStoreArray:rangeArray andStartIndex:0];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:super.text];
        for (NSValue *value in rangeArray) {
            NSRange keyRange = [value rangeValue];
            [attributeString addAttribute:NSForegroundColorAttributeName value:self.keyWordColor range:keyRange];
            [attributeString addAttribute:NSFontAttributeName value:self.keyWordFont range:keyRange];
        }
        self.attributedText=attributeString;
    }
}

-(void)searchRange:(NSString *)sourceString withStoreArray:(NSMutableArray *)storeArray andStartIndex:(NSInteger)startIndex
{
     NSRange tmpRange=[sourceString rangeOfString:_keyWord];
    if(tmpRange.location!=NSNotFound)
    {
      NSValue *value = [NSValue valueWithRange:NSMakeRange(tmpRange.location+startIndex, tmpRange.length)];
      [storeArray addObject:value];
        sourceString=[sourceString substringFromIndex:tmpRange.location+tmpRange.length];
        startIndex=tmpRange.location+tmpRange.length+startIndex;
        [self searchRange:sourceString withStoreArray:storeArray andStartIndex:startIndex];
    }
}

#pragma getObject

-(NSString *)keyWord
{
    return _keyWord;
}

-(UIFont *)keyWordFont
{
    if(_keyWordFont)
        return _keyWordFont;
    else return super.font;
}

-(UIColor *)keyWordColor
{
    if(_keyWordColor)
        return _keyWordColor;
    else return super.textColor;
}

- (CGFloat)labelWithText:(NSString *)text andNum:(NSInteger)number{
    
    
    self.text = text;
    self.numberOfLines = number;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,text.length)];
    
    self.attributedText = attributedString;
    //调节高度
    CGSize sizes = CGSizeMake(self.frame.size.width, 0);
    
    CGSize labelSize = [self sizeThatFits:sizes];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, labelSize.height);
    
    return labelSize.height;
}


#pragma setObject
-(void)setKeyWordColor:(UIColor *)keyWordColor
{
    _keyWordColor=keyWordColor;
    [self renderKeyWord];
}

-(void)setLineHight:(CGFloat)high{
    
    NSMutableAttributedString *attribute = self.attributedText;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:high];
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,attribute.length)];
    self.attributedText = attribute;
    
    
}

-(void)setText:(NSString *)text
{
    super.text=text;
}

-(void)setKeyWord:(NSString *)keyWord
{
    _keyWord=keyWord;
    [self renderKeyWord];
}





@end
