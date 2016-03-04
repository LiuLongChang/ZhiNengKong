//
//  Model/Command.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "Command.h"

NSString *const kCommandUserID = @"UserID";
NSString *const kCommandDirection = @"Direction";
NSString *const kCommandID = @"ID";
NSString *const kCommandText = @"Text";
NSString *const kCommandToMessageID = @"ToMessageID";
NSString *const kCommandTime = @"Time";

@interface Command ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Command

@synthesize userID = _userID;
@synthesize direction = _direction;
@synthesize iD = _iD;
@synthesize text = _text;
@synthesize toMessageID = _toMessageID;
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
        self.userID = [self objectOrNilForKey:kCommandUserID fromDictionary:dict];
        self.direction = [self objectOrNilForKey:kCommandDirection fromDictionary:dict];
        self.iD = [self objectOrNilForKey:kCommandID fromDictionary:dict];
        self.text = [self objectOrNilForKey:kCommandText fromDictionary:dict];
        self.toMessageID = [self objectOrNilForKey:kCommandToMessageID fromDictionary:dict];
        long long timestamp = [[self objectOrNilForKey:kCommandTime fromDictionary:dict] longLongValue];
        float floatValue = timestamp /1000.0f;
        self.time = [NSNumber numberWithFloat:floatValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.userID forKey:kCommandUserID];
	[mutableDict setValue:self.direction forKey:kCommandDirection];
	[mutableDict setValue:self.iD forKey:kCommandID];
	[mutableDict setValue:self.text forKey:kCommandText];
	[mutableDict setValue:self.toMessageID forKey:kCommandToMessageID];
	[mutableDict setValue:self.time forKey:kCommandTime];
    
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

	self.userID = [aDecoder decodeObjectForKey:kCommandUserID];
	self.direction = [aDecoder decodeObjectForKey:kCommandDirection];
	self.iD = [aDecoder decodeObjectForKey:kCommandID];
	self.text = [aDecoder decodeObjectForKey:kCommandText];
	self.toMessageID = [aDecoder decodeObjectForKey:kCommandToMessageID];
	self.time = [aDecoder decodeObjectForKey:kCommandTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_userID forKey:kCommandUserID];
	[aCoder encodeObject:_direction forKey:kCommandDirection];
	[aCoder encodeObject:_iD forKey:kCommandID];
	[aCoder encodeObject:_text forKey:kCommandText];
	[aCoder encodeObject:_toMessageID forKey:kCommandToMessageID];
	[aCoder encodeObject:_time forKey:kCommandTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    Command *copy = [[Command alloc] init];
    
    if (copy) {
        
		copy.userID = [self.userID copyWithZone:zone];
		copy.direction = [self.direction copyWithZone:zone];
		copy.iD = [self.iD copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.toMessageID = [self.toMessageID copyWithZone:zone];
		copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end