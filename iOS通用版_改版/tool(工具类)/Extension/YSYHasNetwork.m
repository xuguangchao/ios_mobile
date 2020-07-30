//
//  YSYHasNetwork.m
//  sooc-ios_new
//
//  Created by 许广超 on 2020/3/14.
//  Copyright © 2020 xuguangChao. All rights reserved.
//

//YSYHasNetwork.m
#import "YSYHasNetwork.h"
#import "AFNetworkReachabilityManager.h"

@implementation YSYHasNetwork

+ (void)ysy_hasNetwork:(void(^)(bool has))hasNet
{
//创建网络监听对象
AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusReachableViaWWAN:

                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                break;
        }
    }];
    //结束监听
    [manager stopMonitoring];
}

@end
