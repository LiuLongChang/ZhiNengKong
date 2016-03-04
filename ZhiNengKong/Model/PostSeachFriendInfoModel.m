//
//  Model/PostSeachFriendInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSeachFriendInfoModel.h"

NSString *const kPostSeachFriendInfoModelUN = @"UN";
NSString *const kPostSeachFriendInfoModelAccessToken = @"AccessToken";
NSString *const kPostSeachFriendInfoModelIdentifiy = @"Identifiy";

@interface PostSeachFriendInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSeachFriendInfoModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize identifiy = _identifiy;

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
        self.uN = [self objectOrNilForKey:kPostSeachFriendInfoModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSeachFriendInfoModelAccessToken fromDictionary:dict];
        self.identifiy = [self objectOrNilForKey:kPostSeachFriendInfoModelIdentifiy fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSeachFriendInfoModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostSeachFriendInfoModelAccessToken];
	[mutableDict setValue:self.identifiy forKey:kPostSeachFriendInfoModelIdentifiy];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSeachFriendInfoModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSeachFriendInfoModelAccessToken];
	self.identifiy = [aDecoder decodeObjectForKey:kPostSeachFriendInfoModelIdentifiy];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSeachFriendInfoModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostSeachFriendInfoModelAccessToken];
	[aCoder encodeObject:_identifiy forKey:kPostSeachFriendInfoModelIdentifiy];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSeachFriendInfoModel *copy = [[PostSeachFriendInfoModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.identifiy = [self.identifiy copyWithZone:zone];
    }
    
    return copy;
}


@end