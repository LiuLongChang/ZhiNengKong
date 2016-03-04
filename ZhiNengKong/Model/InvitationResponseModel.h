//
//  Model/InvitationResponseModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LastMessage.h"

@interface InvitationResponseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSNumber *shareID;
@property (nonatomic, strong) NSString *fromUser;
@property (nonatomic, strong) NSString *eqID;
@property (nonatomic, strong) NSString *equipName;
@property (nonatomic, strong) NSString *equipAlias;
@property (nonatomic, strong) NSString *equipAvatar;
@property (nonatomic, strong) LastMessage *lastMessage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
