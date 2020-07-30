//
//  GC_GuidVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/22.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_GuidVC.h"

@interface GC_GuidVC ()<UIScrollViewDelegate>
{
    UIPageControl  *_pageControl;
    UIScrollView   *_scrollView;
}
@end

@implementation GC_GuidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideNavBar:YES];
    
    //创建scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, SIZEHEIGHT)];
    //设置滚动区域
//    _scrollView.backgroundColor = Color_Main;
    [self.view addSubview:_scrollView];

    //设置分页效果
    _scrollView.pagingEnabled = YES;
    
    _scrollView.scrollEnabled= YES;
//    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SIZEWIDTH-SIZEWIDTH/3)/2, SIZEHEIGHT - 40, SIZEWIDTH/3, 20)];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(handlePageControlChangeAction:) forControlEvents:UIControlEventValueChanged];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
}


- (void)setImgArr:(NSArray *)imgArr{
    
    //设置滚动区域
    _scrollView.contentSize =CGSizeMake(SIZEWIDTH * imgArr.count, SIZEHEIGHT);
    for (int i = 0; i<imgArr.count; i++) {
        UIImageView *guidView = [UIImageView new];
        guidView.userInteractionEnabled = YES;
        guidView.image = [UIImage imageNamed:imgArr[i]];
        guidView.frame = CGRectMake(SIZEWIDTH*i, 0, SIZEWIDTH, SIZEHEIGHT);
        [_scrollView addSubview:guidView];
        if (i == imgArr.count-1) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUIImageViewAction)];
            [guidView addGestureRecognizer:tapGestureRecognizer];
        }
    }
}

-(void)tapUIImageViewAction
{
    if (self.backBlock) {
        self.backBlock();
    }
}

//pagecontrol的响应方法
- (void)handlePageControlChangeAction:(id)sender
{
    
    CGFloat offsetX = _scrollView.bounds.size.width * _pageControl.currentPage;
    
    //根据pagecontrol的当前页数，设置scollview的controffset，显示对应的页面
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
//结束减速时触发(停⽌止时)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前第几页
    CGPoint offset= scrollView.contentOffset;
    NSInteger pageNumber = offset.x /scrollView.bounds.size.width;
    _pageControl.currentPage = pageNumber;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
