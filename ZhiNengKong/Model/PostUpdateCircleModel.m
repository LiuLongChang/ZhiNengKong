//
//  Model/PostUpdateCircleModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUpdateCircleModel.h"

NSString *const kPostUpdateCircleModelUN = @"UN";
NSString *const kPostUpdateCircleModelAccessToken = @"AccessToken";
NSString *const kPostUpdateCircleModelCircleID = @"CircleID";
NSString *const kPostUpdateCircleModelName = @"Name";
NSString *const kPostUpdateCircleModelEqIDs = @"EqIDs";
NSString *const kPostUpdateCircleModelUserIDs = @"UserIDs";

@interface PostUpdateCircleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUpdateCircleModel

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
        self.uN = [self objectOrNilForKey:kPostUpdateCircleModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUpdateCircleModelAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostUpdateCircleModelCircleID fromDictionary:dict];
        self.name = [self objectOrNilForKey:kPostUpdateCircleModelName fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostUpdateCircleModelEqIDs fromDictionary:dict];
        self.userIDs = [self objectOrNilForKey:kPostUpdateCircleModelUserIDs fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUpdateCircleModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUpdateCircleModelAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostUpdateCircleModelCircleID];
	[mutableDict setValue:self.name forKey:kPostUpdateCircleModelName];
	[mutableDict setValue:self.eqIDs forKey:kPostUpdateCircleModelEqIDs];
	[mutableDict setValue:self.userIDs forKey:kPostUpdateCircleModelUserIDs];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUpdateCircleModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUpdateCircleModelAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostUpdateCircleModelCircleID];
	self.name = [aDecoder decodeObjectForKey:kPostUpdateCircleModelName];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostUpdateCircleModelEqIDs];
	self.userIDs = [aDecoder decodeObjectForKey:kPostUpdateCircleModelUserIDs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUpdateCircleModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUpdateCircleModelAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostUpdateCircleModelCircleID];
	[aCoder encodeObject:_name forKey:kPostUpdateCircleModelName];
	[aCoder encodeObject:_eqIDs forKey:kPostUpdateCircleModelEqIDs];
	[aCoder encodeObject:_userIDs forKey:kPostUpdateCircleModelUserIDs];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUpdateCircleModel *copy = [[PostUpdateCircleModel alloc] init];
    
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