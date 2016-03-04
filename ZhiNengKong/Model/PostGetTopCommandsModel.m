//
//  Model/PostGetTopCommandsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetTopCommandsModel.h"

NSString *const kPostGetTopCommandsModelUN = @"UN";
NSString *const kPostGetTopCommandsModelAccessToken = @"AccessToken";
NSString *const kPostGetTopCommandsModelEqID = @"EqID";
NSString *const kPostGetTopCommandsModelTS = @"TS";
NSString *const kPostGetTopCommandsModelPageSize = @"PageSize";

@interface PostGetTopCommandsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetTopCommandsModel

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
        self.uN = [self objectOrNilForKey:kPostGetTopCommandsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetTopCommandsModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostGetTopCommandsModelEqID fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostGetTopCommandsModelTS fromDictionary:dict];
        self.pageSize = [self objectOrNilForKey:kPostGetTopCommandsModelPageSize fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetTopCommandsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetTopCommandsModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostGetTopCommandsModelEqID];
	[mutableDict setValue:self.tS forKey:kPostGetTopCommandsModelTS];
	[mutableDict setValue:self.pageSize forKey:kPostGetTopCommandsModelPageSize];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetTopCommandsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetTopCommandsModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostGetTopCommandsModelEqID];
	self.tS = [aDecoder decodeObjectForKey:kPostGetTopCommandsModelTS];
	self.pageSize = [aDecoder decodeObjectForKey:kPostGetTopCommandsModelPageSize];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetTopCommandsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetTopCommandsModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostGetTopCommandsModelEqID];
	[aCoder encodeObject:_tS forKey:kPostGetTopCommandsModelTS];
	[aCoder encodeObject:_pageSize forKey:kPostGetTopCommandsModelPageSize];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetTopCommandsModel *copy = [[PostGetTopCommandsModel alloc] init];
    
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