//
//  GC_BannerViewModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/26.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_BannerViewModel.h"
@interface GC_BannerViewModel()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
@implementation GC_BannerViewModel

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)getBannerData:(void (^)(NSMutableArray * _Nonnull, BOOL, NSString * _Nonnull))block
{
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_lunboImage params:nil];
    
    [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        [self.dataArr removeAllObjects];
        if (resp.resultcode == 0) {
            for (NSDictionary *dic in resp.array) {
                GC_BannerModel *model = [[GC_BannerModel alloc]init];
                [model mj_setKeyValues:dic];
                [self.dataArr addObject:model];
            }
            block(self.dataArr, YES, resp.resultMsg);
        }else{
            block(@[].mutableCopy, NO, resp.resultMsg);
        }
    } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        
    } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        
    }];
}

@end
