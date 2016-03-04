//
//  Model/InvitationResponseModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "InvitationResponseModel.h"

NSString *const kInvitationResponseModelShareID = @"ShareID";
NSString *const kInvitationResponseModelFromUser = @"FromUser";
NSString *const kInvitationResponseModelEqID = @"EqID";
NSString *const kInvitationResponseModelEquipName = @"EquipName";
NSString *const kInvitationResponseModelEquipAlias = @"EquipAlias";
NSString *const kInvitationResponseModelEquipAvatar = @"EquipAvatar";
NSString *const kInvitationResponseModelLastMessage = @"LastMessage";

@interface InvitationResponseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation InvitationResponseModel

@synthesize fromUser = _fromUser;
@synthesize eqID = _eqID;
@synthesize equipName = _equipName;
@synthesize equipAlias = _equipAlias;
@synthesize equipAvatar = _equipAvatar;
@synthesize lastMessage = _lastMessage;

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
        self.shareID = [self objectOrNilForKey:kInvitationResponseModelShareID fromDictionary:dict];
        self.fromUser = [self objectOrNilForKey:kInvitationResponseModelFromUser fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kInvitationResponseModelEqID fromDictionary:dict];
        self.equipName = [self objectOrNilForKey:kInvitationResponseModelEquipName fromDictionary:dict];
        self.equipAlias = [self objectOrNilForKey:kInvitationResponseModelEquipAlias fromDictionary:dict];
        self.equipAvatar = [self objectOrNilForKey:kInvitationResponseModelEquipAvatar fromDictionary:dict];
        self.lastMessage = [[LastMessage alloc] initWithDictionary:[self objectOrNilForKey:kInvitationResponseModelLastMessage fromDictionary:dict]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shareID forKey:kInvitationResponseModelShareID];
	[mutableDict setValue:self.fromUser forKey:kInvitationResponseModelFromUser];
	[mutableDict setValue:self.eqID forKey:kInvitationResponseModelEqID];
	[mutableDict setValue:self.equipName forKey:kInvitationResponseModelEquipName];
	[mutableDict setValue:self.equipAlias forKey:kInvitationResponseModelEquipAlias];
	[mutableDict setValue:self.equipAvatar forKey:kInvitationResponseModelEquipAvatar];
	[mutableDict setValue:self.lastMessage forKey:kInvitationResponseModelLastMessage];
    
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

    self.shareID = [aDecoder decodeObjectForKey:kInvitationResponseModelShareID];
	self.fromUser = [aDecoder decodeObjectForKey:kInvitationResponseModelFromUser];
	self.eqID = [aDecoder decodeObjectForKey:kInvitationResponseModelEqID];
	self.equipName = [aDecoder decodeObjectForKey:kInvitationResponseModelEquipName];
	self.equipAlias = [aDecoder decodeObjectForKey:kInvitationResponseModelEquipAlias];
	self.equipAvatar = [aDecoder decodeObjectForKey:kInvitationResponseModelEquipAvatar];
	self.lastMessage = [aDecoder decodeObjectForKey:kInvitationResponseModelLastMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_shareID forKey:kInvitationResponseModelShareID];
	[aCoder encodeObject:_fromUser forKey:kInvitationResponseModelFromUser];
	[aCoder encodeObject:_eqID forKey:kInvitationResponseModelEqID];
	[aCoder encodeObject:_equipName forKey:kInvitationResponseModelEquipName];
	[aCoder encodeObject:_equipAlias forKey:kInvitationResponseModelEquipAlias];
	[aCoder encodeObject:_equipAvatar forKey:kInvitationResponseModelEquipAvatar];
	[aCoder encodeObject:_lastMessage forKey:kInvitationResponseModelLastMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    InvitationResponseModel *copy = [[InvitationResponseModel alloc] init];
    
    if (copy) {
        
        copy.shareID = [self.shareID copyWithZone:zone];
		copy.fromUser = [self.fromUser copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.equipName = [self.equipName copyWithZone:zone];
		copy.equipAlias = [self.equipAlias copyWithZone:zone];
		copy.equipAvatar = [self.equipAvatar copyWithZone:zone];
		copy.lastMessage = [self.lastMessage copyWithZone:zone];
    }
    
    return copy;
}


@end