//
//  SCToolManager.m
//  SC_Tool
//
//  Created by 段帅 on 16/8/29.
//  Copyright © 2016年 段帅. All rights reserved.
//

#import "SCToolManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "SCHttpRequest.h"
#import <objc/runtime.h>
#import "SCUDUtil.h"
#import "LoadFaildView.h"
#import "JLActionManager.h"



@interface SCToolManager ()
{
    LoadFaildView *_faildView;
    
    SCHttpRequest *_req;
    HttpConnectStartBlock _startBlock;
    HttpConnectSuccessBlock _successBlock;
    HttpConnectFailureBlock _failureBlock;
    HttpConnectFinishBlock _finishBlock;
    
}
@end
@implementation SCToolManager



static void *VcHTTPClient_;

+(instancetype)shareInstance{
//    static SCToolManager *intance = nil;  
//    static dispatch_once_t predicate;  
//    dispatch_once(&predicate, ^{  
//        intance = [[self alloc] init];   
//    });  
//    return intance;  
    SCToolManager *tool = [[SCToolManager alloc]init];
    
    return tool;
     
    
}

+(SCHttpRequest *)shareInstansInitRequestWithAPI:(NSString *)api withPara:(NSDictionary *)para{
    
    
    SCHttpRequest *request = [[SCHttpRequest alloc]initWithApi:api params:para];
    
    return request;
    
}



#pragma mark - 网络请求

- (void)doPOSTConnect:(SCHttpRequest *)req
                start:(HttpConnectStartBlock)startBlock
              success:(HttpConnectSuccessBlock)successBlock
              failure:(HttpConnectFailureBlock)failureBlock
               finish:(HttpConnectFinishBlock)finishBlock{
    
    _req = [[SCHttpRequest alloc]init];
    _req = req;
    _startBlock = startBlock;
    _successBlock = successBlock;
    _failureBlock = failureBlock;
    _finishBlock = finishBlock;
    [self loadRequest];
       
}
- (void)doGETConnect:(SCHttpRequest *)req
                start:(HttpConnectStartBlock)startBlock
              success:(HttpConnectSuccessBlock)successBlock
              failure:(HttpConnectFailureBlock)failureBlock
               finish:(HttpConnectFinishBlock)finishBlock{
    
    _req = [[SCHttpRequest alloc]init];
    _req = req;
    _startBlock = startBlock;
    _successBlock = successBlock;
    _failureBlock = failureBlock;
    _finishBlock = finishBlock;
    [self loadRequestGET];
    
}


