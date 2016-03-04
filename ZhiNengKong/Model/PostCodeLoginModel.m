//
//  Model/PostCodeLoginModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostCodeLoginModel.h"

NSString *const kPostCodeLoginModelphone = @"phone";
NSString *const kPostCodeLoginModelcode = @"code";

@interface PostCodeLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostCodeLoginModel

@synthesize phone = _phone;
@synthesize code = _code;

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
        self.phone = [self objectOrNilForKey:kPostCodeLoginModelphone fromDictionary:dict];
        self.code = [self objectOrNilForKey:kPostCodeLoginModelcode fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.phone forKey:kPostCodeLoginModelphone];
	[mutableDict setValue:self.code forKey:kPostCodeLoginModelcode];
    
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

	self.phone = [aDecoder decodeObjectForKey:kPostCodeLoginModelphone];
	self.code = [aDecoder decodeObjectForKey:kPostCodeLoginModelcode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_phone forKey:kPostCodeLoginModelphone];
	[aCoder encodeObject:_code forKey:kPostCodeLoginModelcode];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostCodeLoginModel *copy = [[PostCodeLoginModel alloc] init];
    
    if (copy) {
        
		copy.phone = [self.phone copyWithZone:zone];
		copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end