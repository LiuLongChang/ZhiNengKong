//
//  Model/PostGetTopCircleMessagesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetTopCircleMessagesModel.h"

NSString *const kPostGetTopCircleMessagesModelUN = @"UN";
NSString *const kPostGetTopCircleMessagesModelAccessToken = @"AccessToken";
NSString *const kPostGetTopCircleMessagesModelCircleID = @"CircleID";
NSString *const kPostGetTopCircleMessagesModelTS = @"TS";
NSString *const kPostGetTopCircleMessagesModelPageSize = @"PageSize";

@interface PostGetTopCircleMessagesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetTopCircleMessagesModel

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
        self.uN = [self objectOrNilForKey:kPostGetTopCircleMessagesModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetTopCircleMessagesModelAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetTopCircleMessagesModelCircleID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetTopCircleMessagesModelTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetTopCircleMessagesModelPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetTopCircleMessagesModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetTopCircleMessagesModelAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetTopCircleMessagesModelCircleID];
	[mutableDict setValue:self.tS forKey:kPostGetTopCircleMessagesModelTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetTopCircleMessagesModelPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesModelAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesModelCircleID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesModelTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetTopCircleMessagesModelPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetTopCircleMessagesModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetTopCircleMessagesModelAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetTopCircleMessagesModelCircleID];
	[aCoder encodeObject:_tS forKey:kPostGetTopCircleMessagesModelTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetTopCircleMessagesModelPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetTopCircleMessagesModel *copy = [[PostGetTopCircleMessagesModel alloc] init];
    
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