//
//  Model/PostGetTopCircleMessages.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetTopCircleMessages.h"

NSString *const kPostGetTopCircleMessagesUN = @"UN";
NSString *const kPostGetTopCircleMessagesAccessToken = @"AccessToken";
NSString *const kPostGetTopCircleMessagesCircleID = @"CircleID";
NSString *const kPostGetTopCircleMessagesTS = @"TS";
NSString *const kPostGetTopCircleMessagesPageSize = @"PageSize";

@interface PostGetTopCircleMessages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetTopCircleMessages

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize circleID = _circleID;
@synthesize tS = _tS;
@synthesize pageSize = _pageSize;

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
        self.uN = [self objectOrNilForKey:kPostGetTopCircleMessagesUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetTopCircleMessagesAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetTopCircleMessagesCircleID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetTopCircleMessagesTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetTopCircleMessagesPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetTopCircleMessagesUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetTopCircleMessagesAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetTopCircleMessagesCircleID];
	[mutableDict setValue:self.tS forKey:kPostGetTopCircleMessagesTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetTopCircleMessagesPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesCircleID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetTopCircleMessagesUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetTopCircleMessagesAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetTopCircleMessagesCircleID];
	[aCoder encodeObject:_tS forKey:kPostGetTopCircleMessagesTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetTopCircleMessagesPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetTopCircleMessages *copy = [[PostGetTopCircleMessages alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
		copy.pageSize = [self.pageSize copyWithZone:zone];
    }
    
    return copy;
}


@end