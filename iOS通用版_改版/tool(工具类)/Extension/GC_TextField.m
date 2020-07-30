//
//  GC_TextField.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/20.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_TextField.h"
#import <WebKit/WebKit.h>

@implementation GC_TextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        _placeHolderNormalColor = Color_title_white70;
        _placeHolderHighlightedColor = Color_title_white70;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}
- (void)textDidChange{
    NSInteger wordCount = self.text.length;
    NSLog(@"%ld",(long)wordCount);
    if (_maxLengthOfText && wordCount >= _maxLengthOfText) {
        self.text = [self.text substringToIndex:_maxLengthOfText];
        if (_textOverLimitBlock) {
            _textOverLimitBlock(_maxLengthOfText);
        }
    }
}

- (void)setPlaceHolderNormalColor:(UIColor *)placeHolderNormalColor {
    _placeHolderNormalColor = placeHolderNormalColor;
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor}];
    }

}

- (void)didBeginEditing {
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderHighlightedColor}];
    }

}

- (void)didEndEditing {
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor}];
    }

}

- (void)setPlaceHolderFontSize:(CGFloat)placeHolderFontSize {
    _placeHolderFontSize = placeHolderFontSize;
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFontSize]}];
    }
}


//控制 placeHolder 的位置，左右缩进
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,
                       self.paddingWith == 0.0f ? KPTextFieldPaddingWidth : self.paddingWith,
                       self.paddingHeight == 0.0f ? KPTextFieldPaddingHeight : self.paddingHeight);
}

// 控制文本的位置，左右缩进
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,
                       self.paddingWith == 0.0f ? KPTextFieldPaddingWidth : self.paddingWith,
                       self.paddingHeight == 0.0f ? KPTextFieldPaddingHeight : self.paddingHeight);
}

- (void)setPaddingWith:(CGFloat)paddingWith {
    _paddingWith = paddingWith;
    [self setNeedsDisplay];
}

- (void)setPaddingHeight:(CGFloat)paddingHeight {
    _paddingHeight = paddingHeight;
    [self setNeedsDisplay];
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    _leftMargin = leftMargin;
    [self setValue:[NSNumber numberWithFloat:leftMargin] forKey:@"paddingLeft"];
}

- (void)setRightMargin:(CGFloat)rightMargin {
    _rightMargin = rightMargin;
    [self setValue:[NSNumber numberWithFloat:rightMargin] forKey:@"paddingRight"];
}


- (void)setClearButtonNormalImageName:(NSString *)clearButtonNormalImageName {
    _clearButtonNormalImageName = clearButtonNormalImageName;
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:clearButtonNormalImageName] forState:UIControlStateNormal];
}

- (void)setClearButtonHighlightedImageName:(NSString *)clearButtonHighlightedImageName {
    _clearButtonHighlightedImageName = clearButtonHighlightedImageName;
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:clearButtonHighlightedImageName] forState:UIControlStateHighlighted];
}

- (void)setBorderWidth:(NSUInteger)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];

    if (_cursorHeight) {
        originalRect.size.height = _cursorHeight;
    }else {
        originalRect.size.height = self.font.lineHeight + 4;
    }
    if (_cursorWidth) {
        originalRect.size.width = _cursorWidth;
    }else {
        originalRect.size.width = 2;
    }

    return originalRect;
}

- (void)textLengthOverLimit:(GC_textFieldLengthOverLimitBlock)block {
    _textOverLimitBlock = block;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return !_forbidPaste;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}

- (void)setPasswordMode:(BOOL)PasswordMode {
    _PasswordMode = PasswordMode;
    if (_PasswordMode) {
        self.placeholder = @"请输入密码";
        self.secureTextEntry = YES;
        self.clearButtonMode = UITextFieldViewModeNever;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"4321"];
        self.rightView = imageView;
        self.rightViewMode = UITextFieldViewModeAlways;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changPasswordMode:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)changPasswordMode:(UITapGestureRecognizer *)tapGesture {
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    _PasswordMode = !_PasswordMode;
    if (!_PasswordMode) {
        self.secureTextEntry = NO;
        imageView.image = [UIImage imageNamed:@"1234"];
    }else if (_PasswordMode) {
        self.secureTextEntry = YES;
        imageView.image = [UIImage imageNamed:@"4321"];
    }
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
