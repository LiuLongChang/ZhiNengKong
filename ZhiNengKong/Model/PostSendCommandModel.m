//
//  Model/PostSendCommandModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSendCommandModel.h"

NSString *const kPostSendCommandModelUN = @"UN";
NSString *const kPostSendCommandModelAccessToken = @"AccessToken";
NSString *const kPostSendCommandModelEqID = @"EqID";
NSString *const kPostSendCommandModelText = @"Text";
NSString *const kPostSendCommandModelTS = @"TS";

@interface PostSendCommandModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSendCommandModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize text = _text;
@synthesize tS = _tS;

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
        self.uN = [self objectOrNilForKey:kPostSendCommandModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSendCommandModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostSendCommandModelEqID fromDictionary:dict];
        self.text = [self objectOrNilForKey:kPostSendCommandModelText fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostSendCommandModelTS fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSendCommandModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostSendCommandModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostSendCommandModelEqID];
	[mutableDict setValue:self.text forKey:kPostSendCommandModelText];
	[mutableDict setValue:self.tS forKey:kPostSendCommandModelTS];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSendCommandModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSendCommandModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostSendCommandModelEqID];
	self.text = [aDecoder decodeObjectForKey:kPostSendCommandModelText];
	self.tS = [aDecoder decodeObjectForKey:kPostSendCommandModelTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSendCommandModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostSendCommandModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostSendCommandModelEqID];
	[aCoder encodeObject:_text forKey:kPostSendCommandModelText];
	[aCoder encodeObject:_tS forKey:kPostSendCommandModelTS];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSendCommandModel *copy = [[PostSendCommandModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
    }
    
    return copy;
}


@end