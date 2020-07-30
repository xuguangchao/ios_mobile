//
//  GC_GuidVC.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/22.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_GuidVC : GC_BaseVC

@property (nonatomic, copy) void (^backBlock)();
@property(nonatomic,strong)NSArray *imgArr;

@end

NS_ASSUME_NONNULL_END
