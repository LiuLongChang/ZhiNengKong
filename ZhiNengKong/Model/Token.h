//
//  Token.h
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Token : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) NSNumber *accessExpire;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *accessToken;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
