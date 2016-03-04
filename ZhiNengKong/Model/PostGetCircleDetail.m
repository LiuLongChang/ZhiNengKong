//
//  Model/PostGetCircleDetail.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetCircleDetail.h"

NSString *const kPostGetCircleDetailUN = @"UN";
NSString *const kPostGetCircleDetailAccessToken = @"AccessToken";
NSString *const kPostGetCircleDetailCircleID = @"CircleID";

@interface PostGetCircleDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetCircleDetail

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize circleID = _circleID;

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
        self.uN = [self objectOrNilForKey:kPostGetCircleDetailUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetCircleDetailAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetCircleDetailCircleID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetCircleDetailUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetCircleDetailAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetCircleDetailCircleID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetCircleDetailUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetCircleDetailAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetCircleDetailCircleID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetCircleDetailUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetCircleDetailAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetCircleDetailCircleID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetCircleDetail *copy = [[PostGetCircleDetail alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
    }
    
    return copy;
}


@end