//
//  Model/GetEquipListModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetEquipListModel.h"

NSString *const kGetEquipListModelEquips = @"Equips";
NSString *const kGetEquipListModelEquipID = @"EquipID";
NSString *const kGetEquipListModelIsUsing = @"IsUsing";

@interface GetEquipListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetEquipListModel

@synthesize equips = _equips;
@synthesize equipID = _equipID;
@synthesize isUsing = _isUsing;

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
        self.equips = [self objectOrNilForKey:kGetEquipListModelEquips fromDictionary:dict];
        self.equipID = [self objectOrNilForKey:kGetEquipListModelEquipID fromDictionary:dict];
        self.isUsing = [self objectOrNilForKey:kGetEquipListModelIsUsing fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.equips forKey:kGetEquipListModelEquips];
	[mutableDict setValue:self.equipID forKey:kGetEquipListModelEquipID];
	[mutableDict setValue:self.isUsing forKey:kGetEquipListModelIsUsing];
    
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

	self.equips = [aDecoder decodeObjectForKey:kGetEquipListModelEquips];
	self.equipID = [aDecoder decodeObjectForKey:kGetEquipListModelEquipID];
	self.isUsing = [aDecoder decodeObjectForKey:kGetEquipListModelIsUsing];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_equips forKey:kGetEquipListModelEquips];
	[aCoder encodeObject:_equipID forKey:kGetEquipListModelEquipID];
	[aCoder encodeObject:_isUsing forKey:kGetEquipListModelIsUsing];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetEquipListModel *copy = [[GetEquipListModel alloc] init];
    
    if (copy) {
        
		copy.equips = [self.equips copyWithZone:zone];
		copy.equipID = [self.equipID copyWithZone:zone];
		copy.isUsing = [self.isUsing copyWithZone:zone];
    }
    
    return copy;
}


@end