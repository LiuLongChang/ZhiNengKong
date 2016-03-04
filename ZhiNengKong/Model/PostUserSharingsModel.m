//
//  Model/PostUserSharingsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUserSharingsModel.h"

NSString *const kPostUserSharingsModelUN = @"UN";
NSString *const kPostUserSharingsModelAccessToken = @"AccessToken";
NSString *const kPostUserSharingsModelEqIDs = @"EqIDs";

@interface PostUserSharingsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUserSharingsModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqIDs = _eqIDs;

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
        self.uN = [self objectOrNilForKey:kPostUserSharingsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUserSharingsModelAccessToken fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostUserSharingsModelEqIDs fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUserSharingsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUserSharingsModelAccessToken];
	[mutableDict setValue:self.eqIDs forKey:kPostUserSharingsModelEqIDs];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUserSharingsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUserSharingsModelAccessToken];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostUserSharingsModelEqIDs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUserSharingsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUserSharingsModelAccessToken];
	[aCoder encodeObject:_eqIDs forKey:kPostUserSharingsModelEqIDs];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUserSharingsModel *copy = [[PostUserSharingsModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqIDs = [self.eqIDs copyWithZone:zone];
    }
    
    return copy;
}


@end