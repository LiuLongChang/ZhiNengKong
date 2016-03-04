//
//  Model/CodeLoginModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface CodeLoginModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *hGUID;
@property (nonatomic, strong) Token *token;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
