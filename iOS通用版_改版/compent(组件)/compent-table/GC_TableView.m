//
//  GC_TableView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_TableView.h"

@interface GC_TableView ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSInteger _currentPage;
}


@end

@implementation GC_TableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        _currentPage = 1;
        _data = [NSMutableArray array];
        _autoHeigh = NO;
        _request_Model = [[GC_ParamsRequestModel alloc]init];
            _request_Model.page = [NSString stringWithFormat:@"%ld",_currentPage];
        _request_Model.pageNo = [NSString stringWithFormat:@"%ld",_currentPage];

        _blankView = [[BlankView alloc]initWithFrame:self.bounds];
        
        _blankView.hidden = YES;
        [self addSubview:_blankView];
        self.backgroundColor = Color_background;
     //   _request_Model.pageCount = @"10";
        
        [self setupRefresh];
    }
    return self;
}


#pragma mark - ------加载数据
-(void)loadData{
    
    if (self.url == nil || self.cell == nil || self.model == nil) {
        return ;
    }

    if ([_request_Model.page intValue] == 1 || [_request_Model.pageNo intValue]==1 || [_request_Model.p intValue]==1) {
        _currentPage = 1;
        [_data removeAllObjects];
    }
    
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:self.url params:[_request_Model modelTransToDic]];
    [[SCToolManager shareInstance] doPOSTConnect:request start:^(SCHttpRequest * _Nonnull req) {
        if (_isShowHud) {
             [MBProgressHUD showHUDAddedTo:self animated:YES];
        }
        
       
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        
        if ([self.DXdelegate respondsToSelector:@selector(DXTableDidLoadDataSucess:currentPage:WithTable:)]) {
            [self.DXdelegate DXTableDidLoadDataSucess:resp.originalDictionary currentPage:_currentPage WithTable:self];
        }

        
        if (resp.array.count == 0) {
            if (_data.count ==0) {
                //空白页
                if ([self.DXdelegate respondsToSelector:@selector(DXTableShowBlankView:withTabel:)]) {
                    [self.DXdelegate DXTableShowBlankView:YES withTabel:self];                }else{
                        
                        _blankView.hidden = NO;
                        [self.mj_footer endRefreshingWithNoMoreData];
                    }

              
            }else{
                //没有更多
                [self.mj_footer endRefreshingWithNoMoreData];
                if ([self.DXdelegate respondsToSelector:@selector(DXTableShowBlankView:withTabel:)]) {
                    [self.DXdelegate DXTableShowBlankView:NO withTabel:self];
               }

                              }
            
        }else{
            _blankView.hidden = YES;
            NSInteger count_data = self->_data.count;
            for (int i = 0;i<resp.array.count;i++) {
                NSDictionary *item = resp.array[i];
            CommonModel *mod = [[self.model alloc]init];
            
            [mod setValuesForKeysWithDictionary:item];
            if ([self.DXdelegate respondsToSelector:@selector(DXInitModel:withModel:)]) {
               mod =  [self.DXdelegate DXInitModel:i withModel:mod];
            }
            mod.ds_rowNum = i+count_data;
            if (self.modelSetValueEnd) {
                [self->_data addObject:self.modelSetValueEnd(mod)];
            }else{
                [self->_data addObject:mod];
            }
        }
        
            if ([self.DXdelegate respondsToSelector:@selector(DXTableShowBlankView:withTabel:)]) {
                 [self.DXdelegate DXTableShowBlankView:NO withTabel:self];
            }
              
            [self.mj_footer endRefreshing];
            
            
            if (resp.array.count<10) {
                  [self.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
               
        if (self.dataCallBack != NULL) {
            _data = [NSMutableArray arrayWithArray:self.dataCallBack(_data)];
        }
        
        
        [self reloadData];
      
        
      
        [self.mj_header endRefreshing];
        
    } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        
    } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        if ([self.DXdelegate respondsToSelector:@selector(DXTableDidFinishLoadData)]) {
            [self.DXdelegate DXTableDidFinishLoadData];
        }
    }];
    
    
    
    
}
#pragma mark - ------tableview的代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.autoHeigh) {
        return [self.cell whc_CellHeightForIndexPath:indexPath tableView:tableView]+self.bottom_distance;
    }else if ([self.DXdelegate respondsToSelector:@selector(DXtableView:heightForRowAtIndexPath:Data:)]) {
        CommonModel *model = [self.DXdelegate DXtableView:tableView heightForRowAtIndexPath:indexPath Data:_data];
        return model.cellHigh;
    }else{
        if (_data.count == 0) {
            return 0;
        }else{
            CommonModel *model = [_data objectAtIndex:indexPath.row];
            return model.cellHigh;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:viewForHeaderInSection:)]) {
         return [self.DXdelegate DXtableView:tableView viewForHeaderInSection:section];
    }else{
        return [[UIView alloc]init];
        
    }
    
   
    
    
}
- (UIView *)DXtableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:viewForFooterInSection:)]) {
        return [self.DXdelegate DXtableView:tableView viewForFooterInSection:section];
    }else{
        return [[UIView alloc]init];
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:heightForHeaderInSection:)]) {
         return [self.DXdelegate DXtableView:tableView heightForHeaderInSection:section];
    }else{
        
        return 0.01;
    }
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:heightForFooterInSection:)]) {
         return [self.DXdelegate DXtableView:tableView heightForFooterInSection:section];
    }else{
        return 0.01;
        
    }
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.DXdelegate respondsToSelector:@selector(DXnumberOfSectionsInTableView:)]) {
        return [self.DXdelegate DXnumberOfSectionsInTableView:tableView];
    }else{
        
        return 1;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:numberOfRowsInSection:)]) {
        return [self.DXdelegate DXtableView:tableView numberOfRowsInSection:section];
    }else{
        
        return _data.count;

    }

    
      
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
       
        cell = [[self.cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
       
    }
    
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:cellForRowAtIndexPath:Data:)]) {
      
        self.cellLoadData(cell,[self.DXdelegate DXtableView:tableView cellForRowAtIndexPath:indexPath Data:_data]);
      
        
    }else{
        if (_data.count !=0) {
            
        
        if (self.cellLoadData != NULL) {
             self.cellLoadData(cell,_data[indexPath.row]);
        }
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DXModel *mod = _data[indexPath.row];
    
    if ([self.DXdelegate respondsToSelector:@selector(DXTableDidSelectCellWithCellModel:Index:withTable:)]) {
        
         [self.DXdelegate DXTableDidSelectCellWithCellModel:_data Index:indexPath withTable:self];
    }
    
   
    
}


#pragma mark - ------下拉刷新
-(void)setupRefresh{
    

    
    
    MJRefreshNormalHeader *heard  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        _currentPage = 1 ;
        _request_Model.page = @"1";
        _request_Model.pageNo =@"1";
        _request_Model.p =@"1";
        [self loadData];
        if (self.loadDataUp) {
            self.loadDataUp();
        }
        
    }];
    heard.stateLabel.textColor = COLOR_TITLE_999999;
    heard.lastUpdatedTimeLabel.textColor = COLOR_TITLE_999999;
    
    self.mj_header = heard;
    MJRefreshAutoNormalFooter *foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self.mj_footer beginRefreshing];
        _currentPage++;
        _request_Model.page = [NSString stringWithFormat:@"%ld",(long)_currentPage];
        _request_Model.pageNo = [NSString stringWithFormat:@"%ld",(long)_currentPage];
        _request_Model.p = [NSString stringWithFormat:@"%ld",(long)_currentPage];

        [self loadData];
        
        if (self.loadDataDown) {
            self.loadDataDown(_currentPage);
        }
        
    }];
    foot.stateLabel.textColor = COLOR_TITLE_999999;
    self.mj_footer = foot;
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    if ([self.DXdelegate respondsToSelector:@selector(DXTouchViewBegain)]) {
         [self.DXdelegate DXTouchViewBegain];
    }
    
   
}




