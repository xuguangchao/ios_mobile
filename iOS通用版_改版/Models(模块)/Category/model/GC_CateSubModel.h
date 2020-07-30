//
//  GC_CateSubModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CateSubModel : CommonModel

/**
 专题名称
 */
@property (nonatomic,copy) NSString *xsm;
@property (nonatomic,copy) NSString *yxid;
@property (nonatomic,copy) NSString *pid;

/**
 专题下的分类
 */
@property (nonatomic,strong) NSMutableArray *sub;

/**
 分类图片
 */
@property (nonatomic,copy) NSString *imageName;

/**
 背景图片
 */
@property (nonatomic,copy) NSString *backImageName;
@property (nonatomic,copy) NSString *count;

@end

NS_ASSUME_NONNULL_END
