//
//  SCToolManager.h
//  SC_Tool
//
//  Created by 段帅 on 16/8/29.
//  Copyright © 2016年 段帅. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCHttpRequest.h"
#import "SCAPI.h"
#import "SCHttpUtil.h"
#import "MBProgressHUD.h"

static NSInteger _failLoginCode = 2;
static NSInteger _reLoginCode = 1;

@interface SCToolManager : NSObject

+(instancetype)shareInstance;

/**
  生成request方法
*/

+(SCHttpRequest *)shareInstansInitRequestWithAPI:(NSString *)api withPara:(NSDictionary *)para;

/**
 模块化的image读取方式
 */
+(UIImage *)imageWithName:(NSString *)name InBundle:(NSString *)bundle className:(Class)classss;




/**
 * 请求数据的方法
 *
 * @param req SCHttpRequest实体类
 * @param startBlock 开始请求时需要做的处理
 * @param successBlock 请求成功后需要做的处理
 * @param failureBlock 请求失败后需要做的处理
 * @param finishBlock 请求结束后需要做的处理
 */
- (void)doPOSTConnect:(SCHttpRequest *)req
                start:(HttpConnectStartBlock)startBlock
              success:(HttpConnectSuccessBlock)successBlock
              failure:(HttpConnectFailureBlock)failureBlock
               finish:(HttpConnectFinishBlock)finishBlock;



- (void)doGETConnect:(SCHttpRequest *)req
                start:(HttpConnectStartBlock)startBlock
              success:(HttpConnectSuccessBlock)successBlock
              failure:(HttpConnectFailureBlock)failureBlock
               finish:(HttpConnectFinishBlock)finishBlock;




@end
