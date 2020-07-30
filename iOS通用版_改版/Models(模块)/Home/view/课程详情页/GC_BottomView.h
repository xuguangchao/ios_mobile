//
//  GC_BottomView.h
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassStateModel.h"
#import "GC_CourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GC_BottomView : UIView

@property(nonatomic,strong)ClassStateModel *stateModel;
@property (nonatomic, copy) void (^playBlockView)(GC_CourseDetailModel *model);

@end

NS_ASSUME_NONNULL_END
