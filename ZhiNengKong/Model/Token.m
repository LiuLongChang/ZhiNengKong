//
//  Token.m
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "Token.h"


NSString *const kTokenAccessExpire = @"AccessExpire";
NSString *const kTokenRefreshToken = @"RefreshToken";
NSString *const kTokenAccessToken = @"AccessToken";


@interface Token ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Token

@synthesize accessExpire = _accessExpire;
@synthesize refreshToken = _refreshToken;
@synthesize accessToken = _accessToken;


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
            self.accessExpire = [self objectOrNilForKey:kTokenAccessExpire fromDictionary:dict];
            self.refreshToken = [self objectOrNilForKey:kTokenRefreshToken fromDictionary:dict];
            self.accessToken = [self objectOrNilForKey:kTokenAccessToken fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.accessExpire forKey:kTokenAccessExpire];
    [mutableDict setValue:self.refreshToken forKey:kTokenRefreshToken];
    [mutableDict setValue:self.accessToken forKey:kTokenAccessToken];

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

    self.accessExpire = [aDecoder decodeObjectForKey:kTokenAccessExpire];
    self.refreshToken = [aDecoder decodeObjectForKey:kTokenRefreshToken];
    self.accessToken = [aDecoder decodeObjectForKey:kTokenAccessToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_accessExpire forKey:kTokenAccessExpire];
    [aCoder encodeObject:_refreshToken forKey:kTokenRefreshToken];
    [aCoder encodeObject:_accessToken forKey:kTokenAccessToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    Token *copy = [[Token alloc] init];
    
    if (copy) {

        copy.accessExpire = self.accessExpire;
        copy.refreshToken = [self.refreshToken copyWithZone:zone];
        copy.accessToken = [self.accessToken copyWithZone:zone];
    }
    
    return copy;
}


@end
