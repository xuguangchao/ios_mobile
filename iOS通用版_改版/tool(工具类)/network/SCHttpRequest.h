//
//  SCHttpRequest.h
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//  网络请求的请求值封装类

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface SCHttpRequest : NSObject

@property (nonatomic, strong) NSString *api;//API

@property (nonatomic, strong) NSString *apiVersion;//API版本号

@property (nonatomic, strong) NSMutableDictionary *params;//请求参数

@property (nonatomic, assign) BOOL needToken;//在有用户token的时候,是否需要添加用户token

@property (nonatomic, copy) NSString *loadingMsg; //Set nil if no need loadingView

/**
 * 初始化请求类
 *
 * @param api api
 * warning 默认在有用户token的时候,添加用户token.
 */
- (instancetype)initWithApi:(NSString *)api;
/**
 * 初始化请求类
 *
 * @param api api
 * @param params 参数数组
 * warning 默认在有用户token的时候,添加用户token.
 */
- (instancetype)initWithApi:(NSString *)api
                     params:(NSDictionary*)params;
/**
 * 初始化请求类
 *
 * @param api api
 * @param apiVersion API的版本号
 * @param params 参数数组
 * warning 默认在有用户token的时候,添加用户token.
 */
- (instancetype)initWithApi:(NSString *)api
                    version:(NSString *)apiVersion
                     params:(NSDictionary *)params;

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
                  needToken:(BOOL)isNeed;


/**
 * 添加请求参数
 *
 * @param api api
 * @param key 参数字段
 */
- (void)addParam:(NSString*)value
          forKey:(NSString*)key;

@end
NS_ASSUME_NONNULL_END
