//
//  SCUDUtil.h
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//  将UserDefault存储相关的参数读取方法全部放在此类中, 确保不会产生参数冲突或者参数类型的不确定性

#import <Foundation/Foundation.h>
#import "GC_UserModel.h"

@interface SCUDUtil : NSObject

@property (nonatomic, assign) NSString *xtdz;//节点域名

@property (nonatomic, assign) NSString *oauth_token;

@property (nonatomic, assign) NSString *oauth_token_secret;

@property (nonatomic, assign) BOOL islogin;//是否登录
//用户个人信息
@property (nonatomic,copy) NSString     * count;//登陆用户名
@property (nonatomic,copy) NSString     * password;//登陆用户密码
//将登陆信息保存到本地 key=@“user_message” 通过usermodel单例可以获得保存的信息
@property (nonatomic,strong) NSDictionary     * user_message;



@property (nonatomic,copy) NSString     * isMoney;//是否收费 默认 0 不收费
@property (nonatomic,copy) NSString     * isPlay;//是否有直播 默认 0 没有直播




//企培的节点列表信心  
@property (nonatomic,copy) NSString     *email;//用户账号
@property (nonatomic,copy) NSString     *snsid;//节点标示
@property (nonatomic,copy) NSString     *sqmc;//节点名称
@property (nonatomic,copy) NSString     *soocdz;//无用
@property (nonatomic,copy) NSString     *soocmobile;//节点地址 无用

@property (nonatomic,copy) NSString     *xtlx;//节点类型 无用
@property (nonatomic,copy) NSString     *xtmc;// 无用

@property(nonatomic,copy)GC_UserModel *userModel;


+ (SCUDUtil *)sharedInstance;


/**
 获取节点平台的收费，直播，是否有即使通讯权限  获取地点：1登陆 2 登陆状态下的启动app
 */
+(void)getPlatformConfiguration;



@end
