//
//  GC_CourseInfoViewModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CourseInfoViewModel.h"
#import "GC_CourseSubModel.h"
#import "GC_CourseDetailModel.h"

@implementation GC_CourseInfoViewModel

- (void)getCourseInfoData:(NSString *)courseID Result:(void (^)(GC_CourseInfoModel * _Nonnull, GC_HistoryModel * _Nonnull, ClassStateModel * _Nonnull, BOOL, NSString * _Nonnull))block
    {
     SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_courseInfo params:@{@"kcid":courseID}];
        
        [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
            
        } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
            if (resp.resultcode == 0) {
                GC_CourseInfoModel *model = [[GC_CourseInfoModel alloc]init];
                [model mj_setKeyValues:resp.dictionary];
                
                ClassStateModel *stateModel = [ClassStateModel modelWithDict:resp.dictionary];
                stateModel.courseInfoModel.kcid = courseID;
                
                GC_HistoryModel *hisModel = [[GC_HistoryModel alloc]init];
                [hisModel mj_setKeyValues:model.history];
                
                block(model, hisModel, stateModel, YES, resp.resultMsg);
            }else{
                block(nil, nil, nil, YES, resp.resultMsg);
            }
        } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
            
        } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
            
        }];
}

- (void)getCourseList:(NSString *)courseID Result:(void (^)(NSMutableArray * _Nonnull, NSMutableArray * _Nonnull, BOOL, NSString * _Nonnull))block{

    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_CourseCateList params:@{@"kcid":courseID}];
       
   [[SCToolManager shareInstance]doGETConnect:request start:^(SCHttpRequest * _Nonnull req) {
       
   } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
       if (resp.resultcode == 0) {
           NSMutableArray *subArr = [NSMutableArray array];
           NSMutableArray *detailArr = [NSMutableArray array];
           for (NSDictionary *dic in resp.array) {
               GC_CourseSubModel *subModel = [[GC_CourseSubModel alloc]init];
               [subModel mj_setKeyValues:dic];
               [subArr addObject:subModel];
               for (NSDictionary *secondDic in subModel.sub) {
                   NSMutableArray *contentArr = [NSMutableArray array];
                   GC_CourseSubModel *second = [[GC_CourseSubModel alloc]init];
                   [second mj_setKeyValues:secondDic];
                   [contentArr addObject:second];
                   for (NSDictionary *thirdDic in second.content) {
                       GC_CourseDetailModel *third = [[GC_CourseDetailModel alloc]init];
                       [third mj_setKeyValues:thirdDic];
                       [contentArr addObject:third];
                   }
                   [detailArr addObject:contentArr];
               }
           }
           block(subArr, detailArr, YES, resp.resultMsg);
       }else{
           block(nil, nil, NO, resp.resultMsg);
       }
   } failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
       
   } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
       
   }];
}

@end
