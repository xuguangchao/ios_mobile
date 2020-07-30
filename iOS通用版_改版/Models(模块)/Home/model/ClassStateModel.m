//
//  ClassStateModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/28.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "ClassStateModel.h"

@implementation ClassStateModel

-(instancetype)initWithDetailDictionary:(NSDictionary*)detailDictionary{
    if (self = [super init]) {
        
        _courseInfoModel = [GC_CourseInfoModel mj_objectWithKeyValues:detailDictionary];
        [self analyseStateFromModel:_courseInfoModel];
        
    }
    
    
    
    return self;
}

+(ClassStateModel*)modelWithDict:(NSDictionary*)dict{
    return [[ClassStateModel alloc]initWithDetailDictionary:dict];
}

-(void)analyseStateFromModel:(GC_CourseInfoModel*)model{
    
    
    if ([model.kcsd intValue]==1) {
        _ClassState = ClassStateUnopen;
        return;
    }
    if ([model.kcls intValue]==1) {
        _ClassState = ClassStateKcls;
        return;
    }
//    if ([[SCUDUtil sharedInstance].isMoney integerValue] == 1) {
//        if (model.is_charge == YES) {
//            if ([model.orderStatus integerValue] != 1) {
//                _ClassState = ClassStateisCharge;
//                return;
//            }
//        }
//    }
    if ([model.select intValue]==1) {
        _ClassState = ClassStateSeleted;
        return;
    }
    if ([model.isAuth intValue] == 0 || [model.isAuth intValue] == 3 || [model.isAuth intValue] == 4) {
        _ClassState = ClassStateisAuth;
        return;
    }
    if ([model.isAuth  intValue]==2) {
        _ClassState = ClassStateEncrypt;
        return;
    }
    if ([model.select intValue]==0) {
        _ClassState = ClassStateUnSelected;
        return;
    }
    
}






-(void)setClassState:(ClassState)ClassState{
    
    if (_ClassState == ClassState) {
        return;
    }else{
        _ClassState = ClassState;
    }
    
    

}

@end
