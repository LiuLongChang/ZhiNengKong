//
//  Model/Message.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "Message.h"

NSString *const kMessageUserID = @"UserID";
NSString *const kMessageEquipID = @"EquipID";
NSString *const kMessageDirection = @"Direction";
NSString *const kMessageID = @"ID";
NSString *const kMessageText = @"Text";
NSString *const kMessageTime = @"Time";

@interface Message ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Message

@synthesize userID = _userID;
@synthesize equipID = _equipID;
@synthesize direction = _direction;
@synthesize iD = _iD;
@synthesize text = _text;
@synthesize time = _time;

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
        self.userID = [self objectOrNilForKey:kMessageUserID fromDictionary:dict];
        self.equipID = [self objectOrNilForKey:kMessageEquipID fromDictionary:dict];
        self.direction = [self objectOrNilForKey:kMessageDirection fromDictionary:dict];
        self.iD = [self objectOrNilForKey:kMessageID fromDictionary:dict];
        self.text = [self objectOrNilForKey:kMessageText fromDictionary:dict];
        self.time = [self objectOrNilForKey:kMessageTime fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.userID forKey:kMessageUserID];
	[mutableDict setValue:self.equipID forKey:kMessageEquipID];
	[mutableDict setValue:self.direction forKey:kMessageDirection];
	[mutableDict setValue:self.iD forKey:kMessageID];
	[mutableDict setValue:self.text forKey:kMessageText];
	[mutableDict setValue:self.time forKey:kMessageTime];
    
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

	self.userID = [aDecoder decodeObjectForKey:kMessageUserID];
	self.equipID = [aDecoder decodeObjectForKey:kMessageEquipID];
	self.direction = [aDecoder decodeObjectForKey:kMessageDirection];
	self.iD = [aDecoder decodeObjectForKey:kMessageID];
	self.text = [aDecoder decodeObjectForKey:kMessageText];
	self.time = [aDecoder decodeObjectForKey:kMessageTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_userID forKey:kMessageUserID];
	[aCoder encodeObject:_equipID forKey:kMessageEquipID];
	[aCoder encodeObject:_direction forKey:kMessageDirection];
	[aCoder encodeObject:_iD forKey:kMessageID];
	[aCoder encodeObject:_text forKey:kMessageText];
	[aCoder encodeObject:_time forKey:kMessageTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    Message *copy = [[Message alloc] init];
    
    if (copy) {
        
		copy.userID = [self.userID copyWithZone:zone];
		copy.equipID = [self.equipID copyWithZone:zone];
		copy.direction = [self.direction copyWithZone:zone];
		copy.iD = [self.iD copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end