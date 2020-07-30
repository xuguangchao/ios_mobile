//
//  GC_CateBtn.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GC_CateBtn : UIButton

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithNum:(NSString*)num;


+(CGFloat)buttonWithtitle:(NSString *)title withNum:(NSString *)num;

@end

NS_ASSUME_NONNULL_END
