//
//  GC_CourseDetailModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/29.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CourseDetailModel : CommonModel


@property (nonatomic,strong) NSString * file;//文件
@property (nonatomic,strong) NSString * ischange;
@property (nonatomic,strong) NSString * mlid;//目录id
@property (nonatomic,strong) NSString * nrid;//内容id
@property (nonatomic,strong) NSString * nrlx;//内容类型
@property (nonatomic,strong) NSString * nrmc;//内容名称
@property (nonatomic,strong) NSString * pmlid;//父目录id

@property (nonatomic,strong) NSString * read;//是否看过 0：未看 1:看过

//new
@property (nonatomic,strong) NSString * pass;//习题是否通过 0：未通过 1：通过

@property (nonatomic,strong) NSString *current_time;//视频上次播放时间
//该素材的节信息
@property (nonatomic, strong) NSString *mlmc;//节名称


@end

NS_ASSUME_NONNULL_END
