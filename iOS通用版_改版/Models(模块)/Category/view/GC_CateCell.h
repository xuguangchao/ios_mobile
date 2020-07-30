//
//  GC_CateCell.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_CateSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_CateCell : UITableViewCell

@property(nonatomic,strong)GC_CateSubModel *model;
@property (nonatomic, copy) void (^nextController)(NSDictionary *dic,NSString *title);

@end

NS_ASSUME_NONNULL_END
