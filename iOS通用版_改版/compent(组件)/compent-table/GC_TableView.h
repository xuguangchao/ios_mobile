//
//  GC_TableView.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//
/**
  标准使用方法:
  _table = [[DXTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  _table.url = API_remind_index;
  _table.cell = [My_alertTableViewCell class];
  _table.model = [My_alertModel class];
  _table.autoHeigh = YES;//打开自动计算高度
  _table.bottom_distance = 15;//自动计算高度加上这个数
  _table.cellLoadData = ^(UITableViewCell *cell, CommonModel *model) {
  My_alertTableViewCell *new = (My_alertTableViewCell *)cell;
  My_alertModel *new_mod = (My_alertModel *)model;
  new.model = new_mod;
  new.deleBlock = ^(NSString *tag) {
  //删除
  };
  
  };
  
  [self.view addSubview:_table];
  _table.whc_TopSpace(SafeAreaTopHeight_ddd+5).whc_LeftSpace(7).whc_RightSpace(7).whc_BottomSpace(0);
  self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
  [_table loadData];
  
  _table.didSelectedCell = ^(UITableView *table, NSIndexPath *index) {
  SCLog(@"点击了%ld",index.row);
  };
  
  
  //如果要实现 group 样式。定制下面的代理方法
  -(NSInteger)DXnumberOfSectionsInTableView:(UITableView *)tableView{
  return _table.data.count;
  }
  -(NSInteger)DXtableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 1;
  }
  -(CommonModel *)DXtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath Data:(NSArray *)data{
  
  return data[indexPath.section];
  }
  
  //请求回来的数据格式不是 data对应数组，则使用下面block对接数据源
  dataCallBackBeforeTransModel
  
 //添加自定义参数，使用下面block
  modelSetValueEnd
  */
#define COLOR_TITLE_999999 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

#import <UIKit/UIKit.h>
#import "GC_ParamsRequestModel.h"
#import "BlankView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GC_TableViewDelegate <NSObject>

@optional
/**
 @数据请求成功 回调数据
 */
-(void)DXTableDidLoadDataSucess:(NSDictionary *)data currentPage:(NSInteger)page WithTable:(UITableView *)table;
/**
 @空白页显示
 */
-(void)DXTableShowBlankView:(BOOL)Bool withTabel:(UITableView *)table;
/**
 @点击cell
 */
-(void)DXTableDidSelectCellWithCellModel:(NSArray *)data Index:(NSIndexPath *)indexPath withTable:(UITableView *)table;

/**
 @触摸DXTableview的时候
 */
-(void)DXTouchViewBegain;

/**
 @再给model赋值的时候调用
 */
-(CommonModel *)DXInitModel:(NSInteger)num withModel:(CommonModel *)model;

-(CGFloat)DXtableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
-(CGFloat)DXtableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

-(UIView *)DXtableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)DXtableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (NSInteger)DXtableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)DXnumberOfSectionsInTableView:(UITableView *)tableView;  //默认 返回1
//默认返回_data[index.row]  返回自定义 data 选项
- (CommonModel *)DXtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath Data:(NSArray *)data;

-(CommonModel *)DXtableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath Data:(NSArray *)data;

- (NSString *)DXtableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//请求数据结束
-(void)DXTableDidFinishLoadData;

/**
 tableView滚动代理

 @param tableView <#tableView description#>
 @param num <#num description#>
 */
- (void)DXscrollViewDidScroll:(UIScrollView *)scrollView;                                               // any offset changes
- (void)DXscrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2); // any zoom scale changes

// called on start of dragging (may require some time and or distance to move)
- (void)DXscrollViewWillBeginDragging:(UIScrollView *)scrollView;
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)DXscrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)DXscrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)DXscrollViewWillBeginDecelerating:(UIScrollView *)scrollView;   // called on finger up as we are moving
- (void)DXscrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt

- (void)DXscrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

- (nullable UIView *)DXviewForZoomingInScrollView:(UIScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
- (void)DXscrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2); // called before the scroll view begins zooming its content
- (void)DXscrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale; // scale between minimum and maximum. called after any 'bounce' animations

- (BOOL)DXscrollViewShouldScrollToTop:(UIScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
- (void)DXscrollViewDidScrollToTop:(UIScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top
@end



@interface GC_TableView : UITableView

@property (nonatomic,copy) NSString *url; //请求网址
@property (nonatomic,copy) NSString *url_dele;//删除网址

@property (nonatomic,strong) Class cell;  //cell的类名
@property (nonatomic,strong) Class model; //model的类名
@property (nonatomic, weak)  id<GC_TableViewDelegate> DXdelegate;


@property (nonatomic,strong) GC_ParamsRequestModel *request_Model;//发起请求需要的参数

@property (nonatomic,strong)  BlankView *blankView;  //空白页
@property (nonatomic,strong) NSMutableArray     * data;//数据源

/**
 是否开启自动计算cell高度，前提cell必须用whc布局
 */
@property (nonatomic,assign) BOOL autoHeigh;
/**
 距离底部高度  默认0
 */
@property (nonatomic,assign) CGFloat     bottom_distance;

/**
 @开始加载数据
 */
-(void)loadData;
/**
 @关闭上拉刷新   默认开启
 */
-(void)closeRefresh;




/**
 @将model值传向cell  这是必须实现的block
 */
@property (nonatomic, copy) void (^cellLoadData)(UITableViewCell *cell,CommonModel *model);
/**
 @回调删除的值   左滑删除必须实现的block
 */
@property (nonatomic, copy) NSDictionary* (^cellCanMove)(CommonModel *model);

/**
 @数据源回调block  针对需要对解析回来的数据做特殊处理
 */
@property (nonatomic, copy) NSArray* (^dataCallBack)(NSMutableArray *data);

/**
 @上啦刷新和 下拉加载 走这两个block
 */
@property (nonatomic, copy) void (^loadDataUp)(void);
@property (nonatomic, copy) void (^loadDataDown)(NSInteger page);
/**
 是否显示等待加载  默认不显示
 */
@property (nonatomic,assign) BOOL     isShowHud;

/**
 @model 赋值完成后，加入数组前，例如 想要给model添加一个自定义的属性。
 */
@property (nonatomic, copy) CommonModel* (^modelSetValueEnd)(CommonModel *model);

@end



NS_ASSUME_NONNULL_END
