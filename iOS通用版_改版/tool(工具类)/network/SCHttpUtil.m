//
//  SCHttpUtil.m
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//

#import "SCHttpUtil.h"

#import "SCUDUtil.h"

static NSTimeInterval _timeoutInterval = 30;

@implementation SCHttpManager

- (id)init {
    return [self initWithBaseURL:nil];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [self.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        //self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
    }
    return self;
}

- (NSURLSessionDataTask *)doHTTPPost:(SCHttpRequest*)req
                                 start:(HttpConnectStartBlock)startBlock
                               success:(HttpConnectSuccessBlock)successBlock
                               failure:(HttpConnectFailureBlock)failureBlock
                                finish:(HttpConnectFinishBlock)finishBlock{
    
    NSString *xtdz = [SCUDUtil sharedInstance].xtdz;
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php?r=%@/%@",xtdz,req.apiVersion,req.api];
    
    NSLog(@"SCHTTP-url:%@-para:%@",url,req.params);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    if (req.needToken) {
         [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[SCUDUtil sharedInstance].oauth_token] forHTTPHeaderField:@"Authorization"];
          NSLog(@"Authorization:%@",[SCUDUtil sharedInstance].oauth_token);
     }
    [manager POST:url parameters:req.params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SCHttpResponse *resp = [[SCHttpResponse alloc]initWithData:responseObject];
                                                if (successBlock) {
                                                    successBlock(req,resp);
                                                }
                                                if (finishBlock) {
                                                    finishBlock(req,YES);
                                                }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
        
        if (failureBlock) {
                                                        failureBlock(req,error);
                                                    }
                                                    if (finishBlock) {
                                                        finishBlock(req,NO);
                                                    }

    }];
    
    


    if (startBlock) {
        startBlock(req);
    }
    return nil;
    
    
}



- (NSURLSessionDataTask *)doHTTPGet:(SCHttpRequest*)req
                               start:(HttpConnectStartBlock)startBlock
                             success:(HttpConnectSuccessBlock)successBlock
                             failure:(HttpConnectFailureBlock)failureBlock
                              finish:(HttpConnectFinishBlock)finishBlock{
    
    NSString *xtdz = [SCUDUtil sharedInstance].xtdz;
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php?r=%@/%@",xtdz,req.apiVersion,req.api];
    
    NSLog(@"SCHTTP-url:%@-para:%@",url,req.params);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    
    if (req.needToken) {
         [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[SCUDUtil sharedInstance].oauth_token] forHTTPHeaderField:@"Authorization"];
          NSLog(@"Authorization:%@",[SCUDUtil sharedInstance].oauth_token);
     }
       
    [manager GET:url parameters:req.params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SCHttpResponse *resp = [[SCHttpResponse alloc]initWithData:responseObject];
        if (successBlock) {
            successBlock(req,resp);
        }
        if (finishBlock) {
            finishBlock(req,YES);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(req,error);
        }
        if (finishBlock) {
            finishBlock(req,NO);
        }
        
    }];

    
    if (startBlock) {
        startBlock(req);
    }
    return nil;
    
    
}


@end
