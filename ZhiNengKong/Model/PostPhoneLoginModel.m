//
//  Model/PostPhoneLoginModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostPhoneLoginModel.h"

NSString *const kPostPhoneLoginModelphone = @"phone";
NSString *const kPostPhoneLoginModelpassword = @"password";

@interface PostPhoneLoginModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostPhoneLoginModel

@synthesize phone = _phone;
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
        self.phone = [self objectOrNilForKey:kPostPhoneLoginModelphone fromDictionary:dict];
        self.password = [self objectOrNilForKey:kPostPhoneLoginModelpassword fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.phone forKey:kPostPhoneLoginModelphone];
	[mutableDict setValue:self.password forKey:kPostPhoneLoginModelpassword];
    
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

	self.phone = [aDecoder decodeObjectForKey:kPostPhoneLoginModelphone];
	self.password = [aDecoder decodeObjectForKey:kPostPhoneLoginModelpassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_phone forKey:kPostPhoneLoginModelphone];
	[aCoder encodeObject:_password forKey:kPostPhoneLoginModelpassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostPhoneLoginModel *copy = [[PostPhoneLoginModel alloc] init];
    
    if (copy) {
        
		copy.phone = [self.phone copyWithZone:zone];
		copy.password = [self.password copyWithZone:zone];
    }
    
    return copy;
}


@end