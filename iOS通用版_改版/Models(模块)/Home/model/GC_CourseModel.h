//
//  GC_CourseModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/27.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CourseModel : CommonModel
/*
 isEncrypt = 0;
 kcfm = "http://jingxiangqn.soocedu.com/2018-02-05/5a77bba5c9092409132263.png";
 kcid = "5a77bbc6b2017899680575_229";
 kcjs = "\U4faf\U60e0\U52e4";
 kcks = "2.5";
 kcls = 1;
 kcmc = "\U56fd\U5bb6\U6587\U5316\U5b89\U5168";
 kcpj = 3;
 kcrs = 0;
 kcsx = 2;
 lastpage = 0;
 "study_status" = 0;
 zjls = "\U4faf\U60e0\U52e4";
 zw = "\U4e2d\U56fd\U5386\U53f2\U552f\U7269\U4e3b\U4e49\U5b66\U4f1a\U4f1a\U957f\U3001\U4e2d\U592e\U201c\U9a6c\U5de5\U7a0b\U201d\U9996\U5e2d\U4e13\U5bb6";
 */

@property(nonatomic,strong)NSString *isEncrypt;
@property(nonatomic,strong)NSString *kcfm;
@property(nonatomic,strong)NSString *kcid;
@property(nonatomic,strong)NSString *kcjs;
@property(nonatomic,strong)NSString *kcks;
@property(nonatomic,strong)NSString *kcls;
@property(nonatomic,strong)NSString *kcmc;
@property(nonatomic,strong)NSString *kcpj;
@property(nonatomic,strong)NSString *kcrs;
@property(nonatomic,strong)NSString *kcsx;
@property(nonatomic,strong)NSString *lastpage;
@property(nonatomic,strong)NSString *study_status;
@property(nonatomic,strong)NSString *zjls;
@property(nonatomic,strong)NSString *zw;

@end

NS_ASSUME_NONNULL_END
