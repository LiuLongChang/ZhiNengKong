//
//  Model/LastMessage.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastMessage : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSNumber *text;
@property (nonatomic, strong) NSNumber *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
