//
//  GC_DetailInfoView.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_DetailInfoView.h"

@interface GC_DetailInfoView()
@property(nonatomic,strong)UITableView *table;
@end

@implementation GC_DetailInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = colordbdbdb;
        
//        self.table = [[UITableView alloc]initWithFrame:frame];
//        [self addSubview:self.table];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.table.frame = self.frame;
}

@end
