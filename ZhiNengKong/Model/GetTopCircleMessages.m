//
//  Model/GetTopCircleMessages.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetTopCircleMessages.h"

NSString *const kGetTopCircleMessagesTopTS = @"TopTS";
NSString *const kGetTopCircleMessagesMessages = @"Messages";
NSString *const kGetTopCircleMessagesMessageUser = @"MessageUser";
NSString *const kGetTopCircleMessagesMessageEquip = @"MessageEquip";

@interface GetTopCircleMessages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetTopCircleMessages

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
        self.topTS = [self objectOrNilForKey:kGetTopCircleMessagesTopTS fromDictionary:dict];
        self.messages = [self objectOrNilForKey:kGetTopCircleMessagesMessages fromDictionary:dict];
        self.messageUser = [self objectOrNilForKey:kGetTopCircleMessagesMessageUser fromDictionary:dict];
        self.messageEquip = [self objectOrNilForKey:kGetTopCircleMessagesMessageEquip fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.topTS forKey:kGetTopCircleMessagesTopTS];
	[mutableDict setValue:self.messages forKey:kGetTopCircleMessagesMessages];
	[mutableDict setValue:self.messageUser forKey:kGetTopCircleMessagesMessageUser];
	[mutableDict setValue:self.messageEquip forKey:kGetTopCircleMessagesMessageEquip];
    
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

	self.topTS = [aDecoder decodeObjectForKey:kGetTopCircleMessagesTopTS];
	self.messages = [aDecoder decodeObjectForKey:kGetTopCircleMessagesMessages];
	self.messageUser = [aDecoder decodeObjectForKey:kGetTopCircleMessagesMessageUser];
	self.messageEquip = [aDecoder decodeObjectForKey:kGetTopCircleMessagesMessageEquip];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_topTS forKey:kGetTopCircleMessagesTopTS];
	[aCoder encodeObject:_messages forKey:kGetTopCircleMessagesMessages];
	[aCoder encodeObject:_messageUser forKey:kGetTopCircleMessagesMessageUser];
	[aCoder encodeObject:_messageEquip forKey:kGetTopCircleMessagesMessageEquip];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetTopCircleMessages *copy = [[GetTopCircleMessages alloc] init];
    
    if (copy) {
        
		copy.topTS = [self.topTS copyWithZone:zone];
		copy.messages = [self.messages copyWithZone:zone];
		copy.messageUser = [self.messageUser copyWithZone:zone];
		copy.messageEquip = [self.messageEquip copyWithZone:zone];
    }
    
    return copy;
}


@end