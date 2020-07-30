//
//  GC_DetailPlayView.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/30.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLPlayerView.h"

NS_ASSUME_NONNULL_BEGIN
@class GC_DetailPlayView;
@protocol DetailPlayDelegate <NSObject>

- (void)viewWillPlay;
- (void)enterFullScreen;
- (void)exitFullScreen;

@end

@interface GC_DetailPlayView : UIView
@property(nonatomic,weak) id<DetailPlayDelegate> delegate;
@property(nonatomic,strong)PLMediaInfo *media;
@property(nonatomic,strong)PLPlayerView *playerView;

- (void)play;
- (void)stop;
- (void)configureVideo:(BOOL)enableRender;

@end

NS_ASSUME_NONNULL_END
