//
//  SCHttpRequest.m
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//

#import "SCHttpRequest.h"
#import "SCAPI.h"
#import "SCUDUtil.h"
@implementation SCHttpRequest

/**
 * 初始化请求类
 *
 * @param api api
 */
- (instancetype)initWithApi:(NSString *)api{
    self = [super init];
    
    if (self) {
        self.api = api;
        self.apiVersion = API_VERSION_BASE;
        self.needToken = YES;
    }
    return self;
}
/**
 * 初始化请求类
 *
 * @param api api
 * @param params 参数数组
 */
- (instancetype)initWithApi:(NSString *)api
                     params:(NSDictionary*)params{
    
    self = [super init];
    
    if (self) {
        self.api = api;
        self.apiVersion = API_VERSION_BASE;
        self.params = [NSMutableDictionary dictionaryWithDictionary:params];
        self.needToken = YES;
    }
    return self;
}
/**
 * 初始化请求类
 *
 * @param api api
 * @param apiVersion API的版本号
 * @param params 参数数组
 */
- (instancetype)initWithApi:(NSString *)api
                    version:(NSString *)apiVersion
                     params:(NSDictionary *)params{
    
    self = [super init];
    
    if (self) {
        self.api = api;
        self.apiVersion = apiVersion;
        self.params = [NSMutableDictionary dictionaryWithDictionary:params];
        self.needToken = YES;
    }
    return self;
}

/**
 * 初始化请求类
 *
 * @param api api
 * @param apiVersion API的版本号
 * @param params 参数数组
 * @param
 */
- (instancetype)initWithApi:(NSString *)api
                    version:(NSString *)apiVersion
                     params:(NSDictionary *)params
                  needToken:(BOOL)isNeed{
    
    self = [super init];
    
    if (self) {
        self.api = api;
        self.apiVersion = apiVersion;
        self.params = [NSMutableDictionary dictionaryWithDictionary:params];
        self.needToken = isNeed;
    }
    
    return self;
    
}

/**
 * 添加请求参数
 *
 * @param api api
 * @param key 参数字段
 */
- (void)addParam:(NSString*)value
          forKey:(NSString*)key{
    if(value == nil || key == nil)
        return;
    if(self.params == nil)
        self.params = [NSMutableDictionary new];
    [self.params setObject:value forKey:key];
}

#pragma mark Get & Set
-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [[NSMutableDictionary alloc]init];
    }
    
    NSLog(@"%@",@([SCUDUtil sharedInstance].islogin));
    
    //根据需求添加用户相关信息
    if ( self.needToken) {

//        [_params setObject:[SCUDUtil sharedInstance].oauth_token forKey:@"oauth_token"];
//        [_params setObject:[SCUDUtil sharedInstance].oauth_token_secret forKey:@"oauth_token_secret"];
        
    }
    
    return _params;
}

-(NSString *)apiVersion{
     return [NSString stringWithFormat:@"v%@",_apiVersion];
}

@end
