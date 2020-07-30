//
//  GC_SearchVC.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/27.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_SearchVC.h"
#import "GC_CourseCell.h"
#import "GC_CourseModel.h"

@interface GC_SearchVC ()<UISearchBarDelegate>

@property(nonatomic,strong)GC_TableView *table;
@property(nonatomic,strong)UISearchBar *searchBar;

@end

@implementation GC_SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    
    [self.view addSubview:self.table];
    _table.autoHeigh = YES;
    _table.bottom_distance = 15;
    _table.url = API_allNewCourse;
    _table.cell = [GC_CourseCell class];
    _table.model = [GC_CourseModel class];
    _table.cellLoadData =^(UITableViewCell *cell,CommonModel *model){
        GC_CourseCell *cel = (GC_CourseCell *)cell;
        GC_CourseModel *mod = (GC_CourseModel *)model;
        cel.model = mod;
    };
    [_table loadData];
}

-(void)setupSearchBar{
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.frame = CGRectMake(30, StatusBar_H, SIZEWIDTH-40, 40);
    self.searchBar.placeholder = @"请输入搜索内容";
    self.searchBar.barTintColor = Color_Main;
    UIImageView *barImageView = [[[self.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = Color_Main.CGColor;
    barImageView.layer.borderWidth = 1;

    [self.navbar addSubview:self.searchBar];
    self.searchBar.delegate = self;

    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:Color_title_white];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = Color_Main.CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _table.request_Model.keyword = searchBar.text;
    _table.request_Model.page = @"1";
    [_table loadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    SCLog(@"%@", searchText);
}

-(GC_TableView *)table{
    if (!_table) {
        _table = [[GC_TableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SIZEWIDTH, SIZEHEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    }
    return _table;
}

@end
