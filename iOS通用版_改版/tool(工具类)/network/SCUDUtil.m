//
//  SCUDUtil.m
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//

#import "SCUDUtil.h"
#import "SCToolManager.h"
\
@implementation SCUDUtil
{
    NSUserDefaults *defaults;
}

static SCUDUtil *_instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (id)init {
    if (self = [super init]) {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - Get & Set

- (NSString *)xtdz {
    return [defaults objectForKey:@"xtdz"]?:@"http://edu.sooc.com";
}
-(void)setXtdz:(NSString *)xtdz{
    [SCUDUtil saveObject:xtdz key:@"xtdz"];
}

-(NSString *)oauth_token{
    return [SCUDUtil objectWithKey:@"oauth_token"]?:@"a97da629b098b75c294dffdc3e463904";
}
-(void)setOauth_token:(NSString *)oauth_token{
    [SCUDUtil saveObject:oauth_token key:@"oauth_token"];
}

-(NSString *)oauth_token_secret{
    return [SCUDUtil objectWithKey:@"oauth_token_secret"]?:@"a0d21bd1c3130c0c077ca31d0817d5f2";
}
-(void)setOauth_token_secret:(NSString *)oauth_token_secret{
     [SCUDUtil saveObject:oauth_token_secret key:@"oauth_token_secret"];
}

- (GC_UserModel *)userModel{
    return [SCUDUtil customObjectWithKey:@"userModel"] ?: @"";
}

- (void)setUserModel:(GC_UserModel *)userModel{
    [SCUDUtil saveCustomObject:userModel key:@"userModel"];
}

-(BOOL)islogin{
    return [SCUDUtil boolWithKey:@"loginSucceed"]?:NO;
}
-(void)setIslogin:(BOOL)islogin{
    [SCUDUtil saveBool:islogin key:@"loginSucceed"];
}

-(void)setSqmc:(NSString *)sqmc{
     [SCUDUtil saveObject:sqmc key:@"sqmc"];
}
-(NSString *)sqmc{
//    return [SCUDUtil objectWithKey:@"sqmc"]?:@"这里是没有节点";
    return [SCUDUtil objectWithKey:@"sqmc"]?:@"这里是没有节点";
}
-(void)setEmail:(NSString *)email{
     [SCUDUtil saveObject:email key:@"email"];
}
-(NSString *)email{
     return [SCUDUtil objectWithKey:@"email"]?:@"a0d21bd1c3130c0c077ca31d0817d5f2";
}
-(void)setSnsid:(NSString *)snsid{
      [SCUDUtil saveObject:snsid key:@"snsid"];
}
-(NSString *)snsid{
     return [SCUDUtil objectWithKey:@"snsid"]?:@"a0d21bd1c3130c0c077ca31d0817d5f2";
}

-(void)setCount:(NSString *)count{
    [SCUDUtil saveObject:count key:@"count"];
}
-(NSString *)count{
    return [SCUDUtil objectWithKey:@"count"]?:@"";
    
}
-(void)setPassword:(NSString *)password{
     [SCUDUtil saveObject:password key:@"password"];
}
-(NSString *)password{
     return [SCUDUtil objectWithKey:@"password"]?:@"111111";
    
}

-(void)setIsPlay:(NSString *)isPlay{
     [SCUDUtil saveObject:isPlay key:@"live_plafom"];
}
-(NSString *)isPlay{
     return [SCUDUtil objectWithKey:@"live_plafom"]?:@"0";
}

-(void)setIsMoney:(NSString *)isMoney{
    [SCUDUtil saveObject:isMoney key:@"shoufei_platform"];

}
-(NSString *)isMoney{
     return [SCUDUtil objectWithKey:@"shoufei_platform"]?:@"0";
}


-(void)setUser_message:(NSDictionary *)user_message{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:user_message];
    for (NSString *key in dic.allKeys){
        if ([dic[key]isEqual:[NSNull null]]||dic[key]==nil) {
            [dic setObject:@"" forKey:key];
        }
    }
    
    NSDictionary *oldDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_message"];
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:oldDic];
    [para setValuesForKeysWithDictionary:dic];
    
   
    
    
    
     [SCUDUtil saveObject:para key:@"user_message"];
}
-(NSDictionary *)user_message{
    return [SCUDUtil objectWithKey:@"user_message"]?:@{@"title":@"kong"};
}

#pragma mark - Save Data

/**
 * 保存自定义object的方法
 *
 * @param object 参数
 * @param key 保存的key
 */
+ (void)saveCustomObject:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

/**
 * 保存bool的方法
 *
 * @param value 参数
 * @param key 保存的key
 */
+ (void)saveBool:(BOOL)value key:(NSString*)key {
    if([key length] == 0)
        return;
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * 保存原生object的方法
 *
 * @param value 参数
 * @param key 保存的key
 */
+ (void)saveObject:(id)value key:(NSString *)key {
    if(value == nil)
        return;
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Read Data

+ (BOOL)boolWithKey:(NSString *)key {
    if([key length] == 0)
        return NO;
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (id)objectWithKey:(NSString *)key {
    if([key length] == 0)
        return nil;
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (id)customObjectWithKey:(NSString *)key {
    if([key length] == 0)
        return nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    if(encodedObject == nil)
        return nil;
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

#pragma mark - Other

+ (void)emptyDefaultWithKey:(NSString *)key {
    if([key length] == 0)
        return;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


+(void)getPlatformConfiguration{
    
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:API_GetCourseConfig];
    [[SCToolManager shareInstance]doPOSTConnect:request start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
       
        if ([resp.originalDictionary[@"status"] intValue]==0) {
            NSLog(@"%@",resp.dictionary);
            if (![[SCUDUtil sharedInstance].isMoney intValue] == [resp.dictionary[@"CHARGE_SWITCH"]intValue]) {
                [SCUDUtil sharedInstance].isMoney = resp.dictionary[@"CHARGE_SWITCH"];
                //发送通知 修改收费状态
                [[NSNotificationCenter defaultCenter]postNotificationName:@"isShouFei" object:nil];
                }}else{
            }} failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
        } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
        }];
    
    
    SCHttpRequest *request1 = [[SCHttpRequest alloc]initWithApi:API_live_isLive];
    [[SCToolManager shareInstance]doPOSTConnect:request1 start:^(SCHttpRequest * _Nonnull req) {
        
    } success:^(SCHttpRequest * _Nonnull req, SCHttpResponse * _Nonnull resp) {
        
        if ([resp.originalDictionary[@"status"] intValue]==0) {
            NSLog(@"%@",resp.dictionary);
            if (![[SCUDUtil sharedInstance].isPlay intValue] == [resp.dictionary[@"live_auth"] intValue]) {
                [SCUDUtil sharedInstance].isPlay = resp.dictionary[@"live_auth"];
                //发送通知 修改直播状态
                [[NSNotificationCenter defaultCenter]postNotificationName:@"isLiveing" object:nil];
            }}else{
            }} failure:^(SCHttpRequest * _Nonnull req, NSError * _Nonnull error) {
            } finish:^(SCHttpRequest * _Nonnull req, BOOL success) {
            }];
    
    
    
    
    
}


@end
