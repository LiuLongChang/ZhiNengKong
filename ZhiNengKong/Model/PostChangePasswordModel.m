//
//  Model/PostChangePasswordModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostChangePasswordModel.h"

NSString *const kPostChangePasswordModelUN = @"UN";
NSString *const kPostChangePasswordModelAccessToken = @"AccessToken";
NSString *const kPostChangePasswordModelOldPassword = @"OldPassword";
NSString *const kPostChangePasswordModelNewPassword = @"NewPassword";

@interface PostChangePasswordModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostChangePasswordModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize oldPassword = _oldPassword;
@synthesize nowPassword = _nowPassword;

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
        self.uN = [self objectOrNilForKey:kPostChangePasswordModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostChangePasswordModelAccessToken fromDictionary:dict];
        self.oldPassword = [self objectOrNilForKey:kPostChangePasswordModelOldPassword fromDictionary:dict];
        self.nowPassword = [self objectOrNilForKey:kPostChangePasswordModelNewPassword fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.uN forKey:kPostChangePasswordModelUN];
    [mutableDict setValue:self.accessToken forKey:kPostChangePasswordModelAccessToken];
    [mutableDict setValue:self.oldPassword forKey:kPostChangePasswordModelOldPassword];
    [mutableDict setValue:self.nowPassword forKey:kPostChangePasswordModelNewPassword];
    
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
    
    self.uN = [aDecoder decodeObjectForKey:kPostChangePasswordModelUN];
    self.accessToken = [aDecoder decodeObjectForKey:kPostChangePasswordModelAccessToken];
    self.oldPassword = [aDecoder decodeObjectForKey:kPostChangePasswordModelOldPassword];
    self.nowPassword = [aDecoder decodeObjectForKey:kPostChangePasswordModelNewPassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_uN forKey:kPostChangePasswordModelUN];
    [aCoder encodeObject:_accessToken forKey:kPostChangePasswordModelAccessToken];
    [aCoder encodeObject:_oldPassword forKey:kPostChangePasswordModelOldPassword];
    [aCoder encodeObject:_nowPassword forKey:kPostChangePasswordModelNewPassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostChangePasswordModel *copy = [[PostChangePasswordModel alloc] init];
    
    if (copy) {
        
        copy.uN = [self.uN copyWithZone:zone];
        copy.accessToken = [self.accessToken copyWithZone:zone];
        copy.oldPassword = [self.oldPassword copyWithZone:zone];
        copy.nowPassword = [self.nowPassword copyWithZone:zone];
    }
    
    return copy;
}


@end