-(void)closeRefresh{
    
    self.mj_header = nil;
    self.mj_footer = nil;
    
    
}

#pragma mark - ------滑动删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (self.url_dele) {
        return UITableViewCellEditingStyleDelete;

    }else{
        return  UITableViewCellEditingStyleNone;
        
    }
        
          
    
    
}




- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXtableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.DXdelegate DXtableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        [self deleData:indexPath];
        
    }
    
    
    
}





-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.url_dele) {
          return YES;
    }else{
        return NO;
    }
  
    
}

-(void)deleData:(NSIndexPath *)indexPath{
    
    CommonModel *model = _data[indexPath.row];
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.cellCanMove != NULL) {
          dic = self.cellCanMove(model);
    }
  
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:self.url_dele params:dic];
    [[SCToolManager shareInstance]doPOSTConnect:request start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        
        if (resp.resultcode == 0) {
           
            
            [[JLActionManager sharedInstance]showHUDWithLabelText:@"删除成功" imageView:SucceedImage inView:self];
            
            
            [_data removeObjectAtIndex:indexPath.row];
            [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if (_data.count == 0) {
                if ([self.DXdelegate respondsToSelector:@selector(DXTableShowBlankView:withTabel:)]) {
                    [self.DXdelegate DXTableShowBlankView:YES withTabel:self];                }else{
                        
                        _blankView.hidden = NO;
                       
                    }
            }

            
            
            
        }else{
           
             [[JLActionManager sharedInstance]showHUDWithLabelText:resp.resultMsg imageView:FailImage inView:self];
        }
        
        
    } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        
    } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        
    }];
    
    
    
    
    
    
}


-(BOOL)isShowHud{
    
    if (!_isShowHud) {
        _isShowHud = NO;
    }
    
    return _isShowHud;
}


#pragma mark - ------scroll代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXscrollViewDidScroll:)]) {
        [self.DXdelegate DXscrollViewDidScroll:scrollView];
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if ([self.DXdelegate respondsToSelector:@selector(DXTouchViewBegain)]) {
        [self.DXdelegate DXTouchViewBegain];
    }
    if ([self.DXdelegate respondsToSelector:@selector(DXscrollViewWillBeginDragging:)]) {
        [self.DXdelegate DXscrollViewWillBeginDragging:scrollView];
    }
    
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([self.DXdelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.DXdelegate DXscrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }

    
    
}

@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
