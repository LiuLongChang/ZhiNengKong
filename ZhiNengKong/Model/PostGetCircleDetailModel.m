//
//  Model/PostGetCircleDetailModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetCircleDetailModel.h"

NSString *const kPostGetCircleDetailModelUN = @"UN";
NSString *const kPostGetCircleDetailModelAccessToken = @"AccessToken";
NSString *const kPostGetCircleDetailModelCircleID = @"CircleID";

@interface PostGetCircleDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetCircleDetailModel

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
        self.uN = [self objectOrNilForKey:kPostGetCircleDetailModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostGetCircleDetailModelAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostGetCircleDetailModelCircleID fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostGetCircleDetailModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostGetCircleDetailModelAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostGetCircleDetailModelCircleID];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostGetCircleDetailModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostGetCircleDetailModelAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostGetCircleDetailModelCircleID];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostGetCircleDetailModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostGetCircleDetailModelAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostGetCircleDetailModelCircleID];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetCircleDetailModel *copy = [[PostGetCircleDetailModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
    }
    
    return copy;
}


@end