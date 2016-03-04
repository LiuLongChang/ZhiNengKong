//
//  Model/MessageModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MessageModel.h"

NSString *const kMessageModelUserID = @"UserID";
NSString *const kMessageModelEquipID = @"EquipID";
NSString *const kMessageModelDirection = @"Direction";
NSString *const kMessageModelID = @"ID";
NSString *const kMessageModelText = @"Text";
NSString *const kMessageModelTime = @"Time";

@interface MessageModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MessageModel

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
        self.userID = [self objectOrNilForKey:kMessageModelUserID fromDictionary:dict];
        self.equipID = [self objectOrNilForKey:kMessageModelEquipID fromDictionary:dict];
        self.direction = [self objectOrNilForKey:kMessageModelDirection fromDictionary:dict];
        self.iD = [self objectOrNilForKey:kMessageModelID fromDictionary:dict];
        self.text = [self objectOrNilForKey:kMessageModelText fromDictionary:dict];
        long long timestamp = [[self objectOrNilForKey:kMessageModelTime fromDictionary:dict] longLongValue];
        float floatValue = timestamp /1000.0f;
        self.time = [NSNumber numberWithFloat:floatValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.userID forKey:kMessageModelUserID];
	[mutableDict setValue:self.equipID forKey:kMessageModelEquipID];
	[mutableDict setValue:self.direction forKey:kMessageModelDirection];
	[mutableDict setValue:self.iD forKey:kMessageModelID];
	[mutableDict setValue:self.text forKey:kMessageModelText];
	[mutableDict setValue:self.time forKey:kMessageModelTime];
    
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

	self.userID = [aDecoder decodeObjectForKey:kMessageModelUserID];
	self.equipID = [aDecoder decodeObjectForKey:kMessageModelEquipID];
	self.direction = [aDecoder decodeObjectForKey:kMessageModelDirection];
	self.iD = [aDecoder decodeObjectForKey:kMessageModelID];
	self.text = [aDecoder decodeObjectForKey:kMessageModelText];
	self.time = [aDecoder decodeObjectForKey:kMessageModelTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_userID forKey:kMessageModelUserID];
	[aCoder encodeObject:_equipID forKey:kMessageModelEquipID];
	[aCoder encodeObject:_direction forKey:kMessageModelDirection];
	[aCoder encodeObject:_iD forKey:kMessageModelID];
	[aCoder encodeObject:_text forKey:kMessageModelText];
	[aCoder encodeObject:_time forKey:kMessageModelTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MessageModel *copy = [[MessageModel alloc] init];
    
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