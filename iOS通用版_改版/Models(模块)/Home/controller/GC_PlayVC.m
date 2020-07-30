//
//  GC_PlayVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_PlayVC.h"
#import "GC_CourseInfoViewModel.h"
#import "GC_HistoryModel.h"
#import "GC_CourseInfoModel.h"
#import "GC_BottomView.h"
#import "ClassStateModel.h"
#import "GC_DetailPlayView.h"

@interface GC_PlayVC ()<DetailPlayDelegate>
@property(nonatomic,strong)GC_HistoryModel *hisModel;
@property(nonatomic,strong)GC_CourseInfoModel *infoModel;
@property(nonatomic,strong)ClassStateModel *classState;
@property(nonatomic,strong)GC_DetailPlayView *playView;
@property (nonatomic, assign) BOOL isFullScreen;
@end

@implementation GC_PlayVC

- (void)onUIApplication:(BOOL)active{
    if (self.playView) {
        [self.playView configureVideo:active];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navbar setTitle:self.paramDic[@"title"]];
    [self getinfo];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.playView stop];
}

- (void)dealloc{
    self.playView.media = nil;
    [self.playView stop];
}

- (BOOL)prefersStatusBarHidden {
    return self.isFullScreen;
}

- (void)exitFullScreen{
    self.isFullScreen = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillPlay{
    
}

- (void)enterFullScreen{
    self.isFullScreen = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)creatUI:(ClassStateModel *)model{
    self.playView = [[GC_DetailPlayView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SIZEWIDTH, VideoHeight)];
    self.playView.backgroundColor = colordbdbdb;
    self.playView.delegate = self;
    [self.view addSubview:self.playView];
    
    GC_BottomView *bottomView = [[GC_BottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_playView.frame), SIZEWIDTH, SIZEHEIGHT-SafeAreaTopHeight-VideoHeight-SC_BottomSafe_Height)];
    bottomView.stateModel = model;
    bottomView.playBlockView = ^(GC_CourseDetailModel * _Nonnull model) {
        PLMediaInfo *info = [[PLMediaInfo alloc]init];
        info.videoURL = model.file;
        info.current_time = model.current_time.floatValue;
        self.playView.media = info;
        [self.playView play];
    };
    [self.view addSubview:bottomView];
}


- (void)getinfo{
    GC_CourseInfoViewModel *model = [[GC_CourseInfoViewModel alloc]init];
    [model getCourseInfoData:self.paramDic[@"kcid"] Result:^(GC_CourseInfoModel * _Nonnull infoModel, GC_HistoryModel * _Nonnull historyModel, ClassStateModel * _Nonnull stateModel, BOOL isSucceed, NSString * _Nonnull statusCode) {
        if (isSucceed == YES) {
            self.hisModel = historyModel;
            self.infoModel = infoModel;
            self.classState = stateModel;
            [self creatUI:stateModel];
        }else{
           ALERT_FAIL(statusCode);
       }
    }];
}

@end
