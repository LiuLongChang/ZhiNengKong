//
//  Model/PostUpdateCircle.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUpdateCircle.h"

NSString *const kPostUpdateCircleUN = @"UN";
NSString *const kPostUpdateCircleAccessToken = @"AccessToken";
NSString *const kPostUpdateCircleCircleID = @"CircleID";
NSString *const kPostUpdateCircleName = @"Name";
NSString *const kPostUpdateCircleEqIDs = @"EqIDs";
NSString *const kPostUpdateCircleUserIDs = @"UserIDs";

@interface PostUpdateCircle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUpdateCircle

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize circleID = _circleID;
@synthesize name = _name;
@synthesize eqIDs = _eqIDs;
@synthesize userIDs = _userIDs;

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
        self.uN = [self objectOrNilForKey:kPostUpdateCircleUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUpdateCircleAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostUpdateCircleCircleID fromDictionary:dict];
        self.name = [self objectOrNilForKey:kPostUpdateCircleName fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostUpdateCircleEqIDs fromDictionary:dict];
        self.userIDs = [self objectOrNilForKey:kPostUpdateCircleUserIDs fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUpdateCircleUN];
	[mutableDict setValue:self.accessToken forKey:kPostUpdateCircleAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostUpdateCircleCircleID];
	[mutableDict setValue:self.name forKey:kPostUpdateCircleName];
	[mutableDict setValue:self.eqIDs forKey:kPostUpdateCircleEqIDs];
	[mutableDict setValue:self.userIDs forKey:kPostUpdateCircleUserIDs];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUpdateCircleUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUpdateCircleAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostUpdateCircleCircleID];
	self.name = [aDecoder decodeObjectForKey:kPostUpdateCircleName];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostUpdateCircleEqIDs];
	self.userIDs = [aDecoder decodeObjectForKey:kPostUpdateCircleUserIDs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUpdateCircleUN];
	[aCoder encodeObject:_accessToken forKey:kPostUpdateCircleAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostUpdateCircleCircleID];
	[aCoder encodeObject:_name forKey:kPostUpdateCircleName];
	[aCoder encodeObject:_eqIDs forKey:kPostUpdateCircleEqIDs];
	[aCoder encodeObject:_userIDs forKey:kPostUpdateCircleUserIDs];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUpdateCircle *copy = [[PostUpdateCircle alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
		copy.eqIDs = [self.eqIDs copyWithZone:zone];
		copy.userIDs = [self.userIDs copyWithZone:zone];
    }
    
    return copy;
}


@end