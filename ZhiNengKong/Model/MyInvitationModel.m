//
//  Model/MyInvitationModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MyInvitationModel.h"

NSString *const kMyInvitationModelShareID = @"ShareID";
NSString *const kMyInvitationModelFromUser = @"FromUser";
NSString *const kMyInvitationModelShareTime = @"ShareTime";
NSString *const kMyInvitationModelEquipName = @"EquipName";
NSString *const kMyInvitationModelEquipAlias = @"EquipAlias";
NSString *const kMyInvitationModelEquipAvatar = @"EquipAvatar";

@interface MyInvitationModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyInvitationModel

@synthesize shareID = _shareID;
@synthesize fromUser = _fromUser;
@synthesize shareTime = _shareTime;
@synthesize equipName = _equipName;
@synthesize equipAlias = _equipAlias;
@synthesize equipAvatar = _equipAvatar;

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
        self.shareID = [self objectOrNilForKey:kMyInvitationModelShareID fromDictionary:dict];
        self.fromUser = [self objectOrNilForKey:kMyInvitationModelFromUser fromDictionary:dict];
        self.shareTime = [self objectOrNilForKey:kMyInvitationModelShareTime fromDictionary:dict];
        self.equipName = [self objectOrNilForKey:kMyInvitationModelEquipName fromDictionary:dict];
        self.equipAlias = [self objectOrNilForKey:kMyInvitationModelEquipAlias fromDictionary:dict];
        self.equipAvatar = [self objectOrNilForKey:kMyInvitationModelEquipAvatar fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.shareID forKey:kMyInvitationModelShareID];
	[mutableDict setValue:self.fromUser forKey:kMyInvitationModelFromUser];
	[mutableDict setValue:self.shareTime forKey:kMyInvitationModelShareTime];
	[mutableDict setValue:self.equipName forKey:kMyInvitationModelEquipName];
	[mutableDict setValue:self.equipAlias forKey:kMyInvitationModelEquipAlias];
	[mutableDict setValue:self.equipAvatar forKey:kMyInvitationModelEquipAvatar];
    
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

	self.shareID = [aDecoder decodeObjectForKey:kMyInvitationModelShareID];
	self.fromUser = [aDecoder decodeObjectForKey:kMyInvitationModelFromUser];
	self.shareTime = [aDecoder decodeObjectForKey:kMyInvitationModelShareTime];
	self.equipName = [aDecoder decodeObjectForKey:kMyInvitationModelEquipName];
	self.equipAlias = [aDecoder decodeObjectForKey:kMyInvitationModelEquipAlias];
	self.equipAvatar = [aDecoder decodeObjectForKey:kMyInvitationModelEquipAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_shareID forKey:kMyInvitationModelShareID];
	[aCoder encodeObject:_fromUser forKey:kMyInvitationModelFromUser];
	[aCoder encodeObject:_shareTime forKey:kMyInvitationModelShareTime];
	[aCoder encodeObject:_equipName forKey:kMyInvitationModelEquipName];
	[aCoder encodeObject:_equipAlias forKey:kMyInvitationModelEquipAlias];
	[aCoder encodeObject:_equipAvatar forKey:kMyInvitationModelEquipAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyInvitationModel *copy = [[MyInvitationModel alloc] init];
    
    if (copy) {
        
		copy.shareID = [self.shareID copyWithZone:zone];
		copy.fromUser = [self.fromUser copyWithZone:zone];
		copy.shareTime = [self.shareTime copyWithZone:zone];
		copy.equipName = [self.equipName copyWithZone:zone];
		copy.equipAlias = [self.equipAlias copyWithZone:zone];
		copy.equipAvatar = [self.equipAvatar copyWithZone:zone];
    }
    
    return copy;
}


@end