//
//  Model/ResetCodeModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ResetCodeModel.h"

NSString *const kResetCodeModelHGUID = @"HGUID";
NSString *const kResetCodeModelToken = @"Token";

@interface ResetCodeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ResetCodeModel

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
        self.hGUID = [self objectOrNilForKey:kResetCodeModelHGUID fromDictionary:dict];
        self.token = [[Token alloc] initWithDictionary:[self objectOrNilForKey:kResetCodeModelToken fromDictionary:dict]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.hGUID forKey:kResetCodeModelHGUID];
	[mutableDict setValue:self.token forKey:kResetCodeModelToken];
    
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

	self.hGUID = [aDecoder decodeObjectForKey:kResetCodeModelHGUID];
	self.token = [aDecoder decodeObjectForKey:kResetCodeModelToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_hGUID forKey:kResetCodeModelHGUID];
	[aCoder encodeObject:_token forKey:kResetCodeModelToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    ResetCodeModel *copy = [[ResetCodeModel alloc] init];
    
    if (copy) {
        
		copy.hGUID = [self.hGUID copyWithZone:zone];
		copy.token = [self.token copyWithZone:zone];
    }
    
    return copy;
}


@end