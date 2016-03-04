//
//  Model/SeachFriendInfo.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "SeachFriendInfo.h"

NSString *const kSeachFriendInfoFID = @"FID";
NSString *const kSeachFriendInfoPhone = @"Phone";
NSString *const kSeachFriendInfoAvatar = @"Avatar";
NSString *const kSeachFriendInfoName = @"Name";

@interface SeachFriendInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SeachFriendInfo

@synthesize fID = _fID;
@synthesize phone = _phone;
@synthesize avatar = _avatar;
@synthesize name = _name;

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
        self.fID = [self objectOrNilForKey:kSeachFriendInfoFID fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kSeachFriendInfoPhone fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kSeachFriendInfoAvatar fromDictionary:dict];
        self.name = [self objectOrNilForKey:kSeachFriendInfoName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.fID forKey:kSeachFriendInfoFID];
	[mutableDict setValue:self.phone forKey:kSeachFriendInfoPhone];
	[mutableDict setValue:self.avatar forKey:kSeachFriendInfoAvatar];
	[mutableDict setValue:self.name forKey:kSeachFriendInfoName];
    
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

	self.fID = [aDecoder decodeObjectForKey:kSeachFriendInfoFID];
	self.phone = [aDecoder decodeObjectForKey:kSeachFriendInfoPhone];
	self.avatar = [aDecoder decodeObjectForKey:kSeachFriendInfoAvatar];
	self.name = [aDecoder decodeObjectForKey:kSeachFriendInfoName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_fID forKey:kSeachFriendInfoFID];
	[aCoder encodeObject:_phone forKey:kSeachFriendInfoPhone];
	[aCoder encodeObject:_avatar forKey:kSeachFriendInfoAvatar];
	[aCoder encodeObject:_name forKey:kSeachFriendInfoName];
}

- (id)copyWithZone:(NSZone *)zone
{
    SeachFriendInfo *copy = [[SeachFriendInfo alloc] init];
    
    if (copy) {
        
		copy.fID = [self.fID copyWithZone:zone];
		copy.phone = [self.phone copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end