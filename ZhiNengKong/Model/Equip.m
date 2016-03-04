//
//  Model/Equip.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "Equip.h"

NSString *const kEquipEqID = @"EqID";
NSString *const kEquipIsOwner = @"IsOwner";
NSString *const kEquipEquipName = @"EquipName";
NSString *const kEquipEquipAlias = @"EquipAlias";
NSString *const kEquipEquipAvatar = @"EquipAvatar";

@interface Equip ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Equip

@synthesize eqID = _eqID;
@synthesize isOwner = _isOwner;
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
        self.eqID = [self objectOrNilForKey:kEquipEqID fromDictionary:dict];
        self.isOwner = [self objectOrNilForKey:kEquipIsOwner fromDictionary:dict];
        self.equipName = [self objectOrNilForKey:kEquipEquipName fromDictionary:dict];
        self.equipAlias = [self objectOrNilForKey:kEquipEquipAlias fromDictionary:dict];
        self.equipAvatar = [self objectOrNilForKey:kEquipEquipAvatar fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.eqID forKey:kEquipEqID];
	[mutableDict setValue:self.isOwner forKey:kEquipIsOwner];
	[mutableDict setValue:self.equipName forKey:kEquipEquipName];
	[mutableDict setValue:self.equipAlias forKey:kEquipEquipAlias];
	[mutableDict setValue:self.equipAvatar forKey:kEquipEquipAvatar];
    
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

	self.eqID = [aDecoder decodeObjectForKey:kEquipEqID];
	self.isOwner = [aDecoder decodeObjectForKey:kEquipIsOwner];
	self.equipName = [aDecoder decodeObjectForKey:kEquipEquipName];
	self.equipAlias = [aDecoder decodeObjectForKey:kEquipEquipAlias];
	self.equipAvatar = [aDecoder decodeObjectForKey:kEquipEquipAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_eqID forKey:kEquipEqID];
	[aCoder encodeObject:_isOwner forKey:kEquipIsOwner];
	[aCoder encodeObject:_equipName forKey:kEquipEquipName];
	[aCoder encodeObject:_equipAlias forKey:kEquipEquipAlias];
	[aCoder encodeObject:_equipAvatar forKey:kEquipEquipAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    Equip *copy = [[Equip alloc] init];
    
    if (copy) {
        
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.isOwner = [self.isOwner copyWithZone:zone];
		copy.equipName = [self.equipName copyWithZone:zone];
		copy.equipAlias = [self.equipAlias copyWithZone:zone];
		copy.equipAvatar = [self.equipAvatar copyWithZone:zone];
    }
    
    return copy;
}


@end