//
//  Model/GetFriendsListModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetFriendsListModel.h"

NSString *const kGetFriendsListModelFID = @"Fid";
NSString *const kGetFriendsListModelPhone = @"Phone";
NSString *const kGetFriendsListModelAvatar = @"Avatar";
NSString *const kGetFriendsListModelName = @"Name";

@interface GetFriendsListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetFriendsListModel

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
        self.fID = [self objectOrNilForKey:kGetFriendsListModelFID fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kGetFriendsListModelPhone fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kGetFriendsListModelAvatar fromDictionary:dict];
        self.name = [self objectOrNilForKey:kGetFriendsListModelName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.fID forKey:kGetFriendsListModelFID];
	[mutableDict setValue:self.phone forKey:kGetFriendsListModelPhone];
	[mutableDict setValue:self.avatar forKey:kGetFriendsListModelAvatar];
	[mutableDict setValue:self.name forKey:kGetFriendsListModelName];
    
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

	self.fID = [aDecoder decodeObjectForKey:kGetFriendsListModelFID];
	self.phone = [aDecoder decodeObjectForKey:kGetFriendsListModelPhone];
	self.avatar = [aDecoder decodeObjectForKey:kGetFriendsListModelAvatar];
	self.name = [aDecoder decodeObjectForKey:kGetFriendsListModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_fID forKey:kGetFriendsListModelFID];
	[aCoder encodeObject:_phone forKey:kGetFriendsListModelPhone];
	[aCoder encodeObject:_avatar forKey:kGetFriendsListModelAvatar];
	[aCoder encodeObject:_name forKey:kGetFriendsListModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetFriendsListModel *copy = [[GetFriendsListModel alloc] init];
    
    if (copy) {
        
		copy.fID = [self.fID copyWithZone:zone];
		copy.phone = [self.phone copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end