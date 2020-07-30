//
//  GC_ParamsRequestModel.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GC_ParamsRequestModel : CommonModel

@property(nonatomic,strong)NSString *p;//页
@property(nonatomic,strong)NSString *pageSize;//num
@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSString *pageNo;
@property(nonatomic,strong)NSString *keyword;

@end

NS_ASSUME_NONNULL_END
