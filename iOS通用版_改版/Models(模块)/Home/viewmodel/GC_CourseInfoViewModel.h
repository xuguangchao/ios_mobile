//
//  GC_CourseInfoViewModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_CourseInfoModel.h"
#import "GC_HistoryModel.h"
#import "ClassStateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CourseInfoViewModel : NSObject
/**
 获取课程详情数据
 */
- (void)getCourseInfoData:(NSString *)courseID Result:(void(^)(GC_CourseInfoModel *infoModel,GC_HistoryModel *historyModel, ClassStateModel *stateModel,BOOL isSucceed, NSString *statusCode))block;

/**
 获取课程列表
 */
- (void)getCourseList:(NSString *)courseID Result:(void(^)(NSMutableArray *subArr, NSMutableArray *contentArr,BOOL isSucceed, NSString *statusCode))block;


@end

NS_ASSUME_NONNULL_END
