//
//  GC_CateCell.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CateCell.h"
#import "GC_CateBtn.h"

@interface GC_CateCell()

@property (nonatomic,strong) UIImageView *image_title;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *image_back;

@end

@implementation GC_CateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    _image_back =[[UIImageView alloc]init];
    _image_title = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 24, 24)];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_image_title.frame)+5, 15, SIZEWIDTH - 60, 24)];
    _title.font = NormalFont(28);
    _title.textColor = Color_title_black_87;
}

- (void)setModel:(GC_CateSubModel *)model{
    _model = model;
    _image_back.frame =CGRectMake(SIZEWIDTH - 86, model.cellHigh - 86,86 , 86);
    _image_back.image =[UIImage imageNamed:model.backImageName];
    _image_title.frame = CGRectMake(15, 15, 24, 24);
    _image_title.image = [UIImage imageNamed:model.imageName];
    _title.text = model.xsm;
    NSArray *arr = model.sub;
    //防止重复加载button   先移除button
    for (UIView *but in self.contentView.subviews) {
        [but removeFromSuperview];
    }
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        
        if (i==0) {
            GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_image_title.frame)+20, 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
            
            button.tag = 10+i;
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            
        }else{
            
            GC_CateBtn *button1 = [self.contentView viewWithTag:9+i];
            CGFloat buttonWidth = [GC_CateBtn buttonWithtitle:dic[@"xsm"] withNum:[dic[@"count"] stringValue]];
            //获得lable长度  预排版  如果排版长度超过宽度  则另起一行   否则 就接着排
            CGFloat cellWith = CGRectGetMaxX(button1.frame)+10+buttonWidth;
            if (cellWith > SIZEWIDTH -15) {
                //另起一行排版
                GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(button1.frame)+10, 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
                
                button.tag = 10+i;
                
                [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:button];

            }else{
                //接着排版
                GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button1.frame)+10, CGRectGetMinY(button1.frame), 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
                
                button.tag = 10+i;
                
                [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:button];

                
            }
        }
    }

    [self.contentView addSubview:_image_title];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_image_back];
}

-(void)clickButton:(UIButton *)button{
    NSArray *arr  = _model.sub;
    if (self.nextController != NULL) {
        self.nextController(arr[button.tag-10],_model.xsm);
    }
}
@end