-(void)loadRequest{
    
   
    
    [self.HTTPClient doHTTPPost:_req
                          start:^(SCHttpRequest *req) {
                              if (_startBlock) {
                                  
                                  _startBlock(req);
                              }
                          }
                        success:^(SCHttpRequest *req, SCHttpResponse *resp) {
                                [[LoadFaildView shareInstance].request_queue removeObject:self];
                            
                            
                            
                            NSLog(@"%@",resp.originalDictionary);
                            [[LoadFaildView shareInstance] removeFromSuperview];
        [MBProgressHUD hideHUDForView:[LoadFaildView shareInstance] animated:YES];
                            if (resp.resultcode==_failLoginCode && resp.resultAction==_reLoginCode) {
                                
                                if (_finishBlock) {
                                    _finishBlock(req,YES);
                                }
                                [SCUDUtil sharedInstance].islogin = NO;
                                
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                                         message:resp.resultMsg
                                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                                
                                UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    
                                    
                                    
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"relogin" object:nil];
                                    
                                }];
                                
                                [alertController addAction:Action];
                                
                                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController
                                                                                                             animated:YES
                                                                                                           completion:nil];
                            }
                            
                            else if (_successBlock) {
                                _successBlock(req,resp);
                                
                                
                            }
                        }
                        failure:^(SCHttpRequest *req, NSError *error) {
                            //请求失败   将失败的对象加到 请求队列
                            //判断request队列里 有没有self
                            
                              [MBProgressHUD hideHUDForView:[LoadFaildView shareInstance] animated:YES];

                            for (SCToolManager *tool in [LoadFaildView shareInstance].request_queue) {
                                
                                if (self == tool) {
                                    return ;
                                }
                                
                            }
                            //没有
                            
                            [[LoadFaildView shareInstance].request_queue addObject:self];
                           
                            typeof(self) ws = self;
                            
                           // 点击重试 回调  重新放飞请求
                             [LoadFaildView shareInstance].reloadRequest=^(){
                                 // 回调队列  让对象去请求
                                 for (SCToolManager *tool in [LoadFaildView shareInstance].request_queue) {
                                     
                                     [tool loadRequest];
                                     
                                 }
                                
                                 
                                 [MBProgressHUD showHUDAddedTo:[LoadFaildView shareInstance] animated:YES];
                                 
                            };
                            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview: [LoadFaildView shareInstance]];
                            
                            
                            if (_failureBlock) {
                                _failureBlock(req,error);
                            }
                        }
                         finish:^(SCHttpRequest *req, BOOL success) {
                             if (_finishBlock) {
                                 _finishBlock(req,success);
                             }
                         }];

    
    
    
}
-(void)loadRequestGET{
    
    
    
    [self.HTTPClient doHTTPGet:_req
                          start:^(SCHttpRequest *req) {
                              if (_startBlock) {
                                  
                                  _startBlock(req);
                              }
                          }
                        success:^(SCHttpRequest *req, SCHttpResponse *resp) {
                            [[LoadFaildView shareInstance].request_queue removeObject:self];
                            
                            
                            
                            NSLog(@"%@",resp.originalDictionary);
                            [[LoadFaildView shareInstance] removeFromSuperview];
                            [MBProgressHUD hideHUDForView:[LoadFaildView shareInstance] animated:YES];
                            if (resp.resultcode==_failLoginCode && resp.resultAction==_reLoginCode) {
                                
                                if (_finishBlock) {
                                    _finishBlock(req,YES);
                                }
                                [SCUDUtil sharedInstance].islogin = NO;
                                
                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                                         message:resp.resultMsg
                                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                                
                                UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                    
                                    
                                    
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"relogin" object:nil];
                                    
                                }];
                                
                                [alertController addAction:Action];
                                
                                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController
                                                                                                             animated:YES
                                                                                                           completion:nil];
                            }
                            
                            else if (_successBlock) {
                                _successBlock(req,resp);
                                
                                
                            }
                        }
                        failure:^(SCHttpRequest *req, NSError *error) {
                            //请求失败   将失败的对象加到 请求队列
                            //判断request队列里 有没有self
                            
                            [MBProgressHUD hideHUDForView:[LoadFaildView shareInstance] animated:YES];

                            for (SCToolManager *tool in [LoadFaildView shareInstance].request_queue) {
                                
                                if (self == tool) {
                                    return ;
                                }
                                
                            }
                            //没有
                            
                            [[LoadFaildView shareInstance].request_queue addObject:self];
                            
                            typeof(self) ws = self;
                            
                            // 点击重试 回调  重新放飞请求
                            [LoadFaildView shareInstance].reloadRequest=^(){
                                // 回调队列  让对象去请求
                                for (SCToolManager *tool in [LoadFaildView shareInstance].request_queue) {
                                    
                                    [tool loadRequest];
                                    
                                }
                                
                                
                                [MBProgressHUD showHUDAddedTo:[LoadFaildView shareInstance] animated:YES];
                                
                            };
                            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview: [LoadFaildView shareInstance]];
                            
                            
                            if (_failureBlock) {
                                _failureBlock(req,error);
                            }
                        }
                         finish:^(SCHttpRequest *req, BOOL success) {
                             if (_finishBlock) {
                                 _finishBlock(req,success);
                             }
                         }];
    
    
    
    
}



- (void)setHTTPClient:(SCHttpManager *)HTTPClient {
    objc_setAssociatedObject(self, &VcHTTPClient_, HTTPClient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SCHttpManager *)HTTPClient {
    if (!VcHTTPClient_) {
        self.HTTPClient = [[SCHttpManager alloc] init];
    }
    return objc_getAssociatedObject(self, &VcHTTPClient_);
}







#pragma mark - ------SCImageTool
+(UIImage *)imageWithName:(NSString *)name  InBundle:(NSString *)bundle className:(Class)classss{
    UIImage *img = [UIImage imageNamed:name];
    if (!img) {
        NSBundle *bundle1 = [NSBundle bundleForClass:classss];
        NSURL *url = [bundle1 URLForResource:bundle withExtension:@"bundle"];
        if (!url){
            return nil;
        }
        
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
        
        return image;   
    }else{
        return img;
    }
    
}




@end
