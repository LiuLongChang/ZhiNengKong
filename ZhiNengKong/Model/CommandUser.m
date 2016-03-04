//
//  Model/CommandUser.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CommandUser.h"

NSString *const kCommandUserUserID = @"UserID";
NSString *const kCommandUserNickName = @"NickName";
NSString *const kCommandUserUserName = @"UserName";
NSString *const kCommandUserAvatar = @"Avatar";

@interface CommandUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommandUser

@synthesize userID = _userID;
@synthesize nickName = _nickName;
@synthesize userName = _userName;
@synthesize avatar = _avatar;

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
        self.userID = [self objectOrNilForKey:kCommandUserUserID fromDictionary:dict];
        self.nickName = [self objectOrNilForKey:kCommandUserNickName fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kCommandUserUserName fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kCommandUserAvatar fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.userID forKey:kCommandUserUserID];
	[mutableDict setValue:self.nickName forKey:kCommandUserNickName];
	[mutableDict setValue:self.userName forKey:kCommandUserUserName];
	[mutableDict setValue:self.avatar forKey:kCommandUserAvatar];
    
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

	self.userID = [aDecoder decodeObjectForKey:kCommandUserUserID];
	self.nickName = [aDecoder decodeObjectForKey:kCommandUserNickName];
	self.userName = [aDecoder decodeObjectForKey:kCommandUserUserName];
	self.avatar = [aDecoder decodeObjectForKey:kCommandUserAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_userID forKey:kCommandUserUserID];
	[aCoder encodeObject:_nickName forKey:kCommandUserNickName];
	[aCoder encodeObject:_userName forKey:kCommandUserUserName];
	[aCoder encodeObject:_avatar forKey:kCommandUserAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommandUser *copy = [[CommandUser alloc] init];
    
    if (copy) {
        
		copy.userID = [self.userID copyWithZone:zone];
		copy.nickName = [self.nickName copyWithZone:zone];
		copy.userName = [self.userName copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
    }
    
    return copy;
}


@end