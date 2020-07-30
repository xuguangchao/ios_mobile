//
//  GC_CategoryVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/7.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CategoryVC.h"
#import "GC_CateSubModel.h"
#import "GC_CateCell.h"

@interface GC_CategoryVC ()<GC_TableViewDelegate>
{
    UILabel *_allCourse;//所有课程标签
}
@property(nonatomic,strong)GC_TableView *table;
@property(nonatomic,strong)NSDictionary *dataDic;

@end

@implementation GC_CategoryVC

- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分类";
    [self createUI];
}

- (void)createUI{
    self.table = [[GC_TableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SIZEWIDTH, SIZEHEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.table];
    _table.url = API_AllCourse;
    _table.cell = [GC_CateCell class];
    _table.isShowHud = YES;
    _table.DXdelegate = self;
    _table.model = [GC_CateSubModel class];
    _table.cellLoadData = ^(UITableViewCell * _Nonnull cell, CommonModel * _Nonnull model) {
        GC_CateCell *cel = (GC_CateCell *)cell;
        GC_CateSubModel *mod = (GC_CateSubModel *)model;
        cel.model = mod;
        cel.selectionStyle = UITableViewCellSelectionStyleNone;
        cel.nextController = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull title) {
            SCLog(@"%@ -----  %@",dic, title);
        };
    };
    [_table loadData];
    [_table closeRefresh];
    
    
    //创建headerview
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 80)];
    header.backgroundColor = Color_background;
    UIImageView *back_image = [[UIImageView alloc]initWithFrame:CGRectMake(6, 6, SIZEWIDTH - 12, 68)];
    back_image.image = [SCToolManager imageWithName:@"分类-全部课程背景" InBundle:@"clssify_image" className:[self class]];
    [header addSubview:back_image];
    
    _allCourse = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZEWIDTH-100, 68)];
    _allCourse.font = NormalFont(30);
    _allCourse.textColor = [UIColor whiteColor];
    [back_image addSubview:_allCourse];
    
    UIImageView *row = [[UIImageView alloc]initWithFrame:CGRectMake(SIZEWIDTH - 46, 22, 24, 24)];
    row.image =  [SCToolManager imageWithName:@"转跳" InBundle:@"clssify_image" className:[self class]];
    [back_image addSubview:row];
    
    _table.tableHeaderView = header;
}

- (void)DXTableDidLoadDataSucess:(NSDictionary *)data currentPage:(NSInteger)page WithTable:(UITableView *)table{
    _dataDic = data;
    _allCourse.text = [NSString stringWithFormat:@"全部课程  %@",data[@"count"]];
}

- (CommonModel *)DXInitModel:(NSInteger)num withModel:(CommonModel *)model{
    GC_CateSubModel *mod = (GC_CateSubModel *)model;
    mod.imageName = @"分类-公共培训课";
    mod.backImageName = @"分类-公共培训课-";
    return model;
}
-(CommonModel *)DXtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath Data:(NSArray *)data{
    if (data.count!= 0) {
        return data[indexPath.section];
    }else{
        return nil;
    }
    
}
- (NSInteger)DXnumberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *arr = _dataDic[@"data"];
    return arr.count;
}

- (CGFloat)DXtableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)DXtableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CommonModel *)DXtableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath Data:(NSArray *)data{
    if (data.count!= 0) {
         return data[indexPath.section];
    }else{
        return nil;
    }
   
}
@end
