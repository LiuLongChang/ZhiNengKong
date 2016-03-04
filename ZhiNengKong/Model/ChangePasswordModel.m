//
//  Model/ChangePasswordModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ChangePasswordModel.h"

NSString *const kChangePasswordModelHGUID = @"HGUID";
NSString *const kChangePasswordModelToken = @"Token";

@interface ChangePasswordModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ChangePasswordModel

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
        self.hGUID = [self objectOrNilForKey:kChangePasswordModelHGUID fromDictionary:dict];
        self.token = [[Token alloc] initWithDictionary:[self objectOrNilForKey:kChangePasswordModelToken fromDictionary:dict]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kChangePasswordModelHGUID];
	[mutableDict setValue:self.token forKey:kChangePasswordModelToken];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kChangePasswordModelHGUID];
	self.token = [aDecoder decodeObjectForKey:kChangePasswordModelToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kChangePasswordModelHGUID];
	[aCoder encodeObject:_token forKey:kChangePasswordModelToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    ChangePasswordModel *copy = [[ChangePasswordModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.token = [self.token copyWithZone:zone];
    }
    
    return copy;
}


@end