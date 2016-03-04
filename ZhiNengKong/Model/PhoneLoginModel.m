//
//  Model/PhoneLoginModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PhoneLoginModel.h"

NSString *const kPhoneLoginModelHGUID = @"HGUID";
NSString *const kPhoneLoginModelToken = @"Token";
NSString *const kPhoneLoginModelUserName = @"UserName";

@interface PhoneLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PhoneLoginModel

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
        self.hGUID = [self objectOrNilForKey:kPhoneLoginModelHGUID fromDictionary:dict];
        self.token = [[Token alloc] initWithDictionary:[self objectOrNilForKey:kPhoneLoginModelToken fromDictionary:dict]];
        self.userName = [self objectOrNilForKey:kPhoneLoginModelUserName fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kPhoneLoginModelHGUID];
	[mutableDict setValue:self.token forKey:kPhoneLoginModelToken];
	[mutableDict setValue:self.userName forKey:kPhoneLoginModelUserName];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kPhoneLoginModelHGUID];
	self.token = [aDecoder decodeObjectForKey:kPhoneLoginModelToken];
	self.userName = [aDecoder decodeObjectForKey:kPhoneLoginModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kPhoneLoginModelHGUID];
	[aCoder encodeObject:_token forKey:kPhoneLoginModelToken];
	[aCoder encodeObject:_userName forKey:kPhoneLoginModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PhoneLoginModel *copy = [[PhoneLoginModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.token = [self.token copyWithZone:zone];
		copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end