//
//  Model/LastMessage.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "LastMessage.h"

NSString *const kLastMessageID = @"ID";
NSString *const kLastMessageText = @"Text";
NSString *const kLastMessageTime = @"Time";

@interface LastMessage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LastMessage

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
        self.iD = [self objectOrNilForKey:kLastMessageID fromDictionary:dict];
        self.text = [self objectOrNilForKey:kLastMessageText fromDictionary:dict];
        long long timestamp = [[self objectOrNilForKey:kLastMessageTime fromDictionary:dict] longLongValue];
        float floatValue = timestamp /1000.0f;
        self.time = [NSNumber numberWithFloat:floatValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.iD forKey:kLastMessageID];
	[mutableDict setValue:self.text forKey:kLastMessageText];
	[mutableDict setValue:self.time forKey:kLastMessageTime];
    
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

	self.iD = [aDecoder decodeObjectForKey:kLastMessageID];
	self.text = [aDecoder decodeObjectForKey:kLastMessageText];
	self.time = [aDecoder decodeObjectForKey:kLastMessageTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_iD forKey:kLastMessageID];
	[aCoder encodeObject:_text forKey:kLastMessageText];
	[aCoder encodeObject:_time forKey:kLastMessageTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LastMessage *copy = [[LastMessage alloc] init];
    
    if (copy) {
        
		copy.iD = [self.iD copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end