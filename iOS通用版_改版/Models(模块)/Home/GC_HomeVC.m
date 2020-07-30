//
//  GC_HomeVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_HomeVC.h"
#import "JGBannarView.h"
#import "GC_BannerViewModel.h"
#import "GC_CourseCell.h"
#import "GC_CourseModel.h"
#import "GC_TitleView.h"
#import "GC_SearchVC.h"

@interface GC_HomeVC ()<GC_TableViewDelegate>
{
    GC_TableView *_table;
}
@property(nonatomic,strong)NSMutableArray *bannerArr;
@property(nonatomic,strong)GC_BannerViewModel *bannerModel;

@end

@implementation GC_HomeVC

- (NSMutableArray *)bannerArr{
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"首页";
    [self.navbar setTitle:@"首页"];
    
    _table = [[GC_TableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_table];
    _table.whc_LeftSpace(0).whc_TopSpace(SafeAreaTopHeight).whc_RightSpace(0).whc_BottomSpace(0);
    _table.autoHeigh = YES;
    _table.bottom_distance = 15;
    _table.url = API_allNewCourse;
    _table.cell = [GC_CourseCell class];
    _table.model = [GC_CourseModel class];
    _table.loadDataUp = ^{
//        [self creatTableHeader];
    };
    _table.cellLoadData =^(UITableViewCell *cell,CommonModel *model){
        GC_CourseCell *cel = (GC_CourseCell *)cell;
        GC_CourseModel *mod = (GC_CourseModel *)model;
        cel.model = mod;
    };
    _table.DXdelegate = self;
    [_table loadData];
    [self buildHeader];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:Img(@"搜索") forState:UIControlStateNormal];
    [self.navbar setRightBtns:@[btn]];
}
-(void)btnClick{
    [self pushVC:@"GC_SearchVC" andDictionay:nil];
}

- (void)DXTableDidSelectCellWithCellModel:(NSArray *)data Index:(NSIndexPath *)indexPath withTable:(UITableView *)table{
    GC_CourseModel *model = data[indexPath.row];
    [self pushVC:@"GC_PlayVC" andDictionay:@{@"kcid":model.kcid,@"title":model.kcmc}];
}

- (void)buildHeader{

     UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 255)];
     
    JGBannarView *banner = [[JGBannarView alloc] initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 200) viewSize:CGSizeMake(SIZEWIDTH, 200) Type:BannarTypePageControl];
     [self.view addSubview:banner];
     
     [banner imageViewClick:^(JGBannarView * _Nonnull barnerview, NSInteger index) {
         SCLog(@"-------%d", index);
     }];
     
     [tableHeaderView addSubview:banner];
     
     GC_TitleView *titleView = [[GC_TitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(banner.frame)+10, SIZEWIDTH, 45) andTitle:@"全部课程" andImage:Img(@"icon_mycourse") andBtnT:@"课程排序" andBtnImgT:@""];
     [tableHeaderView addSubview:titleView];
     titleView.btnBlock = ^{
         
     };
     
     _bannerModel = [[GC_BannerViewModel alloc]init];
     [_bannerModel getBannerData:^(NSMutableArray * _Nonnull dataArr, BOOL isSucceed, NSString * _Nonnull statusCode) {
         if (isSucceed == NO) {
             ALERT_FAIL(statusCode);
         }else{
             self.bannerArr = dataArr;
             NSMutableArray *imgArr = [NSMutableArray array];
             for (GC_BannerModel *model in dataArr) {
                 [imgArr addObject:model.imageurl];
             }
             banner.items = imgArr.copy;
         }
     }];
    _table.tableHeaderView = tableHeaderView;
}
@end
