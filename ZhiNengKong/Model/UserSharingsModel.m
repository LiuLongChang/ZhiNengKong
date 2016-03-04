//
//  Model/UserSharingsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "UserSharingsModel.h"

NSString *const kUserSharingsModelEquip = @"equips";
NSString *const kUserSharingsModelUsers = @"users";

@interface UserSharingsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSharingsModel

@synthesize equip = _equip;
@synthesize users = _users;

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
        self.equip = [self objectOrNilForKey:kUserSharingsModelEquip fromDictionary:dict];
        self.users = [self objectOrNilForKey:kUserSharingsModelUsers fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.equip forKey:kUserSharingsModelEquip];
	[mutableDict setValue:self.users forKey:kUserSharingsModelUsers];
    
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

	self.equip = [aDecoder decodeObjectForKey:kUserSharingsModelEquip];
	self.users = [aDecoder decodeObjectForKey:kUserSharingsModelUsers];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_equip forKey:kUserSharingsModelEquip];
	[aCoder encodeObject:_users forKey:kUserSharingsModelUsers];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSharingsModel *copy = [[UserSharingsModel alloc] init];
    
    if (copy) {
        
		copy.equip = [self.equip copyWithZone:zone];
		copy.users = [self.users copyWithZone:zone];
    }
    
    return copy;
}


@end