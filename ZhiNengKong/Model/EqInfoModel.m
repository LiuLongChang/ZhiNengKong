//
//  Model/EqInfoModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EqInfoModel.h"

NSString *const kEqInfoModelUniCode = @"UniCode";
NSString *const kEqInfoModelEqName = @"EqName";
NSString *const kEqInfoModelEqAvatar = @"EqAvatar";

@interface EqInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EqInfoModel

@synthesize uniCode = _uniCode;
@synthesize eqName = _eqName;
@synthesize eqAvatar = _eqAvatar;

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
        self.uniCode = [self objectOrNilForKey:kEqInfoModelUniCode fromDictionary:dict];
        self.eqName = [self objectOrNilForKey:kEqInfoModelEqName fromDictionary:dict];
        self.eqAvatar = [self objectOrNilForKey:kEqInfoModelEqAvatar fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uniCode forKey:kEqInfoModelUniCode];
	[mutableDict setValue:self.eqName forKey:kEqInfoModelEqName];
	[mutableDict setValue:self.eqAvatar forKey:kEqInfoModelEqAvatar];
    
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

	self.uniCode = [aDecoder decodeObjectForKey:kEqInfoModelUniCode];
	self.eqName = [aDecoder decodeObjectForKey:kEqInfoModelEqName];
	self.eqAvatar = [aDecoder decodeObjectForKey:kEqInfoModelEqAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uniCode forKey:kEqInfoModelUniCode];
	[aCoder encodeObject:_eqName forKey:kEqInfoModelEqName];
	[aCoder encodeObject:_eqAvatar forKey:kEqInfoModelEqAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    EqInfoModel *copy = [[EqInfoModel alloc] init];
    
    if (copy) {
        
		copy.uniCode = [self.uniCode copyWithZone:zone];
		copy.eqName = [self.eqName copyWithZone:zone];
		copy.eqAvatar = [self.eqAvatar copyWithZone:zone];
    }
    
    return copy;
}


@end