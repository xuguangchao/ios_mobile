//
//  GC_CateSubModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/23.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_CateSubModel.h"
#import "GC_CateBtn.h"

@implementation GC_CateSubModel

-(CGFloat)cellHigh{
//    [super cellHigh];
//    NSLog(@"%f",self.cellHigh);
    UIView *view = [[UIView alloc]init];
    
    NSArray *arr = _sub;
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        
        if (i==0) {
            GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(15, 0, 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
            
            button.tag = 10+i;
            
          
            [view addSubview:button];
            
        }else{
            
            GC_CateBtn *button1 = [view viewWithTag:9+i];
            CGFloat buttonWidth = [GC_CateBtn buttonWithtitle:dic[@"xsm"] withNum:[dic[@"count"] stringValue]];
            //获得lable长度  预排版  如果排版长度超过宽度  则另起一行   否则 就接着排
            CGFloat cellWith = CGRectGetMaxX(button1.frame)+10+buttonWidth;
            if (cellWith > SIZEWIDTH -15) {
                //另起一行排版
                GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(button1.frame)+10, 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
                
                button.tag = 10+i;
                
              
                [view addSubview:button];
                
                
                
                
            }else{
                //接着排版
                GC_CateBtn *button = [[GC_CateBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button1.frame)+10, CGRectGetMinY(button1.frame), 0, 0) WithTitle:dic[@"xsm"] WithNum:[dic[@"count"] stringValue]];
                
                button.tag = 10+i;
                
               
                [view addSubview:button];
                
                
                
            }
            
        }
        
        }
    
    GC_CateBtn *lastButton = [view viewWithTag:9+arr.count];
//   self.cellHigh =  CGRectGetMaxY(lastButton.frame)+80;
//    NSLog(@"%f",self.cellHigh);
    return CGRectGetMaxY(lastButton.frame)+80;
    
    
    
    
}
@end
