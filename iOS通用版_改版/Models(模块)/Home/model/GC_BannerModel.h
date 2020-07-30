//
//  GC_BannerModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/26.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_BannerModel : CommonModel

/*
 fjid = 58218b574a84a939859870;
 ggw = APPBanner;
 hit = 0;
 id = 13;
 imageurl = "http://files01.soocedu.com/2016-11-08/58218b5747ab6619003721.jpg";
 "input_time" = 1478593370;
 "input_uid" = 1;
 jssj = 0;
 kssj = 0;
 pxh = 0;
 "rec_flag" = 0;
 sftf = 1;
 title = "\U6bcf\U4e2a\U4eba\U7684\U4e16\U754c\U90fd\U662f\U4e00\U4e2a\U5706";
 type = url;
 url = "http://ttytwldx.sooc.com/index.php/course/Index/detail/kcid/58cb452529f82297106857/zid/58cb45252c44c217594866/jid/58cb45252cfae176136101/nrid/58cb45b73e5d6007300924.html";
 */
@property(nonatomic,strong)NSString *fjid;
@property(nonatomic,strong)NSString *ggw;
@property(nonatomic,strong)NSString *hit;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,strong)NSString *input_time;
@property(nonatomic,strong)NSString *input_uid;
@property(nonatomic,strong)NSString *jssj;
@property(nonatomic,strong)NSString *kssj;
@property(nonatomic,strong)NSString *pxh;
@property(nonatomic,strong)NSString *rec_flag;
@property(nonatomic,strong)NSString *sftf;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *url;

@end

NS_ASSUME_NONNULL_END
