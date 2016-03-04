//
//  Model/PostRefreshTokenModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostRefreshTokenModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *uN;
@property (nonatomic, strong) NSString *refreshToken;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
