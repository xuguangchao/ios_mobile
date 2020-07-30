//
//  GC_UserModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/21.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_UserModel : NSObject<NSSecureCoding>

@property(nonatomic,strong)NSString *bigdata;
@property(nonatomic,strong)NSString *discuss;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *face_url;
@property(nonatomic,strong)NSString *has_face;
@property(nonatomic,strong)NSString *identityid;
@property(nonatomic,strong)NSString *identitytype;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *note;
@property(nonatomic,strong)NSString *quicklogin;
@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *schoolid;
@property(nonatomic,strong)NSString *uid;

@end

NS_ASSUME_NONNULL_END
