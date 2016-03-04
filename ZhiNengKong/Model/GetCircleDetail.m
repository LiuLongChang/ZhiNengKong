//
//  Model/GetCircleDetail.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetCircleDetail.h"

NSString *const kGetCircleDetailEqInfo = @"EqInfo";
NSString *const kGetCircleDetailUserInfo = @"UserInfo";

@interface GetCircleDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetCircleDetail

@synthesize eqInfo = _eqInfo;
@synthesize userInfo = _userInfo;

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
        self.eqInfo = [self objectOrNilForKey:kGetCircleDetailEqInfo fromDictionary:dict];
        self.userInfo = [self objectOrNilForKey:kGetCircleDetailUserInfo fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.eqInfo forKey:kGetCircleDetailEqInfo];
	[mutableDict setValue:self.userInfo forKey:kGetCircleDetailUserInfo];
    
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

	self.eqInfo = [aDecoder decodeObjectForKey:kGetCircleDetailEqInfo];
	self.userInfo = [aDecoder decodeObjectForKey:kGetCircleDetailUserInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_eqInfo forKey:kGetCircleDetailEqInfo];
	[aCoder encodeObject:_userInfo forKey:kGetCircleDetailUserInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetCircleDetail *copy = [[GetCircleDetail alloc] init];
    
    if (copy) {
        
		copy.eqInfo = [self.eqInfo copyWithZone:zone];
		copy.userInfo = [self.userInfo copyWithZone:zone];
    }
    
    return copy;
}


@end