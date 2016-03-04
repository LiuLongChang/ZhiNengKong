//
//  Model/PostGetOldCircleMessagesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetOldCircleMessagesModel.h"

NSString *const kPostGetOldCircleMessagesModelUN = @"UN";
NSString *const kPostGetOldCircleMessagesModelAccessToken = @"AccessToken";
NSString *const kPostGetOldCircleMessagesModelCircleID = @"CircleID";
NSString *const kPostGetOldCircleMessagesModelTS = @"TS";
NSString *const kPostGetOldCircleMessagesModelPageSize = @"PageSize";

@interface PostGetOldCircleMessagesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetOldCircleMessagesModel

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
        self.uN = [self objectOrNilForKey:kPostGetOldCircleMessagesModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetOldCircleMessagesModelAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetOldCircleMessagesModelCircleID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetOldCircleMessagesModelTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetOldCircleMessagesModelPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetOldCircleMessagesModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetOldCircleMessagesModelAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetOldCircleMessagesModelCircleID];
	[mutableDict setValue:self.tS forKey:kPostGetOldCircleMessagesModelTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetOldCircleMessagesModelPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesModelAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesModelCircleID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesModelTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetOldCircleMessagesModelPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetOldCircleMessagesModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetOldCircleMessagesModelAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetOldCircleMessagesModelCircleID];
	[aCoder encodeObject:_tS forKey:kPostGetOldCircleMessagesModelTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetOldCircleMessagesModelPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetOldCircleMessagesModel *copy = [[PostGetOldCircleMessagesModel alloc] init];
    
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