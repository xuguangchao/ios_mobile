//
//  CommonModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonModel :JSONModel

+(instancetype)shareInstance;

@property (nonatomic,assign) BOOL     isFirst;

/**
 *cell的row
 */
@property (nonatomic,assign) NSInteger ds_rowNum;

@property (nonatomic,assign) CGFloat cellHigh;

/**
 *将model转化为字典
 */
- (NSDictionary *)modelTransToDic;

@end

NS_ASSUME_NONNULL_END
