//
//  GC_HistoryModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_HistoryModel : CommonModel
/*
 jsd = 0;
 kcid = 5b3c5ee0302b5860652665;
 mlid = 5b3c5ee0475be673815247;
 nrid = 5b4d50a12858f824367346;
 pmlid = 5b3c5ee043e69338622048;
 zsd = 0;
 */
@property(nonatomic,strong)NSString *jsd;
@property(nonatomic,strong)NSString *kcid;
@property(nonatomic,strong)NSString *mlid;
@property(nonatomic,strong)NSString *nrid;
@property(nonatomic,strong)NSString *pmlid;
@property(nonatomic,strong)NSString *zsd;

@end

NS_ASSUME_NONNULL_END
