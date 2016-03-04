//
//  Model/PostGetFriendsListModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetFriendsListModel.h"

NSString *const kPostGetFriendsListModelUN = @"UN";
NSString *const kPostGetFriendsListModelAccessToken = @"AccessToken";

@interface PostGetFriendsListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetFriendsListModel

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
        self.uN = [self objectOrNilForKey:kPostGetFriendsListModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetFriendsListModelAccessToken fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetFriendsListModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetFriendsListModelAccessToken];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetFriendsListModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetFriendsListModelAccessToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetFriendsListModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetFriendsListModelAccessToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetFriendsListModel *copy = [[PostGetFriendsListModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
    }
    
    return copy;
}


@end