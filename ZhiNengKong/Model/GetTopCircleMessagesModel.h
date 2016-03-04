//
//  Model/GetTopCircleMessagesModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTopCircleMessagesModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSNumber *topTS;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) NSArray *messageUser;
@property (nonatomic, strong) NSArray *messageEquip;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
