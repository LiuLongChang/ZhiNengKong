//
//  Model/PostMyEquipsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostMyEquipsModel.h"

NSString *const kPostMyEquipsModelUN = @"UN";
NSString *const kPostMyEquipsModelAccessToken = @"AccessToken";
NSString *const kPostMyEquipsModelTS = @"TS";

@interface PostMyEquipsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostMyEquipsModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize tS = _tS;

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
        self.uN = [self objectOrNilForKey:kPostMyEquipsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostMyEquipsModelAccessToken fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostMyEquipsModelTS fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostMyEquipsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostMyEquipsModelAccessToken];
	[mutableDict setValue:self.tS forKey:kPostMyEquipsModelTS];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostMyEquipsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostMyEquipsModelAccessToken];
	self.tS = [aDecoder decodeObjectForKey:kPostMyEquipsModelTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostMyEquipsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostMyEquipsModelAccessToken];
	[aCoder encodeObject:_tS forKey:kPostMyEquipsModelTS];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostMyEquipsModel *copy = [[PostMyEquipsModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
    }
    
    return copy;
}


@end