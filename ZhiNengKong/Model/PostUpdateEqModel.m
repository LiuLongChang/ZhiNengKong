//
//  Model/PostUpdateEqModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUpdateEqModel.h"

NSString *const kPostUpdateEqModelUN = @"UN";
NSString *const kPostUpdateEqModelAccessToken = @"AccessToken";
NSString *const kPostUpdateEqModelEqID = @"EqID";
NSString *const kPostUpdateEqModelChanges = @"Changes";

@interface PostUpdateEqModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUpdateEqModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize changes = _changes;

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
        self.uN = [self objectOrNilForKey:kPostUpdateEqModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUpdateEqModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostUpdateEqModelEqID fromDictionary:dict];
        self.changes = [self objectOrNilForKey:kPostUpdateEqModelChanges fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUpdateEqModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUpdateEqModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostUpdateEqModelEqID];
	[mutableDict setValue:self.changes forKey:kPostUpdateEqModelChanges];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUpdateEqModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUpdateEqModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostUpdateEqModelEqID];
	self.changes = [aDecoder decodeObjectForKey:kPostUpdateEqModelChanges];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUpdateEqModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUpdateEqModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostUpdateEqModelEqID];
	[aCoder encodeObject:_changes forKey:kPostUpdateEqModelChanges];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUpdateEqModel *copy = [[PostUpdateEqModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.changes = [self.changes copyWithZone:zone];
    }
    
    return copy;
}


@end