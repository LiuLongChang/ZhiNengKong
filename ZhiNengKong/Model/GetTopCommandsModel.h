//
//  Model/GetTopCommandsModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTopCommandsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSNumber *recentTS;
@property (nonatomic, strong) NSNumber *oldTS;
@property (nonatomic, strong) NSNumber *leftNumber;
@property (nonatomic, strong) NSArray *commands;
@property (nonatomic, strong) NSArray *users;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
