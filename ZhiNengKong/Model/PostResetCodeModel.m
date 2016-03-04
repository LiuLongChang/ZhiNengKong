//
//  Model/PostResetCodeModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostResetCodeModel.h"

NSString *const kPostResetCodeModelphone = @"phone";
NSString *const kPostResetCodeModelcode = @"code";
NSString *const kPostResetCodeModelpassword = @"password";

@interface PostResetCodeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostResetCodeModel

@synthesize phone = _phone;
@synthesize code = _code;
@synthesize password = _password;

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
        self.phone = [self objectOrNilForKey:kPostResetCodeModelphone fromDictionary:dict];
        self.code = [self objectOrNilForKey:kPostResetCodeModelcode fromDictionary:dict];
        self.password = [self objectOrNilForKey:kPostResetCodeModelpassword fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.phone forKey:kPostResetCodeModelphone];
	[mutableDict setValue:self.code forKey:kPostResetCodeModelcode];
	[mutableDict setValue:self.password forKey:kPostResetCodeModelpassword];
    
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

	self.phone = [aDecoder decodeObjectForKey:kPostResetCodeModelphone];
	self.code = [aDecoder decodeObjectForKey:kPostResetCodeModelcode];
	self.password = [aDecoder decodeObjectForKey:kPostResetCodeModelpassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_phone forKey:kPostResetCodeModelphone];
	[aCoder encodeObject:_code forKey:kPostResetCodeModelcode];
	[aCoder encodeObject:_password forKey:kPostResetCodeModelpassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostResetCodeModel *copy = [[PostResetCodeModel alloc] init];
    
    if (copy) {
        
		copy.phone = [self.phone copyWithZone:zone];
		copy.code = [self.code copyWithZone:zone];
		copy.password = [self.password copyWithZone:zone];
    }
    
    return copy;
}


@end