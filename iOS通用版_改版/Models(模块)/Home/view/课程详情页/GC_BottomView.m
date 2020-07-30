//
//  GC_BottomView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_BottomView.h"
#import "LXSegmentTitleView.h"
#import "GC_DetailInfoView.h"
#import "GC_ListCateView.h"
#import "GC_DiscussView.h"
#import "GC_NoteView.h"

@interface GC_BottomView()<LXSegmentTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) LXSegmentTitleView *titleView;
@property(nonatomic,strong)GC_DetailInfoView *infoView;
@property(nonatomic,strong)GC_ListCateView *listView;
@property(nonatomic,strong)GC_DiscussView *discussView;
@property(nonatomic,strong)GC_NoteView *noteView;
@property (nonatomic, strong) UIScrollView * bgScroll;

@end

@implementation GC_BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        typeof(self) weakself = self;
        self.titleView = [[LXSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 40)];
        self.titleView.itemMinMargin = 15.f;
        self.titleView.segmentTitles = @[@"详情",@"课程",@"讨论",@"笔记"];
        self.titleView.delegate = self;
        self.titleView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [self addSubview:self.titleView];
        
        self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SIZEWIDTH, frame.size.height-40)];
        self.bgScroll.contentSize = CGSizeMake(SIZEWIDTH*4, 0);
        [self addSubview:self.bgScroll];
        self.bgScroll.delegate = self;
        self.bgScroll.pagingEnabled = YES;
        
        self.infoView = [[GC_DetailInfoView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, self.bgScroll.frame.size.height)];
        [self.bgScroll addSubview:self.infoView];
        
        self.listView = [[GC_ListCateView alloc]initWithFrame:CGRectMake(SIZEWIDTH, 0, SIZEWIDTH, self.bgScroll.frame.size.height)];
        [self.bgScroll addSubview:self.listView];
        self.listView.playBlock = ^(GC_CourseDetailModel * _Nonnull model) {
            if (weakself.playBlockView) {
                weakself.playBlockView(model);
            }
        };
        
        self.discussView = [[GC_DiscussView alloc]initWithFrame:CGRectMake(SIZEWIDTH*2, 0, SIZEWIDTH, self.bgScroll.frame.size.height)];
        [self.bgScroll addSubview:self.discussView];
        
        self.noteView = [[GC_NoteView alloc]initWithFrame:CGRectMake(SIZEWIDTH*3, 0, SIZEWIDTH, self.bgScroll.frame.size.height)];
        [self.bgScroll addSubview:self.noteView];
    }
    return self;
}

- (void)setStateModel:(ClassStateModel *)stateModel{
    _stateModel = stateModel;
    if (stateModel.ClassState == ClassStateKcls || stateModel.ClassState == ClassStateSeleted || stateModel.ClassState == ClassStateEncrypt) {
        [self changeFrame:self.frame.size.height-40];
    }else{
        [self changeFrame:self.frame.size.height-40-44];
    }
    self.listView.classState = stateModel;
    self.titleView.selectedIndex = 1;
    self.bgScroll.contentOffset = CGPointMake(SIZEWIDTH, 0);
}


- (void)changeFrame:(CGFloat)height{
    self.bgScroll.frame = CGRectMake(0, 40, SIZEWIDTH, height);
    self.infoView.frame = CGRectMake(0, 0, SIZEWIDTH, self.bgScroll.frame.size.height);
    self.listView.frame = CGRectMake(SIZEWIDTH, 0, SIZEWIDTH, self.bgScroll.frame.size.height);
    self.discussView.frame = CGRectMake(SIZEWIDTH*2, 0, SIZEWIDTH, self.bgScroll.frame.size.height);
    self.noteView.frame = CGRectMake(SIZEWIDTH*3, 0, SIZEWIDTH, self.bgScroll.frame.size.height);
}

- (void)segmentTitleView:(LXSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    self.bgScroll.contentOffset = CGPointMake(SIZEWIDTH*(selectedIndex), 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger selectedIndx = scrollView.contentOffset.x/SIZEWIDTH;
        SCLog(@"%ld", (long)selectedIndx);
    self.titleView.selectedIndex = selectedIndx;
}


@end
