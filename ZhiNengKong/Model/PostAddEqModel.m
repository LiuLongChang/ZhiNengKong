//
//  Model/PostAddEqModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostAddEqModel.h"

NSString *const kPostAddEqModelUN = @"UN";
NSString *const kPostAddEqModelAccessToken = @"AccessToken";
NSString *const kPostAddEqModelEqID = @"EqID";

@interface PostAddEqModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostAddEqModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;

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
        self.uN = [self objectOrNilForKey:kPostAddEqModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostAddEqModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostAddEqModelEqID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostAddEqModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostAddEqModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostAddEqModelEqID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostAddEqModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostAddEqModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostAddEqModelEqID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostAddEqModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostAddEqModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostAddEqModelEqID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostAddEqModel *copy = [[PostAddEqModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
    }
    
    return copy;
}


@end