//
//  GC_TitleView.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/27.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GC_TitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andImage:(UIImage *)tImg andBtnT:(NSString *)btnT andBtnImgT:(NSString *)btnImg;

@property (nonatomic, copy) void (^btnBlock)(void);

@end

NS_ASSUME_NONNULL_END
