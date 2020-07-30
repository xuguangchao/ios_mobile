//
//  GC_UserModel.m
//  iOS通用版_改版
//
//  Created by 许广超 on 2020/4/21.
//  Copyright © 2020 许广超. All rights reserved.
//

#import "GC_UserModel.h"

@implementation GC_UserModel


+ (BOOL)supportsSecureCoding{
    return YES;
}


//归档的时候调用
//告诉编码器该如何归档
//将这个对象哪些属性编码起来

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.bigdata forKey:@"bigdata"];
    [aCoder encodeObject:self.discuss forKey:@"discuss"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.face_url forKey:@"face_url"];
    [aCoder encodeObject:self.has_face forKey:@"has_face"];
    [aCoder encodeObject:self.identityid forKey:@"identityid"];
    [aCoder encodeObject:self.identitytype forKey:@"identitytype"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.quicklogin forKey:@"quicklogin"];
    [aCoder encodeObject:self.realname forKey:@"realname"];
    [aCoder encodeObject:self.schoolid forKey:@"schoolid"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

//解归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super init]) {
        self.bigdata = [aDecoder decodeObjectForKey:@"bigdata"];
        self.discuss = [aDecoder decodeObjectForKey:@"discuss"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.face_url = [aDecoder decodeObjectForKey:@"face_url"];
        self.has_face = [aDecoder decodeObjectForKey:@"has_face"];
        self.identityid = [aDecoder decodeObjectForKey:@"identityid"];
        self.identitytype = [aDecoder decodeObjectForKey:@"identitytype"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.note = [aDecoder decodeObjectForKey:@"note"];
        self.quicklogin = [aDecoder decodeObjectForKey:@"quicklogin"];
        self.realname = [aDecoder decodeObjectForKey:@"realname"];
        self.schoolid = [aDecoder decodeObjectForKey:@"schoolid"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end

