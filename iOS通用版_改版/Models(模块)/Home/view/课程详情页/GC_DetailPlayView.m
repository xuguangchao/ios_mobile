//
//  GC_DetailPlayView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/30.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_DetailPlayView.h"

@interface GC_DetailPlayView()<PLPlayerViewDelegate>
@property(nonatomic,strong)UIView *playerBgView;
@end

@implementation GC_DetailPlayView

- (void)dealloc {
    [self stop];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.playerBgView = [[UIView alloc] init];
        [self addSubview:self.playerView];

        self.playerView = [[PLPlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, VideoHeight)];
        self.playerView.delegate = self;
        
        UIView *superView = self;
        [superView addSubview:self.playerBgView];
        [self.playerBgView addSubview:self.playerView];
        self.playerView.endPlay = ^{
            NSLog(@"end");
        };
         NSInteger height = [UIScreen mainScreen].bounds.size.width * (9.0 / 16.0 );
        [self.playerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(superView);
//            make.height.equalTo(self.playerBgView.mas_width).multipliedBy(9.0/16.0);
            make.height.equalTo(height);
        }];
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.playerBgView);
        }];
    }
    return self;
}

- (void)setMedia:(PLMediaInfo *)media{
    _media = media;
    self.playerView.media = media;
}
- (void)prepareForReuse {
    [self stop];
}

- (void)play {
    [self.playerView play];
}

- (void)stop {
    [self.playerView stop];
}

- (void)configureVideo:(BOOL)enableRender {
    [self.playerView configureVideo:enableRender];
}

- (void)playerViewEnterFullScreen:(PLPlayerView *)playerView {
    
    UIView *superView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    [self.playerView removeFromSuperview];
    [superView addSubview:self.playerView];
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(superView.mas_height);
        make.height.equalTo(superView.mas_width);
        make.center.equalTo(superView);
    }];
    
    [superView setNeedsUpdateConstraints];
    [superView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [superView layoutIfNeeded];
    }];
    
    [self.delegate enterFullScreen];
}

- (void)playerViewExitFullScreen:(PLPlayerView *)playerView {
    
    [self.playerView removeFromSuperview];
    [self.playerBgView addSubview:self.playerView];
    
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.playerBgView);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self.delegate exitFullScreen];
}

- (void)playerViewWillPlay:(PLPlayerView *)playerView {
    [self.delegate viewWillPlay];
}
@end
