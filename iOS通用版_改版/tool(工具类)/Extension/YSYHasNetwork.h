//
//  YSYHasNetwork.h
//  sooc-ios_new
//
//  Created by 许广超 on 2020/3/14.
//  Copyright © 2020 xuguangChao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSYHasNetwork : NSObject

+ (void)ysy_hasNetwork:(void(^)(bool has))hasNet;

@end

NS_ASSUME_NONNULL_END
