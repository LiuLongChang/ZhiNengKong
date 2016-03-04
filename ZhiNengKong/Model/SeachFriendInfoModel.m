//
//  Model/SeachFriendInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "SeachFriendInfoModel.h"

NSString *const kSeachFriendInfoModelFID = @"FID";
NSString *const kSeachFriendInfoModelPhone = @"Phone";
NSString *const kSeachFriendInfoModelAvatar = @"Avatar";
NSString *const kSeachFriendInfoModelName = @"Name";

@interface SeachFriendInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SeachFriendInfoModel

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
        self.fID = [self objectOrNilForKey:kSeachFriendInfoModelFID fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kSeachFriendInfoModelPhone fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kSeachFriendInfoModelAvatar fromDictionary:dict];
        self.name = [self objectOrNilForKey:kSeachFriendInfoModelName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.fID forKey:kSeachFriendInfoModelFID];
	[mutableDict setValue:self.phone forKey:kSeachFriendInfoModelPhone];
	[mutableDict setValue:self.avatar forKey:kSeachFriendInfoModelAvatar];
	[mutableDict setValue:self.name forKey:kSeachFriendInfoModelName];
    
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

	self.fID = [aDecoder decodeObjectForKey:kSeachFriendInfoModelFID];
	self.phone = [aDecoder decodeObjectForKey:kSeachFriendInfoModelPhone];
	self.avatar = [aDecoder decodeObjectForKey:kSeachFriendInfoModelAvatar];
	self.name = [aDecoder decodeObjectForKey:kSeachFriendInfoModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_fID forKey:kSeachFriendInfoModelFID];
	[aCoder encodeObject:_phone forKey:kSeachFriendInfoModelPhone];
	[aCoder encodeObject:_avatar forKey:kSeachFriendInfoModelAvatar];
	[aCoder encodeObject:_name forKey:kSeachFriendInfoModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    SeachFriendInfoModel *copy = [[SeachFriendInfoModel alloc] init];
    
    if (copy) {
        
		copy.fID = [self.fID copyWithZone:zone];
		copy.phone = [self.phone copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end