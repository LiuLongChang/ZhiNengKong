//
//  Model/PostGetUserInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetUserInfoModel.h"

NSString *const kPostGetUserInfoModelUN = @"UN";
NSString *const kPostGetUserInfoModelAccessToken = @"AccessToken";

@interface PostGetUserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetUserInfoModel

@synthesize uN = _uN;
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
        self.uN = [self objectOrNilForKey:kPostGetUserInfoModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetUserInfoModelAccessToken fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetUserInfoModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetUserInfoModelAccessToken];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetUserInfoModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetUserInfoModelAccessToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetUserInfoModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetUserInfoModelAccessToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetUserInfoModel *copy = [[PostGetUserInfoModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
    }
    
    return copy;
}


@end