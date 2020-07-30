//
//  GC_CourseCell.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/27.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CourseCell.h"
#import "RatingView.h"
#import "UIImageView+WebCache.h"

@interface GC_CourseCell()

@property(nonatomic,strong)UIImageView *bgImg;
@property(nonatomic,strong)UILabel *xueshiL;
@property(nonatomic,strong)UILabel *typeL;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *numL;
@property(nonatomic,strong)RatingView *ratingView;

@end

@implementation GC_CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgImg];
        [self.bgImg addSubview:self.xueshiL];
        [self.bgImg addSubview:self.typeL];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.numL];
        
        _bgImg.whc_TopSpace(15).whc_LeftSpace(15).whc_Size(160, 90);
        _xueshiL.whc_LeftSpace(0).whc_TopSpace(0).whc_Height(18).whc_WidthAuto();
        _typeL.whc_RightSpace(2).whc_TopSpace(2).whc_Height(18).whc_WidthAuto();
        _titleL.whc_LeftSpaceToView(10, _bgImg).whc_TopSpaceEqualView(_bgImg).whc_RightSpace(10).whc_HeightAuto();
        _numL.whc_BottomSpaceEqualView(_bgImg).whc_RightSpace(10).whc_HeightAuto().whc_WidthAuto();
        _nameL.whc_LeftSpaceEqualView(_titleL).whc_BottomSpaceToView(-10, _numL).whc_HeightAuto().whc_WidthAuto();
        
        self.ratingView = [[RatingView alloc]initWithFrame:CGRectMake(190, 90, 70, 12)];
        [self.contentView addSubview:self.ratingView];
        
    }
    return self;
}

-(void)setModel:(GC_CourseModel *)model{

    [_bgImg sd_setImageWithURL:[NSURL URLWithString:model.kcfm] placeholderImage:Img(@"占位图-课程") options:SDWebImageProgressiveDownload];
    _xueshiL.text = [NSString stringWithFormat:@" 学时%@  ",model.kcks];
    
    /**
     学习状态展示标签
     */
    if (model.study_status.integerValue == 0) {
        _typeL.hidden = YES;
    }else if(model.study_status.integerValue == 1){
        _typeL.hidden = NO;
        _typeL.backgroundColor = Color(82, 200, 127);
        _typeL.text = @" 正在学 ";
    }else{
        _typeL.hidden = NO;
        _typeL.backgroundColor = Color_title_black_26;
        _typeL.text = @"  已完成  ";
    }
    
    _titleL.text = model.kcmc;
    _titleL.numberOfLines = 2;
    
    _nameL.text = [NSString stringWithFormat:@"%@  %@",model.kcjs,model.zw];
    _nameL.numberOfLines = 1;
    
    _numL.text = [NSString stringWithFormat:@"%@人学习",model.kcrs];
    _ratingView.rating = model.kcpj.integerValue * 2;
}

- (UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [UIImageView new];
    }
    return _bgImg;
}
- (UILabel *)xueshiL{
    if (!_xueshiL) {
        _xueshiL = [UILabel new];
        _xueshiL.textColor = Color_title_white;
        _xueshiL.font = Fone_title24;
        _xueshiL.backgroundColor = Color_Main;
        _xueshiL.textAlignment = NSTextAlignmentCenter;
    }
    return _xueshiL;
}

- (UILabel *)typeL{
    if (!_typeL) {
        _typeL = [UILabel new];
        _typeL.textColor = Color_title_white;
        _typeL.font = Fone_title24;
        _typeL.textAlignment = NSTextAlignmentCenter;
        _typeL.layer.masksToBounds = YES;
        _typeL.layer.cornerRadius = 3;
    }
    return _typeL;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.textColor = Color_title_black_87;
        _titleL.font = Fone_title28;
    }
    return _titleL;
}

- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [UILabel new];
        _nameL.textColor = Color_title_black_64;
        _nameL.font = Fone_title24;
    }
    return _nameL;
}

- (UILabel *)numL{
    if (!_numL) {
        _numL = [UILabel new];
        _numL.textColor = Color_title_black_64;
        _numL.font = Fone_title24;
    }
    return _numL;
}





















- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
