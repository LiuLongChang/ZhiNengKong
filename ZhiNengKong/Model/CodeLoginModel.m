//
//  Model/CodeLoginModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CodeLoginModel.h"

NSString *const kCodeLoginModelHGUID = @"HGUID";
NSString *const kCodeLoginModelToken = @"Token";
NSString *const kCodeLoginModelUserName = @"UserName";

@interface CodeLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CodeLoginModel

@synthesize hGUID = _hGUID;
@synthesize token = _token;
@synthesize userName = _userName;

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
        self.hGUID = [self objectOrNilForKey:kCodeLoginModelHGUID fromDictionary:dict];
        self.token = [[Token alloc] initWithDictionary:[self objectOrNilForKey:kCodeLoginModelToken fromDictionary:dict]];
        self.userName = [self objectOrNilForKey:kCodeLoginModelUserName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kCodeLoginModelHGUID];
	[mutableDict setValue:self.token forKey:kCodeLoginModelToken];
	[mutableDict setValue:self.userName forKey:kCodeLoginModelUserName];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kCodeLoginModelHGUID];
	self.token = [aDecoder decodeObjectForKey:kCodeLoginModelToken];
	self.userName = [aDecoder decodeObjectForKey:kCodeLoginModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kCodeLoginModelHGUID];
	[aCoder encodeObject:_token forKey:kCodeLoginModelToken];
	[aCoder encodeObject:_userName forKey:kCodeLoginModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CodeLoginModel *copy = [[CodeLoginModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.token = [self.token copyWithZone:zone];
		copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end