//
//  Model/PostSeachFriendInfo.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSeachFriendInfo.h"

NSString *const kPostSeachFriendInfoUN = @"UN";
NSString *const kPostSeachFriendInfoAccessToken = @"AccessToken";
NSString *const kPostSeachFriendInfoIdentifiy = @"Identifiy";

@interface PostSeachFriendInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSeachFriendInfo

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
        self.uN = [self objectOrNilForKey:kPostSeachFriendInfoUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSeachFriendInfoAccessToken fromDictionary:dict];
        self.identifiy = [self objectOrNilForKey:kPostSeachFriendInfoIdentifiy fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSeachFriendInfoUN];
	[mutableDict setValue:self.accessToken forKey:kPostSeachFriendInfoAccessToken];
	[mutableDict setValue:self.identifiy forKey:kPostSeachFriendInfoIdentifiy];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSeachFriendInfoUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSeachFriendInfoAccessToken];
	self.identifiy = [aDecoder decodeObjectForKey:kPostSeachFriendInfoIdentifiy];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSeachFriendInfoUN];
	[aCoder encodeObject:_accessToken forKey:kPostSeachFriendInfoAccessToken];
	[aCoder encodeObject:_identifiy forKey:kPostSeachFriendInfoIdentifiy];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSeachFriendInfo *copy = [[PostSeachFriendInfo alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.identifiy = [self.identifiy copyWithZone:zone];
    }
    
    return copy;
}


@end