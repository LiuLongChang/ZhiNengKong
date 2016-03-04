//
//  Model/PostSendCircleMessages.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSendCircleMessages.h"

NSString *const kPostSendCircleMessagesUN = @"UN";
NSString *const kPostSendCircleMessagesAccessToken = @"AccessToken";
NSString *const kPostSendCircleMessagesCircleID = @"CircleID";
NSString *const kPostSendCircleMessagesEqIDs = @"EqIDs";
NSString *const kPostSendCircleMessagesText = @"Text";
NSString *const kPostSendCircleMessagesTS = @"TS";

@interface PostSendCircleMessages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSendCircleMessages

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize circleID = _circleID;
@synthesize eqIDs = _eqIDs;
@synthesize text = _text;
@synthesize tS = _tS;

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
        self.uN = [self objectOrNilForKey:kPostSendCircleMessagesUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSendCircleMessagesAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostSendCircleMessagesCircleID fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostSendCircleMessagesEqIDs fromDictionary:dict];
        self.text = [self objectOrNilForKey:kPostSendCircleMessagesText fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostSendCircleMessagesTS fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSendCircleMessagesUN];
	[mutableDict setValue:self.accessToken forKey:kPostSendCircleMessagesAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostSendCircleMessagesCircleID];
	[mutableDict setValue:self.eqIDs forKey:kPostSendCircleMessagesEqIDs];
	[mutableDict setValue:self.text forKey:kPostSendCircleMessagesText];
	[mutableDict setValue:self.tS forKey:kPostSendCircleMessagesTS];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSendCircleMessagesUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSendCircleMessagesAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostSendCircleMessagesCircleID];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostSendCircleMessagesEqIDs];
	self.text = [aDecoder decodeObjectForKey:kPostSendCircleMessagesText];
	self.tS = [aDecoder decodeObjectForKey:kPostSendCircleMessagesTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSendCircleMessagesUN];
	[aCoder encodeObject:_accessToken forKey:kPostSendCircleMessagesAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostSendCircleMessagesCircleID];
	[aCoder encodeObject:_eqIDs forKey:kPostSendCircleMessagesEqIDs];
	[aCoder encodeObject:_text forKey:kPostSendCircleMessagesText];
	[aCoder encodeObject:_tS forKey:kPostSendCircleMessagesTS];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSendCircleMessages *copy = [[PostSendCircleMessages alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.eqIDs = [self.eqIDs copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
    }
    
    return copy;
}


@end