//
//  Model/GetOldCircleMessagesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetOldCircleMessagesModel.h"

NSString *const kGetOldCircleMessagesModelOldTS = @"OldTS";
NSString *const kGetOldCircleMessagesModelMessages = @"Messages";
NSString *const kGetOldCircleMessagesModelMessageUser = @"MessageUser";
NSString *const kGetOldCircleMessagesModelMessageEquip = @"MessageEquip";

@interface GetOldCircleMessagesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetOldCircleMessagesModel

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
        long long timestamp = [[self objectOrNilForKey:kGetOldCircleMessagesModelOldTS fromDictionary:dict] longLongValue];
        float floatValue = timestamp /1000.0f;
        self.oldTS = [NSNumber numberWithFloat:floatValue];
        self.messages = [self objectOrNilForKey:kGetOldCircleMessagesModelMessages fromDictionary:dict];
        self.messageUser = [self objectOrNilForKey:kGetOldCircleMessagesModelMessageUser fromDictionary:dict];
        self.messageEquip = [self objectOrNilForKey:kGetOldCircleMessagesModelMessageEquip fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.oldTS forKey:kGetOldCircleMessagesModelOldTS];
	[mutableDict setValue:self.messages forKey:kGetOldCircleMessagesModelMessages];
	[mutableDict setValue:self.messageUser forKey:kGetOldCircleMessagesModelMessageUser];
	[mutableDict setValue:self.messageEquip forKey:kGetOldCircleMessagesModelMessageEquip];
    
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

	self.oldTS = [aDecoder decodeObjectForKey:kGetOldCircleMessagesModelOldTS];
	self.messages = [aDecoder decodeObjectForKey:kGetOldCircleMessagesModelMessages];
	self.messageUser = [aDecoder decodeObjectForKey:kGetOldCircleMessagesModelMessageUser];
	self.messageEquip = [aDecoder decodeObjectForKey:kGetOldCircleMessagesModelMessageEquip];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_oldTS forKey:kGetOldCircleMessagesModelOldTS];
	[aCoder encodeObject:_messages forKey:kGetOldCircleMessagesModelMessages];
	[aCoder encodeObject:_messageUser forKey:kGetOldCircleMessagesModelMessageUser];
	[aCoder encodeObject:_messageEquip forKey:kGetOldCircleMessagesModelMessageEquip];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetOldCircleMessagesModel *copy = [[GetOldCircleMessagesModel alloc] init];
    
    if (copy) {
        
		copy.oldTS = [self.oldTS copyWithZone:zone];
		copy.messages = [self.messages copyWithZone:zone];
		copy.messageUser = [self.messageUser copyWithZone:zone];
		copy.messageEquip = [self.messageEquip copyWithZone:zone];
    }
    
    return copy;
}


@end