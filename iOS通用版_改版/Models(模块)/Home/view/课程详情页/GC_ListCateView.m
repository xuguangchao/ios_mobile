//
//  GC_ListCateView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_ListCateView.h"
#import "GC_CourseInfoViewModel.h"
#import "GC_CourseSubModel.h"
#import "GC_CourseDetailModel.h"

@interface GC_ListCateView()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)NSMutableArray *FirstArr;
@end

@implementation GC_ListCateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, frame.size.height) style:UITableViewStyleGrouped];
        self.table.dataSource = self;
        self.table.delegate = self;
        [self addSubview:self.table];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.table.frame = CGRectMake(0, 0, SIZEWIDTH, self.frame.size.height);
}

- (void)setClassState:(ClassStateModel *)classState{
    GC_CourseInfoViewModel *infoModel = [[GC_CourseInfoViewModel alloc]init];
    [infoModel getCourseList:classState.courseInfoModel.kcid Result:^(NSMutableArray * _Nonnull subArr, NSMutableArray * _Nonnull contentArr, BOOL isSucceed, NSString * _Nonnull statusCode) {
        SCLog(@"--- %d ----- %d", subArr.count, contentArr.count);
        self.FirstArr = subArr;
        self.contentArr = contentArr;
        [self.table reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 58;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.contentArr[section];
    return arr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.contentArr[indexPath.section][indexPath.row] isKindOfClass:[GC_CourseDetailModel class]]) {
        if (self.playBlock) {
            self.playBlock(self.contentArr[indexPath.section][indexPath.row]);
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    if ([self.contentArr[indexPath.section][indexPath.row] isKindOfClass:[GC_CourseSubModel class]]) {
        GC_CourseSubModel *subModel = self.contentArr[indexPath.section][indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"    %@", subModel.mlmc];
    }else{
        GC_CourseDetailModel *detailModel = self.contentArr[indexPath.section][indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"        %@", detailModel.nrmc];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZEWIDTH, 58)];
    view.backgroundColor = Color_title_white;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SIZEWIDTH-20, 58)];
    [view addSubview:label];
    label.font = Fone_title30;
    label.textColor = Color_title_black_87;
    label.numberOfLines = 1;
    GC_CourseSubModel *model = self.FirstArr[section];
    label.text = model.mlmc;
    return view;
}

@end
