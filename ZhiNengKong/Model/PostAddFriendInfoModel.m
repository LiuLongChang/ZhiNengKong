//
//  Model/PostAddFriendInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostAddFriendInfoModel.h"

NSString *const kPostAddFriendInfoModelUN = @"UN";
NSString *const kPostAddFriendInfoModelAccessToken = @"AccessToken";
NSString *const kPostAddFriendInfoModelFID = @"FID";

@interface PostAddFriendInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostAddFriendInfoModel

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
        self.uN = [self objectOrNilForKey:kPostAddFriendInfoModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostAddFriendInfoModelAccessToken fromDictionary:dict];
        self.fID = [self objectOrNilForKey:kPostAddFriendInfoModelFID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostAddFriendInfoModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostAddFriendInfoModelAccessToken];
	[mutableDict setValue:self.fID forKey:kPostAddFriendInfoModelFID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostAddFriendInfoModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostAddFriendInfoModelAccessToken];
	self.fID = [aDecoder decodeObjectForKey:kPostAddFriendInfoModelFID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostAddFriendInfoModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostAddFriendInfoModelAccessToken];
	[aCoder encodeObject:_fID forKey:kPostAddFriendInfoModelFID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostAddFriendInfoModel *copy = [[PostAddFriendInfoModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.fID = [self.fID copyWithZone:zone];
    }
    
    return copy;
}


@end