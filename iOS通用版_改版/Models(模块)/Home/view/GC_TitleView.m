//
//  GC_TitleView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/27.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_TitleView.h"
#import "SYButton.h"

@interface GC_TitleView()
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIImageView *bgImg;
@property(nonatomic,strong)SYButton *btn;
@end
@implementation GC_TitleView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andImage:(UIImage *)tImg andBtnT:(NSString *)btnT andBtnImgT:(NSString *)btnImg{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = Color_title_white;
        [self addSubview:self.titleL];
        [self addSubview:self.bgImg];
        [self addSubview:self.btn];
        _bgImg.whc_CenterY(0).whc_LeftSpace(15).whc_Size(20, 20);
        _titleL.whc_CenterY(0).whc_LeftSpaceToView(10, _bgImg).whc_HeightAuto().whc_WidthAuto();
        _btn.whc_RightSpace(10).whc_CenterY(0).whc_HeightAuto().whc_WidthAuto();
        
        _bgImg.image = tImg;
        _titleL.text = title;
        [_btn setTitle:btnT forState:UIControlStateNormal];
        [_btn setImage:Img(btnImg) forState:UIControlStateNormal];
    }
    return self;
}

- (void)btnClick{
    if (self.btnBlock) {
        self.btnBlock();
    }
}

- (SYButton *)btn{
    if (!_btn) {
        _btn = [SYButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:Color_title_black_64 forState:UIControlStateNormal];
        _btn.btnType = RIGHT;
        _btn.titleLabel.font = Fone_title28;
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.font = NormalFont(28);
        _titleL.textColor = Color_title_black_64;
    }
    return _titleL;
}

- (UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [UIImageView new];
    }
    return _bgImg;
}

@end
