//
//  Model/PostDelEqModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostDelEqModel.h"

NSString *const kPostDelEqModelUN = @"UN";
NSString *const kPostDelEqModelAccessToken = @"AccessToken";
NSString *const kPostDelEqModelEqID = @"EqID";
NSString *const kPostDelEqModelPassword = @"Password";

@interface PostDelEqModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostDelEqModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize password = _password;

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
        self.uN = [self objectOrNilForKey:kPostDelEqModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostDelEqModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostDelEqModelEqID fromDictionary:dict];
        self.password = [self objectOrNilForKey:kPostDelEqModelPassword fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostDelEqModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostDelEqModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostDelEqModelEqID];
	[mutableDict setValue:self.password forKey:kPostDelEqModelPassword];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostDelEqModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostDelEqModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostDelEqModelEqID];
	self.password = [aDecoder decodeObjectForKey:kPostDelEqModelPassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostDelEqModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostDelEqModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostDelEqModelEqID];
	[aCoder encodeObject:_password forKey:kPostDelEqModelPassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostDelEqModel *copy = [[PostDelEqModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.password = [self.password copyWithZone:zone];
    }
    
    return copy;
}


@end