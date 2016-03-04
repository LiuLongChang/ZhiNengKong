//
//  Model/UserSharingsModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSharingsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *equip;
@property (nonatomic, strong) NSArray *users;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
