//
//  PostGetRegisterVerityCodeModel.h
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PostGetRegisterVerityCodeModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
