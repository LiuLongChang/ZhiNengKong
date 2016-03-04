//
//  Model/PostGetLoginCodeModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostGetLoginCodeModel.h"

NSString *const kPostGetLoginCodeModelphone = @"phone";

@interface PostGetLoginCodeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostGetLoginCodeModel

@synthesize phone = _phone;

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
        self.phone = [self objectOrNilForKey:kPostGetLoginCodeModelphone fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.phone forKey:kPostGetLoginCodeModelphone];
    
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

	self.phone = [aDecoder decodeObjectForKey:kPostGetLoginCodeModelphone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_phone forKey:kPostGetLoginCodeModelphone];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostGetLoginCodeModel *copy = [[PostGetLoginCodeModel alloc] init];
    
    if (copy) {
        
		copy.phone = [self.phone copyWithZone:zone];
    }
    
    return copy;
}


@end