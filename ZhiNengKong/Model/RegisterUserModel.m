//
//  RegisterUserModel.m
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "RegisterUserModel.h"
#import "Token.h"


NSString *const kRegisterUserModelHGUID = @"HGUID";
NSString *const kRegisterUserModelToken = @"Token";


@interface RegisterUserModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegisterUserModel

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
            self.hGUID = [self objectOrNilForKey:kRegisterUserModelHGUID fromDictionary:dict];
            self.token = [Token modelObjectWithDictionary:[dict objectForKey:kRegisterUserModelToken]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.hGUID forKey:kRegisterUserModelHGUID];
    [mutableDict setValue:[self.token dictionaryRepresentation] forKey:kRegisterUserModelToken];

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

    self.hGUID = [aDecoder decodeObjectForKey:kRegisterUserModelHGUID];
    self.token = [aDecoder decodeObjectForKey:kRegisterUserModelToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hGUID forKey:kRegisterUserModelHGUID];
    [aCoder encodeObject:_token forKey:kRegisterUserModelToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegisterUserModel *copy = [[RegisterUserModel alloc] init];
    
    if (copy) {

        copy.hGUID = [self.hGUID copyWithZone:zone];
        copy.token = [self.token copyWithZone:zone];
    }
    
    return copy;
}


@end
