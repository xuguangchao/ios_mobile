//
//  ClassStateModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"
#import "GC_CourseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassStateModel : CommonModel
/**
枚举-课程状态

进入课程后会根据属性-detailModel分析出此状态
*/
typedef NS_ENUM(NSInteger, ClassState) {
    ClassStateUnopen = 0,//未开放
    ClassStateKcls,//课程老师
    ClassStateSeleted,//已加入
    ClassStateEncrypt,//加密
    ClassStateUnSelected,//未加入
    ClassStateNewJoin,//新加入，即点击加入按钮之后
    ClassStateisCharge,//是否收费
    ClassStateisAuth//无权限
};

/**
 状态枚举
 */
@property (nonatomic, assign) ClassState ClassState;

@property(nonatomic,strong)GC_CourseInfoModel *courseInfoModel;

/**
 类构造方法

 @param dict 课程详情返回的字典

 @return 类的实例
 */
+(ClassStateModel*)modelWithDict:(NSDictionary*)dict;


/**
 分析课程状态

 @param model 详情model
 */
-(void)analyseStateFromModel:(GC_CourseInfoModel*)model;

@end

NS_ASSUME_NONNULL_END
