//
//  SCHttpResponse.h
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//  网络请求的返回值封装类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface SCHttpResponse : NSObject

@property (nonatomic, assign) int resultAction;//返回的action值用于区别status为2时是否重新登录

@property (nonatomic, assign) int resultcode;//返回code(指API中的status参数)

@property (nonatomic, strong) NSDictionary *originalDictionary;//原始数据dictionary

@property (nonatomic, strong) NSString *resultMsg;//返回的说明文本(指API中的statusCode参数)

@property (nonatomic, strong) NSDictionary *dictionary;//dictionary结构的内容

@property (nonatomic, strong) NSArray *array;//array结构的内容

@property (nonatomic, strong) NSString *singleResult;//string结构的内容

//@property (nonatomic, strong) AFHTTPRequestOperation *opertaion;

/**
 * 根据data生成返回结果
 *
 * @param data 未知类型数据
 */
- (instancetype)initWithData:(id)data;

/**
 * 根据dictionary生成返回结果
 *
 * @param dict 字典
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 * 判断请求是否出现了错误
 */
- (BOOL)hasError;

@end
