//
//  Model/PostAddCircleModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostAddCircleModel.h"

NSString *const kPostAddCircleModelUN = @"UN";
NSString *const kPostAddCircleModelAccessToken = @"AccessToken";
NSString *const kPostAddCircleModelName = @"Name";
NSString *const kPostAddCircleModelEqIDs = @"EqIDs";
NSString *const kPostAddCircleModelUserIDs = @"UserIDs";

@interface PostAddCircleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostAddCircleModel

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
        self.uN = [self objectOrNilForKey:kPostAddCircleModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostAddCircleModelAccessToken fromDictionary:dict];
        self.name = [self objectOrNilForKey:kPostAddCircleModelName fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostAddCircleModelEqIDs fromDictionary:dict];
        self.userIDs = [self objectOrNilForKey:kPostAddCircleModelUserIDs fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostAddCircleModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostAddCircleModelAccessToken];
	[mutableDict setValue:self.name forKey:kPostAddCircleModelName];
	[mutableDict setValue:self.eqIDs forKey:kPostAddCircleModelEqIDs];
	[mutableDict setValue:self.userIDs forKey:kPostAddCircleModelUserIDs];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostAddCircleModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostAddCircleModelAccessToken];
	self.name = [aDecoder decodeObjectForKey:kPostAddCircleModelName];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostAddCircleModelEqIDs];
	self.userIDs = [aDecoder decodeObjectForKey:kPostAddCircleModelUserIDs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostAddCircleModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostAddCircleModelAccessToken];
	[aCoder encodeObject:_name forKey:kPostAddCircleModelName];
	[aCoder encodeObject:_eqIDs forKey:kPostAddCircleModelEqIDs];
	[aCoder encodeObject:_userIDs forKey:kPostAddCircleModelUserIDs];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostAddCircleModel *copy = [[PostAddCircleModel alloc] init];
    
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