//
//  SCHttpResponse.m
//  sooc-ios_new
//
//  Created by 郭琦 on 16/6/29.
//  Copyright © 2016年 SOOC. All rights reserved.
//

#import "SCHttpResponse.h"

@implementation SCHttpResponse

- (id)initWithData:(id)data {
    self = [super init];
    if(self) {
        //NSDictionary* dic = [NSDictionary dictionaryWithJSONData:data error:nil];
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.originalDictionary = dic;
        
        
        
        id result = [dic objectForKey:@"data"];
        
        if([[result class] isSubclassOfClass:[NSDictionary class]]) {
            self.dictionary = [NSDictionary dictionaryWithDictionary:result];
            
            if([self.dictionary count] == 1) {
                NSArray* keys = self.dictionary.allKeys;
                id value = [self.dictionary objectForKey:keys[0]];
                if(value != nil && [[value class] isSubclassOfClass:[NSArray class]]) {
                    self.array = value;
                }
            }
        }
        else if([[result class] isSubclassOfClass:[NSString class]])
            self.singleResult = result;
        else if([[result class] isSubclassOfClass:[NSArray class]])
            self.array = [[NSArray alloc] initWithArray:result];
        
        self.resultcode = [[dic objectForKey:@"status"] intValue];
        self.resultMsg = [dic objectForKey:@"message"];
        self.resultAction = [[dic objectForKey:@"action"] intValue];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        //NSDictionary* dic = [NSDictionary dictionaryWithJSONData:data error:nil];
        NSDictionary* dic = dict;
        
        self.originalDictionary = dict;
        
        id result = [dic objectForKey:@"data"];
        
        if([[result class] isSubclassOfClass:[NSDictionary class]]) {
            self.dictionary = [NSDictionary dictionaryWithDictionary:result];
            
            self.dictionary = [NSDictionary dictionaryWithDictionary:result];
            
            if([self.dictionary count] == 1) {
                NSArray* keys = self.dictionary.allKeys;
                id value = [self.dictionary objectForKey:keys[0]];
                if(value != nil && [[value class] isSubclassOfClass:[NSArray class]]) {
                    self.array = value;
                }
            }
        }
        else if([[result class] isSubclassOfClass:[NSString class]])
            self.singleResult = result;
        else if([[result class] isSubclassOfClass:[NSArray class]])
            self.array = [[NSArray alloc] initWithArray:result];

        self.resultcode = [[dic objectForKey:@"status"] intValue];
        self.resultMsg = [dic objectForKey:@"message"];
        self.resultAction = [[dic objectForKey:@"action"] intValue];

    }
    return self;
}

- (BOOL)hasError {
    
    BOOL code;
    
    if (self.resultcode == 0) {
        code = NO;
    }else{
        code = YES;
    }
    
    return code;
}

@end
