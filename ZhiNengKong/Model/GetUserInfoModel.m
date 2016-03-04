//
//  Model/GetUserInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetUserInfoModel.h"

NSString *const kGetUserInfoModelHGUID = @"HGUID";
NSString *const kGetUserInfoModelPhone = @"Phone";
NSString *const kGetUserInfoModelLogo = @"Logo";
NSString *const kGetUserInfoModelUserName = @"UserName";

@interface GetUserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetUserInfoModel

@synthesize hGUID = _hGUID;
@synthesize phone = _phone;
@synthesize logo = _logo;
@synthesize userName = _userName;

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
        self.hGUID = [self objectOrNilForKey:kGetUserInfoModelHGUID fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kGetUserInfoModelPhone fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kGetUserInfoModelLogo fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kGetUserInfoModelUserName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kGetUserInfoModelHGUID];
	[mutableDict setValue:self.phone forKey:kGetUserInfoModelPhone];
	[mutableDict setValue:self.logo forKey:kGetUserInfoModelLogo];
	[mutableDict setValue:self.userName forKey:kGetUserInfoModelUserName];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kGetUserInfoModelHGUID];
	self.phone = [aDecoder decodeObjectForKey:kGetUserInfoModelPhone];
	self.logo = [aDecoder decodeObjectForKey:kGetUserInfoModelLogo];
	self.userName = [aDecoder decodeObjectForKey:kGetUserInfoModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kGetUserInfoModelHGUID];
	[aCoder encodeObject:_phone forKey:kGetUserInfoModelPhone];
	[aCoder encodeObject:_logo forKey:kGetUserInfoModelLogo];
	[aCoder encodeObject:_userName forKey:kGetUserInfoModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetUserInfoModel *copy = [[GetUserInfoModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.phone = [self.phone copyWithZone:zone];
		copy.logo = [self.logo copyWithZone:zone];
		copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end