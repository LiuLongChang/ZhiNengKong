//
//  Model/RefreshTokenModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "RefreshTokenModel.h"

NSString *const kRefreshTokenModelHGUID = @"HGUID";
NSString *const kRefreshTokenModelToken = @"Token";

@interface RefreshTokenModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RefreshTokenModel

@synthesize hGUID = _hGUID;
@synthesize token = _token;

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
        self.hGUID = [self objectOrNilForKey:kRefreshTokenModelHGUID fromDictionary:dict];
        self.token = [[Token alloc] initWithDictionary:[self objectOrNilForKey:kRefreshTokenModelToken fromDictionary:dict]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kRefreshTokenModelHGUID];
	[mutableDict setValue:self.token forKey:kRefreshTokenModelToken];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kRefreshTokenModelHGUID];
	self.token = [aDecoder decodeObjectForKey:kRefreshTokenModelToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kRefreshTokenModelHGUID];
	[aCoder encodeObject:_token forKey:kRefreshTokenModelToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    RefreshTokenModel *copy = [[RefreshTokenModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.token = [self.token copyWithZone:zone];
    }
    
    return copy;
}


@end