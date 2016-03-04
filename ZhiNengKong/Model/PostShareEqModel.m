//
//  Model/PostShareEqModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostShareEqModel.h"

NSString *const kPostShareEqModelUN = @"UN";
NSString *const kPostShareEqModelAccessToken = @"AccessToken";
NSString *const kPostShareEqModelEqID = @"EqID";
NSString *const kPostShareEqModelFriendPhone = @"FriendPhone";
NSString *const kPostShareEqModelMessage = @"Message";

@interface PostShareEqModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostShareEqModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize friendPhone = _friendPhone;
@synthesize message = _message;

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
        self.uN = [self objectOrNilForKey:kPostShareEqModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostShareEqModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostShareEqModelEqID fromDictionary:dict];
        self.friendPhone = [self objectOrNilForKey:kPostShareEqModelFriendPhone fromDictionary:dict];
        self.message = [self objectOrNilForKey:kPostShareEqModelMessage fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostShareEqModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostShareEqModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostShareEqModelEqID];
	[mutableDict setValue:self.friendPhone forKey:kPostShareEqModelFriendPhone];
	[mutableDict setValue:self.message forKey:kPostShareEqModelMessage];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostShareEqModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostShareEqModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostShareEqModelEqID];
	self.friendPhone = [aDecoder decodeObjectForKey:kPostShareEqModelFriendPhone];
	self.message = [aDecoder decodeObjectForKey:kPostShareEqModelMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostShareEqModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostShareEqModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostShareEqModelEqID];
	[aCoder encodeObject:_friendPhone forKey:kPostShareEqModelFriendPhone];
	[aCoder encodeObject:_message forKey:kPostShareEqModelMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostShareEqModel *copy = [[PostShareEqModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.friendPhone = [self.friendPhone copyWithZone:zone];
		copy.message = [self.message copyWithZone:zone];
    }
    
    return copy;
}


@end