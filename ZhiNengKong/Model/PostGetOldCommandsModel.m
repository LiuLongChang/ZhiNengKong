//
//  Model/PostGetOldCommandsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetOldCommandsModel.h"

NSString *const kPostGetOldCommandsModelUN = @"UN";
NSString *const kPostGetOldCommandsModelAccessToken = @"AccessToken";
NSString *const kPostGetOldCommandsModelEqID = @"EqID";
NSString *const kPostGetOldCommandsModelTS = @"TS";
NSString *const kPostGetOldCommandsModelPageSize = @"PageSize";

@interface PostGetOldCommandsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetOldCommandsModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize tS = _tS;
@synthesize pageSize = _pageSize;

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
        self.uN = [self objectOrNilForKey:kPostGetOldCommandsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetOldCommandsModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostGetOldCommandsModelEqID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetOldCommandsModelTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetOldCommandsModelPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetOldCommandsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetOldCommandsModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostGetOldCommandsModelEqID];
	[mutableDict setValue:self.tS forKey:kPostGetOldCommandsModelTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetOldCommandsModelPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetOldCommandsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetOldCommandsModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostGetOldCommandsModelEqID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetOldCommandsModelTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetOldCommandsModelPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetOldCommandsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetOldCommandsModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostGetOldCommandsModelEqID];
	[aCoder encodeObject:_tS forKey:kPostGetOldCommandsModelTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetOldCommandsModelPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetOldCommandsModel *copy = [[PostGetOldCommandsModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
		copy.pageSize = [self.pageSize copyWithZone:zone];
    }
    
    return copy;
}


@end