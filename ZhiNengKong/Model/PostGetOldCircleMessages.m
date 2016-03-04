//
//  Model/PostGetOldCircleMessages.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetOldCircleMessages.h"

NSString *const kPostGetOldCircleMessagesUN = @"UN";
NSString *const kPostGetOldCircleMessagesAccessToken = @"AccessToken";
NSString *const kPostGetOldCircleMessagesCircleID = @"CircleID";
NSString *const kPostGetOldCircleMessagesTS = @"TS";
NSString *const kPostGetOldCircleMessagesPageSize = @"PageSize";

@interface PostGetOldCircleMessages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetOldCircleMessages

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
        self.uN = [self objectOrNilForKey:kPostGetOldCircleMessagesUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetOldCircleMessagesAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetOldCircleMessagesCircleID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetOldCircleMessagesTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetOldCircleMessagesPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetOldCircleMessagesUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetOldCircleMessagesAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetOldCircleMessagesCircleID];
	[mutableDict setValue:self.tS forKey:kPostGetOldCircleMessagesTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetOldCircleMessagesPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesCircleID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetOldCircleMessagesUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetOldCircleMessagesAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetOldCircleMessagesCircleID];
	[aCoder encodeObject:_tS forKey:kPostGetOldCircleMessagesTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetOldCircleMessagesPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetOldCircleMessages *copy = [[PostGetOldCircleMessages alloc] init];
    
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