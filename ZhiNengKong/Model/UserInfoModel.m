//
//  Model/UserInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "UserInfoModel.h"

NSString *const kUserInfoModelUserID = @"UserID";
NSString *const kUserInfoModelNickName = @"NickName";
NSString *const kUserInfoModelPhone = @"Phone";
NSString *const kUserInfoModelAvatar = @"Avatar";

@interface UserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfoModel

@synthesize userID = _userID;
@synthesize nickName = _nickName;
@synthesize phone = _phone;
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
        self.userID = [self objectOrNilForKey:kUserInfoModelUserID fromDictionary:dict];
        self.nickName = [self objectOrNilForKey:kUserInfoModelNickName fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kUserInfoModelPhone fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kUserInfoModelAvatar fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.userID forKey:kUserInfoModelUserID];
	[mutableDict setValue:self.nickName forKey:kUserInfoModelNickName];
	[mutableDict setValue:self.phone forKey:kUserInfoModelPhone];
	[mutableDict setValue:self.avatar forKey:kUserInfoModelAvatar];
    
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

	self.userID = [aDecoder decodeObjectForKey:kUserInfoModelUserID];
	self.nickName = [aDecoder decodeObjectForKey:kUserInfoModelNickName];
	self.phone = [aDecoder decodeObjectForKey:kUserInfoModelPhone];
	self.avatar = [aDecoder decodeObjectForKey:kUserInfoModelAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_userID forKey:kUserInfoModelUserID];
	[aCoder encodeObject:_nickName forKey:kUserInfoModelNickName];
	[aCoder encodeObject:_phone forKey:kUserInfoModelPhone];
	[aCoder encodeObject:_avatar forKey:kUserInfoModelAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoModel *copy = [[UserInfoModel alloc] init];
    
    if (copy) {
        
		copy.userID = [self.userID copyWithZone:zone];
		copy.nickName = [self.nickName copyWithZone:zone];
		copy.phone = [self.phone copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
    }
    
    return copy;
}


@end