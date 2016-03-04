//
//  Model/PostAddCircle.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostAddCircle.h"

NSString *const kPostAddCircleUN = @"UN";
NSString *const kPostAddCircleAccessToken = @"AccessToken";
NSString *const kPostAddCircleName = @"Name";
NSString *const kPostAddCircleEqIDs = @"EqIDs";
NSString *const kPostAddCircleUserIDs = @"UserIDs";

@interface PostAddCircle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostAddCircle

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
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
        self.uN = [self objectOrNilForKey:kPostAddCircleUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostAddCircleAccessToken fromDictionary:dict];
        self.name = [self objectOrNilForKey:kPostAddCircleName fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostAddCircleEqIDs fromDictionary:dict];
        self.userIDs = [self objectOrNilForKey:kPostAddCircleUserIDs fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostAddCircleUN];
	[mutableDict setValue:self.accessToken forKey:kPostAddCircleAccessToken];
	[mutableDict setValue:self.name forKey:kPostAddCircleName];
	[mutableDict setValue:self.eqIDs forKey:kPostAddCircleEqIDs];
	[mutableDict setValue:self.userIDs forKey:kPostAddCircleUserIDs];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostAddCircleUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostAddCircleAccessToken];
	self.name = [aDecoder decodeObjectForKey:kPostAddCircleName];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostAddCircleEqIDs];
	self.userIDs = [aDecoder decodeObjectForKey:kPostAddCircleUserIDs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostAddCircleUN];
	[aCoder encodeObject:_accessToken forKey:kPostAddCircleAccessToken];
	[aCoder encodeObject:_name forKey:kPostAddCircleName];
	[aCoder encodeObject:_eqIDs forKey:kPostAddCircleEqIDs];
	[aCoder encodeObject:_userIDs forKey:kPostAddCircleUserIDs];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostAddCircle *copy = [[PostAddCircle alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
		copy.eqIDs = [self.eqIDs copyWithZone:zone];
		copy.userIDs = [self.userIDs copyWithZone:zone];
    }
    
    return copy;
}


@end