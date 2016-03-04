//
//  Model/Message.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *equipID;
@property (nonatomic, strong) NSNumber *direction;
@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSNumber *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
