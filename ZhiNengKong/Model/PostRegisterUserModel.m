//
//  PostRegisterUser.m
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostRegisterUserModel.h"


NSString *const kPostRegisterUserPhone = @"Phone";
NSString *const kPostRegisterUserCode = @"Code";
NSString *const kPostRegisterUserPassword = @"Password";


@interface PostRegisterUserModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostRegisterUserModel

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
            self.phone = [self objectOrNilForKey:kPostRegisterUserPhone fromDictionary:dict];
            self.code = [self objectOrNilForKey:kPostRegisterUserCode fromDictionary:dict];
            self.password = [self objectOrNilForKey:kPostRegisterUserPassword fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kPostRegisterUserPhone];
    [mutableDict setValue:self.code forKey:kPostRegisterUserCode];
    [mutableDict setValue:self.password forKey:kPostRegisterUserPassword];

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

    self.phone = [aDecoder decodeObjectForKey:kPostRegisterUserPhone];
    self.code = [aDecoder decodeObjectForKey:kPostRegisterUserCode];
    self.password = [aDecoder decodeObjectForKey:kPostRegisterUserPassword];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kPostRegisterUserPhone];
    [aCoder encodeObject:_code forKey:kPostRegisterUserCode];
    [aCoder encodeObject:_password forKey:kPostRegisterUserPassword];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostRegisterUserModel *copy = [[PostRegisterUserModel alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
    }
    
    return copy;
}


@end
