//
//  CommonModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/9.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "CommonModel.h"
#import <objc/runtime.h>

@implementation CommonModel

+(instancetype)shareInstance{
    static CommonModel *person;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        person=[[self alloc]init];
        
    });
    
    return person;
    
}

- (NSArray *) allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    
    return allNames;
}
#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
- (SEL) creatGetterWithPropertyName: (NSString *) propertyName{
    
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}
#pragma mark - ------set方法
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName{
    
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString([NSString stringWithFormat:@"set%@",propertyName]);
}

- (BOOL) displayCurrentModleProperty{
    
    //获取实体类的属性名
    NSArray *array = [self allPropertyNames];
    
    //拼接参数
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < array.count; i ++) {
        
        //获取get方法
        SEL getSel = [self creatGetterWithPropertyName:array[i]];
        
        if ([self respondsToSelector:getSel]) {
            
            //获得类和方法的签名
            NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
            
            //从签名获得调用对象
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            
            //设置target
            [invocation setTarget:self];
            
            //设置selector
            [invocation setSelector:getSel];
            
            //接收返回的值
            NSObject *__unsafe_unretained returnValue = nil;
            
            //调用
            [invocation invoke];
            
            //接收返回值
            [invocation getReturnValue:&returnValue];
            
            NSLog(@"%@",returnValue);
            if (returnValue==nil||[returnValue isEqual:@""]) {
                return NO;
            }
            
            [resultString appendFormat:@"%@\n", returnValue];
        }
    }
    return YES;
    
}
-(CGFloat)cellHigh{
    
    if (!_cellHigh) {
        return 217/2;
    }
    return _cellHigh;
    
}

- (NSDictionary *)modelTransToDic{
    
    //获取实体类的属性名
    NSArray *array = [self allPropertyNames];
    
    //拼接参数
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < array.count; i ++) {
        
        //获取get方法
        SEL getSel = [self creatGetterWithPropertyName:array[i]];
        
        if ([self respondsToSelector:getSel]) {
            
            //获得类和方法的签名
            NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
            
            //从签名获得调用对象
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            
            //设置target
            [invocation setTarget:self];
            
            //设置selector
            [invocation setSelector:getSel];
            
            //接收返回的值
            NSObject *__unsafe_unretained returnValue = nil;
            
            //调用
            [invocation invoke];
            
            //接收返回值
            [invocation getReturnValue:&returnValue];
            
            
            
            
            
            if ([returnValue isEqual:[NSNull null]]||returnValue==nil||[returnValue isEqual:@""]||returnValue == NULL) {
                //                return dic;
                returnValue = @"";
            }else{
                
                
                
                [dic setObject:returnValue forKey:array[i]];
            }
            // [resultString appendFormat:@"%@\n", returnValue];
        }
    }
    return dic;
    
}

@end
