//
//  Model/GetTopCircleMessagesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetTopCircleMessagesModel.h"

NSString *const kGetTopCircleMessagesModelTopTS = @"TopTS";
NSString *const kGetTopCircleMessagesModelMessages = @"Messages";
NSString *const kGetTopCircleMessagesModelMessageUser = @"MessageUser";
NSString *const kGetTopCircleMessagesModelMessageEquip = @"MessageEquip";

@interface GetTopCircleMessagesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetTopCircleMessagesModel

@synthesize topTS = _topTS;
@synthesize messages = _messages;
@synthesize messageUser = _messageUser;
@synthesize messageEquip = _messageEquip;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.topTS = [self objectOrNilForKey:kGetTopCircleMessagesModelTopTS fromDictionary:dict];
        self.messages = [self objectOrNilForKey:kGetTopCircleMessagesModelMessages fromDictionary:dict];
        self.messageUser = [self objectOrNilForKey:kGetTopCircleMessagesModelMessageUser fromDictionary:dict];
        self.messageEquip = [self objectOrNilForKey:kGetTopCircleMessagesModelMessageEquip fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.topTS forKey:kGetTopCircleMessagesModelTopTS];
	[mutableDict setValue:self.messages forKey:kGetTopCircleMessagesModelMessages];
	[mutableDict setValue:self.messageUser forKey:kGetTopCircleMessagesModelMessageUser];
	[mutableDict setValue:self.messageEquip forKey:kGetTopCircleMessagesModelMessageEquip];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

	self.topTS = [aDecoder decodeObjectForKey:kGetTopCircleMessagesModelTopTS];
	self.messages = [aDecoder decodeObjectForKey:kGetTopCircleMessagesModelMessages];
	self.messageUser = [aDecoder decodeObjectForKey:kGetTopCircleMessagesModelMessageUser];
	self.messageEquip = [aDecoder decodeObjectForKey:kGetTopCircleMessagesModelMessageEquip];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_topTS forKey:kGetTopCircleMessagesModelTopTS];
	[aCoder encodeObject:_messages forKey:kGetTopCircleMessagesModelMessages];
	[aCoder encodeObject:_messageUser forKey:kGetTopCircleMessagesModelMessageUser];
	[aCoder encodeObject:_messageEquip forKey:kGetTopCircleMessagesModelMessageEquip];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetTopCircleMessagesModel *copy = [[GetTopCircleMessagesModel alloc] init];
    
    if (copy) {
        
		copy.topTS = [self.topTS copyWithZone:zone];
		copy.messages = [self.messages copyWithZone:zone];
		copy.messageUser = [self.messageUser copyWithZone:zone];
		copy.messageEquip = [self.messageEquip copyWithZone:zone];
    }
    
    return copy;
}


@end