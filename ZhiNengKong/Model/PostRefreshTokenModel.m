//
//  Model/PostRefreshTokenModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostRefreshTokenModel.h"

NSString *const kPostRefreshTokenModelUN = @"UN";
NSString *const kPostRefreshTokenModelRefreshToken = @"RefreshToken";

@interface PostRefreshTokenModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostRefreshTokenModel

@synthesize uN = _uN;
@synthesize refreshToken = _refreshToken;

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
        self.uN = [self objectOrNilForKey:kPostRefreshTokenModelUN fromDictionary:dict];
        self.refreshToken = [self objectOrNilForKey:kPostRefreshTokenModelRefreshToken fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostRefreshTokenModelUN];
	[mutableDict setValue:self.refreshToken forKey:kPostRefreshTokenModelRefreshToken];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostRefreshTokenModelUN];
	self.refreshToken = [aDecoder decodeObjectForKey:kPostRefreshTokenModelRefreshToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostRefreshTokenModelUN];
	[aCoder encodeObject:_refreshToken forKey:kPostRefreshTokenModelRefreshToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostRefreshTokenModel *copy = [[PostRefreshTokenModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.refreshToken = [self.refreshToken copyWithZone:zone];
    }
    
    return copy;
}


@end