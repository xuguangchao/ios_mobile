//
//  LoadFaildView.h
//  BOSS-SOOC
//
//  Created by 段帅 on 16/10/22.
//  Copyright © 2016年 Gcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadFaildView : UIView

+(instancetype)shareInstance;

@property (nonatomic, copy) void (^reloadRequest)(void);
@property (nonatomic,strong) NSMutableArray     * request_queue;//请求队列

@end
