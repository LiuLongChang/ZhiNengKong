//
//  Model/PostAddFriendInfo.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostAddFriendInfo.h"

NSString *const kPostAddFriendInfoUN = @"UN";
NSString *const kPostAddFriendInfoAccessToken = @"AccessToken";
NSString *const kPostAddFriendInfoFID = @"FID";

@interface PostAddFriendInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostAddFriendInfo

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize fID = _fID;

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
        self.uN = [self objectOrNilForKey:kPostAddFriendInfoUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostAddFriendInfoAccessToken fromDictionary:dict];
        self.fID = [self objectOrNilForKey:kPostAddFriendInfoFID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostAddFriendInfoUN];
	[mutableDict setValue:self.accessToken forKey:kPostAddFriendInfoAccessToken];
	[mutableDict setValue:self.fID forKey:kPostAddFriendInfoFID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostAddFriendInfoUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostAddFriendInfoAccessToken];
	self.fID = [aDecoder decodeObjectForKey:kPostAddFriendInfoFID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostAddFriendInfoUN];
	[aCoder encodeObject:_accessToken forKey:kPostAddFriendInfoAccessToken];
	[aCoder encodeObject:_fID forKey:kPostAddFriendInfoFID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostAddFriendInfo *copy = [[PostAddFriendInfo alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.fID = [self.fID copyWithZone:zone];
    }
    
    return copy;
}


@end