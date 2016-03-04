//
//  Model/GetCircleDetail.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCircleDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *eqInfo;
@property (nonatomic, strong) NSArray *userInfo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
