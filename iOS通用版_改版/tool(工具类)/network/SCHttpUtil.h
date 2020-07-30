//
//  SCHttpUtil.h
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//  网络请求类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SCHttpRequest.h"
#import "SCHttpResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^HttpConnectStartBlock)(SCHttpRequest* req);
typedef void (^HttpConnectFinishBlock)(SCHttpRequest* req, BOOL success);
typedef void (^HttpConnectSuccessBlock)(SCHttpRequest* req, SCHttpResponse* resp);
typedef void (^HttpConnectFailureBlock)(SCHttpRequest* req, NSError* error);

@interface SCHttpManager : AFHTTPSessionManager

- (NSURLSessionDataTask *)doHTTPPost:(SCHttpRequest*)req
                                 start:(HttpConnectStartBlock)startBlock
                               success:(HttpConnectSuccessBlock)successBlock
                               failure:(HttpConnectFailureBlock)failureBlock
                                finish:(HttpConnectFinishBlock)finishBlock;
- (NSURLSessionDataTask *)doHTTPGet:(SCHttpRequest*)req
                              start:(HttpConnectStartBlock)startBlock
                            success:(HttpConnectSuccessBlock)successBlock
                            failure:(HttpConnectFailureBlock)failureBlock
                             finish:(HttpConnectFinishBlock)finishBlock;
@end
NS_ASSUME_NONNULL_END
