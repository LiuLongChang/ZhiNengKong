//
//  Model/GetOldCircleMessages.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetOldCircleMessages.h"

NSString *const kGetOldCircleMessagesOldTS = @"OldTS";
NSString *const kGetOldCircleMessagesMessages = @"Messages";
NSString *const kGetOldCircleMessagesMessageUser = @"MessageUser";
NSString *const kGetOldCircleMessagesMessageEquip = @"MessageEquip";

@interface GetOldCircleMessages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetOldCircleMessages

@synthesize oldTS = _oldTS;
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
        self.oldTS = [self objectOrNilForKey:kGetOldCircleMessagesOldTS fromDictionary:dict];
        self.messages = [self objectOrNilForKey:kGetOldCircleMessagesMessages fromDictionary:dict];
        self.messageUser = [self objectOrNilForKey:kGetOldCircleMessagesMessageUser fromDictionary:dict];
        self.messageEquip = [self objectOrNilForKey:kGetOldCircleMessagesMessageEquip fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.oldTS forKey:kGetOldCircleMessagesOldTS];
	[mutableDict setValue:self.messages forKey:kGetOldCircleMessagesMessages];
	[mutableDict setValue:self.messageUser forKey:kGetOldCircleMessagesMessageUser];
	[mutableDict setValue:self.messageEquip forKey:kGetOldCircleMessagesMessageEquip];
    
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

	self.oldTS = [aDecoder decodeObjectForKey:kGetOldCircleMessagesOldTS];
	self.messages = [aDecoder decodeObjectForKey:kGetOldCircleMessagesMessages];
	self.messageUser = [aDecoder decodeObjectForKey:kGetOldCircleMessagesMessageUser];
	self.messageEquip = [aDecoder decodeObjectForKey:kGetOldCircleMessagesMessageEquip];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_oldTS forKey:kGetOldCircleMessagesOldTS];
	[aCoder encodeObject:_messages forKey:kGetOldCircleMessagesMessages];
	[aCoder encodeObject:_messageUser forKey:kGetOldCircleMessagesMessageUser];
	[aCoder encodeObject:_messageEquip forKey:kGetOldCircleMessagesMessageEquip];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetOldCircleMessages *copy = [[GetOldCircleMessages alloc] init];
    
    if (copy) {
        
		copy.oldTS = [self.oldTS copyWithZone:zone];
		copy.messages = [self.messages copyWithZone:zone];
		copy.messageUser = [self.messageUser copyWithZone:zone];
		copy.messageEquip = [self.messageEquip copyWithZone:zone];
    }
    
    return copy;
}


@end