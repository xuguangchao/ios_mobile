//
//  GC_CourseSubModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/29.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CourseSubModel : CommonModel

@property (nonatomic,strong) NSString* fid;
@property (nonatomic,strong) NSString* mlcj;
@property (nonatomic,strong) NSString* mlid;
@property (nonatomic,strong) NSString* mllx;
@property (nonatomic,strong) NSString* mlmc;//节名称
@property (nonatomic,strong) NSString* mlsd;
@property (nonatomic,strong) NSString* pxh;
@property (nonatomic,strong) NSArray *sub;
@property (nonatomic,strong) NSArray *content;

@end

NS_ASSUME_NONNULL_END
