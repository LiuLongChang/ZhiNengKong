//
//  Model/PostDelSharingsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostDelSharingsModel.h"

NSString *const kPostDelSharingsModelUN = @"UN";
NSString *const kPostDelSharingsModelAccessToken = @"AccessToken";
NSString *const kPostDelSharingsModelEqID = @"EqID";
NSString *const kPostDelSharingsModelUserID = @"UserID";

@interface PostDelSharingsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostDelSharingsModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize userID = _userID;

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
        self.uN = [self objectOrNilForKey:kPostDelSharingsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostDelSharingsModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostDelSharingsModelEqID fromDictionary:dict];
        self.userID = [self objectOrNilForKey:kPostDelSharingsModelUserID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostDelSharingsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostDelSharingsModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostDelSharingsModelEqID];
	[mutableDict setValue:self.userID forKey:kPostDelSharingsModelUserID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostDelSharingsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostDelSharingsModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostDelSharingsModelEqID];
	self.userID = [aDecoder decodeObjectForKey:kPostDelSharingsModelUserID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostDelSharingsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostDelSharingsModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostDelSharingsModelEqID];
	[aCoder encodeObject:_userID forKey:kPostDelSharingsModelUserID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostDelSharingsModel *copy = [[PostDelSharingsModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.userID = [self.userID copyWithZone:zone];
    }
    
    return copy;
}


@end