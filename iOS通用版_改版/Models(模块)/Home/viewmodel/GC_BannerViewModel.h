//
//  GC_BannerViewModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/26.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_BannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_BannerViewModel : NSObject


/**
 获取banner数据
 */
- (void)getBannerData:(void(^)(NSMutableArray *dataArr,BOOL isSucceed, NSString *statusCode))block;

@end

NS_ASSUME_NONNULL_END
